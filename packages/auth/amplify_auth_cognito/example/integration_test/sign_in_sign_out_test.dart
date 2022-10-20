/*
 * Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_test/amplify_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'utils/mock_data.dart';
import 'utils/setup_utils.dart';
import 'utils/test_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('signIn (SRP)', () {
    late String username;
    late String password;

    tearDownAll(Amplify.reset);

    setUp(() async {
      await configureAuth();

      // create new user for each test
      username = generateUsername();
      password = generatePassword();

      await adminCreateUser(
        username,
        password,
        autoConfirm: true,
        verifyAttributes: true,
      );

      await signOutUser();
    });

    asyncTest('should signIn a user', (_) async {
      final res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      expect(res.isSignedIn, true);
    });

    asyncTest(
      'should throw a NotAuthorizedException with an incorrect password',
      (_) async {
        final incorrectPassword = generatePassword();
        await expectLater(
          Amplify.Auth.signIn(
            username: username,
            password: incorrectPassword,
          ),
          throwsA(isA<NotAuthorizedException>()),
        );
      },
    );

    asyncTest(
      'should throw an InvalidParameterException if a password is not provided '
      'and Custom Auth is not configured',
      (_) async {
        await expectLater(
          Amplify.Auth.signIn(username: username),
          throwsA(isA<InvalidParameterException>()),
        );
      },
    );

    asyncTest(
      'should throw a UserNotFoundException with a non-existent user',
      (_) async {
        final incorrectUsername = generateUsername();
        await expectLater(
          Amplify.Auth.signIn(
            username: incorrectUsername,
            password: password,
          ),
          throwsA(isA<UserNotFoundException>()),
        );
      },
    );

    asyncTest('additionalInfo should be null for SRP sign-in', (_) async {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      expect(result.nextStep?.additionalInfo, isNull);
    });

    asyncTest('unauthenticated identity ID should persist', (_) async {
      // Get unauthenticated identity
      final unauthSession = await Amplify.Auth.fetchAuthSession(
        options: const CognitoSessionOptions(getAWSCredentials: true),
      ) as CognitoAuthSession;

      // Sign in
      final signInRes = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      expect(signInRes.nextStep?.signInStep, 'DONE');

      // Get authenticated identity
      final authSession = await Amplify.Auth.fetchAuthSession(
        options: const CognitoSessionOptions(getAWSCredentials: true),
      ) as CognitoAuthSession;
      expect(authSession.identityId, unauthSession.identityId);
      expect(authSession.credentials, isNot(unauthSession.credentials));
    });
  });

  group('signOut', () {
    setUpAll(() async {
      await configureAuth();
    });

    setUp(() async {
      await signOutUser();
    });

    tearDownAll(Amplify.reset);

    asyncTest('should sign a user out', (_) async {
      final username = generateUsername();
      final password = generatePassword();

      await adminCreateUser(
        username,
        password,
        autoConfirm: true,
        verifyAttributes: true,
      );

      await Amplify.Auth.signIn(username: username, password: password);
      final authSession = await Amplify.Auth.fetchAuthSession();
      expect(authSession.isSignedIn, isTrue);

      await Amplify.Auth.signOut();
      final finalAuthSession = await Amplify.Auth.fetchAuthSession();
      expect(finalAuthSession.isSignedIn, isFalse);
    });

    asyncTest(
      'should not throw even if there is no user to sign out',
      (_) async {
        final authSession = await Amplify.Auth.fetchAuthSession();
        expect(authSession.isSignedIn, isFalse);
        await expectLater(Amplify.Auth.signOut(), completes);
      },
    );
  });
}
