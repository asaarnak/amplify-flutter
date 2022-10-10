// GENERATED CODE - DO NOT MODIFY BY HAND

part of smoke_test.api_gateway.model.delete_usage_plan_request;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteUsagePlanRequest extends DeleteUsagePlanRequest {
  @override
  final String usagePlanId;

  factory _$DeleteUsagePlanRequest(
          [void Function(DeleteUsagePlanRequestBuilder)? updates]) =>
      (new DeleteUsagePlanRequestBuilder()..update(updates))._build();

  _$DeleteUsagePlanRequest._({required this.usagePlanId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        usagePlanId, r'DeleteUsagePlanRequest', 'usagePlanId');
  }

  @override
  DeleteUsagePlanRequest rebuild(
          void Function(DeleteUsagePlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteUsagePlanRequestBuilder toBuilder() =>
      new DeleteUsagePlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteUsagePlanRequest && usagePlanId == other.usagePlanId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, usagePlanId.hashCode));
  }
}

class DeleteUsagePlanRequestBuilder
    implements Builder<DeleteUsagePlanRequest, DeleteUsagePlanRequestBuilder> {
  _$DeleteUsagePlanRequest? _$v;

  String? _usagePlanId;
  String? get usagePlanId => _$this._usagePlanId;
  set usagePlanId(String? usagePlanId) => _$this._usagePlanId = usagePlanId;

  DeleteUsagePlanRequestBuilder() {
    DeleteUsagePlanRequest._init(this);
  }

  DeleteUsagePlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _usagePlanId = $v.usagePlanId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteUsagePlanRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteUsagePlanRequest;
  }

  @override
  void update(void Function(DeleteUsagePlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteUsagePlanRequest build() => _build();

  _$DeleteUsagePlanRequest _build() {
    final _$result = _$v ??
        new _$DeleteUsagePlanRequest._(
            usagePlanId: BuiltValueNullFieldError.checkNotNull(
                usagePlanId, r'DeleteUsagePlanRequest', 'usagePlanId'));
    replace(_$result);
    return _$result;
  }
}

class _$DeleteUsagePlanRequestPayload extends DeleteUsagePlanRequestPayload {
  factory _$DeleteUsagePlanRequestPayload(
          [void Function(DeleteUsagePlanRequestPayloadBuilder)? updates]) =>
      (new DeleteUsagePlanRequestPayloadBuilder()..update(updates))._build();

  _$DeleteUsagePlanRequestPayload._() : super._();

  @override
  DeleteUsagePlanRequestPayload rebuild(
          void Function(DeleteUsagePlanRequestPayloadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteUsagePlanRequestPayloadBuilder toBuilder() =>
      new DeleteUsagePlanRequestPayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteUsagePlanRequestPayload;
  }

  @override
  int get hashCode {
    return 718216990;
  }
}

class DeleteUsagePlanRequestPayloadBuilder
    implements
        Builder<DeleteUsagePlanRequestPayload,
            DeleteUsagePlanRequestPayloadBuilder> {
  _$DeleteUsagePlanRequestPayload? _$v;

  DeleteUsagePlanRequestPayloadBuilder() {
    DeleteUsagePlanRequestPayload._init(this);
  }

  @override
  void replace(DeleteUsagePlanRequestPayload other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteUsagePlanRequestPayload;
  }

  @override
  void update(void Function(DeleteUsagePlanRequestPayloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteUsagePlanRequestPayload build() => _build();

  _$DeleteUsagePlanRequestPayload _build() {
    final _$result = _$v ?? new _$DeleteUsagePlanRequestPayload._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas