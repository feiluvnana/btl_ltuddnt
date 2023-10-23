// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Mark _$MarkFromJson(Map<String, dynamic> json) {
  return _Mark.fromJson(json);
}

/// @nodoc
mixin _$Mark {
  @IntegerConverter()
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "mark_content")
  String get markContent => throw _privateConstructorUsedError;
  @MarkTypeConverter()
  @JsonKey(name: "type_of_mark")
  MarkType get typeOfMark => throw _privateConstructorUsedError;
  Author get poster => throw _privateConstructorUsedError;
  List<Comment> get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MarkCopyWith<Mark> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkCopyWith<$Res> {
  factory $MarkCopyWith(Mark value, $Res Function(Mark) then) =
      _$MarkCopyWithImpl<$Res, Mark>;
  @useResult
  $Res call(
      {@IntegerConverter() int id,
      @JsonKey(name: "mark_content") String markContent,
      @MarkTypeConverter() @JsonKey(name: "type_of_mark") MarkType typeOfMark,
      Author poster,
      List<Comment> comments});

  $AuthorCopyWith<$Res> get poster;
}

/// @nodoc
class _$MarkCopyWithImpl<$Res, $Val extends Mark>
    implements $MarkCopyWith<$Res> {
  _$MarkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? markContent = null,
    Object? typeOfMark = null,
    Object? poster = null,
    Object? comments = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      markContent: null == markContent
          ? _value.markContent
          : markContent // ignore: cast_nullable_to_non_nullable
              as String,
      typeOfMark: null == typeOfMark
          ? _value.typeOfMark
          : typeOfMark // ignore: cast_nullable_to_non_nullable
              as MarkType,
      poster: null == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as Author,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthorCopyWith<$Res> get poster {
    return $AuthorCopyWith<$Res>(_value.poster, (value) {
      return _then(_value.copyWith(poster: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MarkImplCopyWith<$Res> implements $MarkCopyWith<$Res> {
  factory _$$MarkImplCopyWith(
          _$MarkImpl value, $Res Function(_$MarkImpl) then) =
      __$$MarkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntegerConverter() int id,
      @JsonKey(name: "mark_content") String markContent,
      @MarkTypeConverter() @JsonKey(name: "type_of_mark") MarkType typeOfMark,
      Author poster,
      List<Comment> comments});

  @override
  $AuthorCopyWith<$Res> get poster;
}

/// @nodoc
class __$$MarkImplCopyWithImpl<$Res>
    extends _$MarkCopyWithImpl<$Res, _$MarkImpl>
    implements _$$MarkImplCopyWith<$Res> {
  __$$MarkImplCopyWithImpl(_$MarkImpl _value, $Res Function(_$MarkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? markContent = null,
    Object? typeOfMark = null,
    Object? poster = null,
    Object? comments = null,
  }) {
    return _then(_$MarkImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == markContent
          ? _value.markContent
          : markContent // ignore: cast_nullable_to_non_nullable
              as String,
      null == typeOfMark
          ? _value.typeOfMark
          : typeOfMark // ignore: cast_nullable_to_non_nullable
              as MarkType,
      null == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as Author,
      null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MarkImpl with DiagnosticableTreeMixin implements _Mark {
  const _$MarkImpl(
      @IntegerConverter() this.id,
      @JsonKey(name: "mark_content") this.markContent,
      @MarkTypeConverter() @JsonKey(name: "type_of_mark") this.typeOfMark,
      this.poster,
      final List<Comment> comments)
      : _comments = comments;

  factory _$MarkImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkImplFromJson(json);

  @override
  @IntegerConverter()
  final int id;
  @override
  @JsonKey(name: "mark_content")
  final String markContent;
  @override
  @MarkTypeConverter()
  @JsonKey(name: "type_of_mark")
  final MarkType typeOfMark;
  @override
  final Author poster;
  final List<Comment> _comments;
  @override
  List<Comment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Mark(id: $id, markContent: $markContent, typeOfMark: $typeOfMark, poster: $poster, comments: $comments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Mark'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('markContent', markContent))
      ..add(DiagnosticsProperty('typeOfMark', typeOfMark))
      ..add(DiagnosticsProperty('poster', poster))
      ..add(DiagnosticsProperty('comments', comments));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.markContent, markContent) ||
                other.markContent == markContent) &&
            (identical(other.typeOfMark, typeOfMark) ||
                other.typeOfMark == typeOfMark) &&
            (identical(other.poster, poster) || other.poster == poster) &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, markContent, typeOfMark,
      poster, const DeepCollectionEquality().hash(_comments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkImplCopyWith<_$MarkImpl> get copyWith =>
      __$$MarkImplCopyWithImpl<_$MarkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkImplToJson(
      this,
    );
  }
}

abstract class _Mark implements Mark {
  const factory _Mark(
      @IntegerConverter() final int id,
      @JsonKey(name: "mark_content") final String markContent,
      @MarkTypeConverter()
      @JsonKey(name: "type_of_mark")
      final MarkType typeOfMark,
      final Author poster,
      final List<Comment> comments) = _$MarkImpl;

  factory _Mark.fromJson(Map<String, dynamic> json) = _$MarkImpl.fromJson;

  @override
  @IntegerConverter()
  int get id;
  @override
  @JsonKey(name: "mark_content")
  String get markContent;
  @override
  @MarkTypeConverter()
  @JsonKey(name: "type_of_mark")
  MarkType get typeOfMark;
  @override
  Author get poster;
  @override
  List<Comment> get comments;
  @override
  @JsonKey(ignore: true)
  _$$MarkImplCopyWith<_$MarkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
