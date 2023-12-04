// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsState {
  NotiSettings? get notiSettings => throw _privateConstructorUsedError;
  List<BlockedUser>? get blockedUsers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call({NotiSettings? notiSettings, List<BlockedUser>? blockedUsers});

  $NotiSettingsCopyWith<$Res>? get notiSettings;
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notiSettings = freezed,
    Object? blockedUsers = freezed,
  }) {
    return _then(_value.copyWith(
      notiSettings: freezed == notiSettings
          ? _value.notiSettings
          : notiSettings // ignore: cast_nullable_to_non_nullable
              as NotiSettings?,
      blockedUsers: freezed == blockedUsers
          ? _value.blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<BlockedUser>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotiSettingsCopyWith<$Res>? get notiSettings {
    if (_value.notiSettings == null) {
      return null;
    }

    return $NotiSettingsCopyWith<$Res>(_value.notiSettings!, (value) {
      return _then(_value.copyWith(notiSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SettingsStateImplCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsStateImplCopyWith(
          _$SettingsStateImpl value, $Res Function(_$SettingsStateImpl) then) =
      __$$SettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NotiSettings? notiSettings, List<BlockedUser>? blockedUsers});

  @override
  $NotiSettingsCopyWith<$Res>? get notiSettings;
}

/// @nodoc
class __$$SettingsStateImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsStateImpl>
    implements _$$SettingsStateImplCopyWith<$Res> {
  __$$SettingsStateImplCopyWithImpl(
      _$SettingsStateImpl _value, $Res Function(_$SettingsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notiSettings = freezed,
    Object? blockedUsers = freezed,
  }) {
    return _then(_$SettingsStateImpl(
      notiSettings: freezed == notiSettings
          ? _value.notiSettings
          : notiSettings // ignore: cast_nullable_to_non_nullable
              as NotiSettings?,
      blockedUsers: freezed == blockedUsers
          ? _value._blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<BlockedUser>?,
    ));
  }
}

/// @nodoc

class _$SettingsStateImpl implements _SettingsState {
  const _$SettingsStateImpl(
      {this.notiSettings, final List<BlockedUser>? blockedUsers})
      : _blockedUsers = blockedUsers;

  @override
  final NotiSettings? notiSettings;
  final List<BlockedUser>? _blockedUsers;
  @override
  List<BlockedUser>? get blockedUsers {
    final value = _blockedUsers;
    if (value == null) return null;
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SettingsState(notiSettings: $notiSettings, blockedUsers: $blockedUsers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsStateImpl &&
            (identical(other.notiSettings, notiSettings) ||
                other.notiSettings == notiSettings) &&
            const DeepCollectionEquality()
                .equals(other._blockedUsers, _blockedUsers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, notiSettings,
      const DeepCollectionEquality().hash(_blockedUsers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      __$$SettingsStateImplCopyWithImpl<_$SettingsStateImpl>(this, _$identity);
}

abstract class _SettingsState implements SettingsState {
  const factory _SettingsState(
      {final NotiSettings? notiSettings,
      final List<BlockedUser>? blockedUsers}) = _$SettingsStateImpl;

  @override
  NotiSettings? get notiSettings;
  @override
  List<BlockedUser>? get blockedUsers;
  @override
  @JsonKey(ignore: true)
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
