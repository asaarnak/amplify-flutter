import 'dart:io';
import 'dart:isolate';

import 'package:amplify_analytics_pinpoint_dart/src/impl/flutter_provider_interfaces/path_provider.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

// Code adapted from:
// https://github.com/simolus3/drift/blob/develop/examples/app/lib/database/connection/native.dart

/// Obtains a database connection for running drift in a Dart VM.
///
/// The [NativeDatabase] from drift will synchronously use sqlite3's C APIs.
/// To move synchronous database work off the main thread, we use a
/// [DriftIsolate], which can run queries in a background isolate under the
/// hood.
DatabaseConnection connect(CachedEventsPathProvider? pathProvider) {
  return DatabaseConnection.delayed(Future.sync(() async {
    final dir = await pathProvider!.getApplicationSupportPath();
    final dbPath = p.join(dir.path, 'amplify_flutter_analytics.sqlite');
    //final dbPath = p.join(appDir.path, 'todos.db');

    final receiveDriftIsolate = ReceivePort();
    await Isolate.spawn(_entrypointForDriftIsolate,
        _IsolateStartRequest(receiveDriftIsolate.sendPort, dbPath));

    final driftIsolate = await receiveDriftIsolate.first as DriftIsolate;
    return driftIsolate.connect();
  }));
}

/// The entrypoint of isolates can only take a single message, but we need two
/// (a send port to reach the originating isolate and the database's path that
/// should be opened on the background isolate). So, we bundle this information
/// in a single class.
class _IsolateStartRequest {
  final SendPort talkToMain;
  final String databasePath;

  _IsolateStartRequest(this.talkToMain, this.databasePath);
}

/// The entrypoint for a background isolate launching a drift server.
///
/// The main isolate can then connect to that isolate server to transparently
/// run queries in the background.
void _entrypointForDriftIsolate(_IsolateStartRequest request) {
  // The native database synchronously uses sqlite3's C API with `dart:ffi` for
  // a fast database implementation that doesn't require platform channels.
  final databaseImpl = NativeDatabase(File(request.databasePath));

  // We can use DriftIsolate.inCurrent because this function is the entrypoint
  // of a background isolate itself.
  final driftServer =
      DriftIsolate.inCurrent(() => DatabaseConnection(databaseImpl));

  // Inform the main isolate about the server we just created.
  request.talkToMain.send(driftServer);
}
