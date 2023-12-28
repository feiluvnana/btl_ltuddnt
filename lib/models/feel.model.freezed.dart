// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feel.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Feel _$FeelFromJson(Map<String, dynamic> json) {
  return _Feel.fromJson(json);
}

/// @nodoc
mixin _$Feel {
  @JsonKey(name: "user")
  Author get author => throw _privateConstructorUsedError;
  @FeelTypeConverter()
  FeelType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeelCopyWith<Feel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeelCopyWith<$Res> {
  factory $FeelCopyWith(Feel value, $Res Function(Feel) then) =
      _$FeelCopyWithImpl<$Res, Feel>;
  @useResult
  $Res call(
      {@JsonKey(name: "user") Author author,
      @FeelTypeConverter() FeelType type});

  $AuthorCopyWith<$Res> get author;
}

/// @nodoc
class _$FeelCopyWithImpl<$Res, $Val extends Feel>
    implements $FeelCopyWith<$Res> {
  _$FeelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FeelType,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthorCopyWith<$Res> get author {
    return $AuthorCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FeelImplCopyWith<$Res> implements $FeelCopyWith<$Res> {
  factory _$$FeelImplCopyWith(
          _$FeelImpl value, $Res Function(_$FeelImpl) then) =
      __$$FeelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "user") Author author,
      @FeelTypeConverter() FeelType type});

  @override
  $AuthorCopyWith<$Res> get author;
}

/// @nodoc
class __$$FeelImplCopyWithImpl<$Res>
    extends _$FeelCopyWithImpl<$Res, _$FeelImpl>
    implements _$$FeelImplCopyWith<$Res> {
  __$$FeelImplCopyWithImpl(_$FeelImpl _value, $Res Function(_$FeelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? type = null,
  }) {
    return _then(_$FeelImpl(
      null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
      null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FeelType,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$FeelImpl with DiagnosticableTreeMixin implements _Feel {
  const _$FeelImpl(
      @JsonKey(name: "user") this.author, @FeelTypeConverter() this.type);

  factory _$FeelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeelImplFromJson(json);

  @override
  @JsonKey(name: "user")
  final Author author;
  @override
  @FeelTypeConverter()
  final FeelType type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Feel(author: $author, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Feel'))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeelImpl &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, author, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeelImplCopyWith<_$FeelImpl> get copyWith =>
      __$$FeelImplCopyWithImpl<_$FeelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeelImplToJson(
      this,
    );
  }
}

abstract class _Feel implements Feel {
  const factory _Feel(@JsonKey(name: "user") final Author author,
      @FeelTypeConverter() final FeelType type) = _$FeelImpl;

  factory _Feel.fromJson(Map<String, dynamic> json) = _$FeelImpl.fromJson;

  @override
  @JsonKey(name: "user")
  Author get author;
  @override
  @FeelTypeConverter()
  FeelType get type;
  @override
  @JsonKey(ignore: true)
  _$$FeelImplCopyWith<_$FeelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
