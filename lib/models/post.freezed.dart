// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  ///Id của bài viết.
  @IntegerConverter()
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  ///Thời điểm tạo bài viết.
  @DateTimeConverter()
  DateTime get created => throw _privateConstructorUsedError;

  ///Nội dung bài viết.
  String get described =>
      throw _privateConstructorUsedError; // ///Thời điểm chỉnh sửa bài viết.
// @DateTimeOrNullConverter() DateTime? modified,
// ///Số người dùng đánh giá bài viết là fake.
// @IntegerOrNullConverter() int? fake,
// ///Số người dùng đánh giá bài viết là trust.
// @IntegerOrNullConverter() int? trust,
// ///Số người dùng bày tỏ cảm xúc là kudos.
// @IntegerOrNullConverter() int? kudos,
  ///Số người dùng bày tỏ cảm xúc là kudos.
  @IntegerOrNullConverter()
  int? get feel => throw _privateConstructorUsedError;

  ///Số bình luận và mark
  @IntegerOrNullConverter()
  @JsonKey(name: "comment_mark")
  int? get commentMark =>
      throw _privateConstructorUsedError; // ///Số người dùng bày tỏ cảm xúc là disappointed.
// @IntegerOrNullConverter() int? disappointed,
// ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
// @BooleanConverter() @JsonKey(name: "is_rated") bool isRated,
  ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
  @BooleanConverter()
  @JsonKey(name: "is_felt")
  bool get isFelt =>
      throw _privateConstructorUsedError; // ///Người dùng đã đánh giá cho bài viết này chưa.
// @BooleanConverter() @JsonKey(name: "is_marked") bool isMarked,
  ///Danh sách các hình ảnh cùng id và url, id này sẽ giúp ứng dụng phân biệt được người dùng muốn xóa/thay thế ảnh nào.
  List<Image>? get image => throw _privateConstructorUsedError;

  ///Video tải lên và id cùng url.
  Video? get video => throw _privateConstructorUsedError;

  ///Thông tin của người chủ bài viết, bao gồm cả ảnh avatar, số coins, listing: danh sách các id phiên bản cũ của bài viết.
  Author get author =>
      throw _privateConstructorUsedError; // ///Danh mục của bài viết, id và tên danh mục này.
// Category? category,
  ///Trạng thái của người viết bài.
  String get state => throw _privateConstructorUsedError;

  ///Kiểm tra xem người chủ bài viết có chặn người dùng không?
  @BooleanConverter()
  @JsonKey(name: "is_blocked")
  bool get isBlocked => throw _privateConstructorUsedError;

  ///Kiểm tra xem người dùng có sửa được bài viết hay không? Không sửa được nếu không phải chủ nhân hoặc đang bị khóa bài viết.
  @BooleanConverter()
  @JsonKey(name: "can_edit")
  bool get canEdit => throw _privateConstructorUsedError;

  ///1 bài viết đã bị khóa vì vi phạm tiêu chuẩn cộng đồng, 2 bài viết bị chặn ở một số quốc gia, 3: nội dung của tất cả hình ảnh hoặc video bị che đi. Trường hợp muốn che đi một số ảnh thì trả về một danh sách dạng xâu (chẳng hạn “3,0,2” sẽ che các ảnh số 0 và số 2).
  @IntegerConverter()
  int get banned => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {@IntegerConverter() @JsonKey(name: "id") int id,
      String name,
      @DateTimeConverter() DateTime created,
      String described,
      @IntegerOrNullConverter() int? feel,
      @IntegerOrNullConverter() @JsonKey(name: "comment_mark") int? commentMark,
      @BooleanConverter() @JsonKey(name: "is_felt") bool isFelt,
      List<Image>? image,
      Video? video,
      Author author,
      String state,
      @BooleanConverter() @JsonKey(name: "is_blocked") bool isBlocked,
      @BooleanConverter() @JsonKey(name: "can_edit") bool canEdit,
      @IntegerConverter() int banned});

  $VideoCopyWith<$Res>? get video;
  $AuthorCopyWith<$Res> get author;
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? created = null,
    Object? described = null,
    Object? feel = freezed,
    Object? commentMark = freezed,
    Object? isFelt = null,
    Object? image = freezed,
    Object? video = freezed,
    Object? author = null,
    Object? state = null,
    Object? isBlocked = null,
    Object? canEdit = null,
    Object? banned = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      described: null == described
          ? _value.described
          : described // ignore: cast_nullable_to_non_nullable
              as String,
      feel: freezed == feel
          ? _value.feel
          : feel // ignore: cast_nullable_to_non_nullable
              as int?,
      commentMark: freezed == commentMark
          ? _value.commentMark
          : commentMark // ignore: cast_nullable_to_non_nullable
              as int?,
      isFelt: null == isFelt
          ? _value.isFelt
          : isFelt // ignore: cast_nullable_to_non_nullable
              as bool,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as List<Image>?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Video?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      canEdit: null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      banned: null == banned
          ? _value.banned
          : banned // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VideoCopyWith<$Res>? get video {
    if (_value.video == null) {
      return null;
    }

    return $VideoCopyWith<$Res>(_value.video!, (value) {
      return _then(_value.copyWith(video: value) as $Val);
    });
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
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntegerConverter() @JsonKey(name: "id") int id,
      String name,
      @DateTimeConverter() DateTime created,
      String described,
      @IntegerOrNullConverter() int? feel,
      @IntegerOrNullConverter() @JsonKey(name: "comment_mark") int? commentMark,
      @BooleanConverter() @JsonKey(name: "is_felt") bool isFelt,
      List<Image>? image,
      Video? video,
      Author author,
      String state,
      @BooleanConverter() @JsonKey(name: "is_blocked") bool isBlocked,
      @BooleanConverter() @JsonKey(name: "can_edit") bool canEdit,
      @IntegerConverter() int banned});

  @override
  $VideoCopyWith<$Res>? get video;
  @override
  $AuthorCopyWith<$Res> get author;
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? created = null,
    Object? described = null,
    Object? feel = freezed,
    Object? commentMark = freezed,
    Object? isFelt = null,
    Object? image = freezed,
    Object? video = freezed,
    Object? author = null,
    Object? state = null,
    Object? isBlocked = null,
    Object? canEdit = null,
    Object? banned = null,
  }) {
    return _then(_$PostImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == described
          ? _value.described
          : described // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == feel
          ? _value.feel
          : feel // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == commentMark
          ? _value.commentMark
          : commentMark // ignore: cast_nullable_to_non_nullable
              as int?,
      null == isFelt
          ? _value.isFelt
          : isFelt // ignore: cast_nullable_to_non_nullable
              as bool,
      freezed == image
          ? _value._image
          : image // ignore: cast_nullable_to_non_nullable
              as List<Image>?,
      freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Video?,
      null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
      null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      null == banned
          ? _value.banned
          : banned // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PostImpl implements _Post {
  const _$PostImpl(
      @IntegerConverter() @JsonKey(name: "id") this.id,
      this.name,
      @DateTimeConverter() this.created,
      this.described,
      @IntegerOrNullConverter() this.feel,
      @IntegerOrNullConverter() @JsonKey(name: "comment_mark") this.commentMark,
      @BooleanConverter() @JsonKey(name: "is_felt") this.isFelt,
      final List<Image>? image,
      this.video,
      this.author,
      this.state,
      @BooleanConverter() @JsonKey(name: "is_blocked") this.isBlocked,
      @BooleanConverter() @JsonKey(name: "can_edit") this.canEdit,
      @IntegerConverter() this.banned)
      : _image = image;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  ///Id của bài viết.
  @override
  @IntegerConverter()
  @JsonKey(name: "id")
  final int id;
  @override
  final String name;

  ///Thời điểm tạo bài viết.
  @override
  @DateTimeConverter()
  final DateTime created;

  ///Nội dung bài viết.
  @override
  final String described;
// ///Thời điểm chỉnh sửa bài viết.
// @DateTimeOrNullConverter() DateTime? modified,
// ///Số người dùng đánh giá bài viết là fake.
// @IntegerOrNullConverter() int? fake,
// ///Số người dùng đánh giá bài viết là trust.
// @IntegerOrNullConverter() int? trust,
// ///Số người dùng bày tỏ cảm xúc là kudos.
// @IntegerOrNullConverter() int? kudos,
  ///Số người dùng bày tỏ cảm xúc là kudos.
  @override
  @IntegerOrNullConverter()
  final int? feel;

  ///Số bình luận và mark
  @override
  @IntegerOrNullConverter()
  @JsonKey(name: "comment_mark")
  final int? commentMark;
// ///Số người dùng bày tỏ cảm xúc là disappointed.
// @IntegerOrNullConverter() int? disappointed,
// ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
// @BooleanConverter() @JsonKey(name: "is_rated") bool isRated,
  ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
  @override
  @BooleanConverter()
  @JsonKey(name: "is_felt")
  final bool isFelt;
// ///Người dùng đã đánh giá cho bài viết này chưa.
// @BooleanConverter() @JsonKey(name: "is_marked") bool isMarked,
  ///Danh sách các hình ảnh cùng id và url, id này sẽ giúp ứng dụng phân biệt được người dùng muốn xóa/thay thế ảnh nào.
  final List<Image>? _image;
// ///Người dùng đã đánh giá cho bài viết này chưa.
// @BooleanConverter() @JsonKey(name: "is_marked") bool isMarked,
  ///Danh sách các hình ảnh cùng id và url, id này sẽ giúp ứng dụng phân biệt được người dùng muốn xóa/thay thế ảnh nào.
  @override
  List<Image>? get image {
    final value = _image;
    if (value == null) return null;
    if (_image is EqualUnmodifiableListView) return _image;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  ///Video tải lên và id cùng url.
  @override
  final Video? video;

  ///Thông tin của người chủ bài viết, bao gồm cả ảnh avatar, số coins, listing: danh sách các id phiên bản cũ của bài viết.
  @override
  final Author author;
// ///Danh mục của bài viết, id và tên danh mục này.
// Category? category,
  ///Trạng thái của người viết bài.
  @override
  final String state;

  ///Kiểm tra xem người chủ bài viết có chặn người dùng không?
  @override
  @BooleanConverter()
  @JsonKey(name: "is_blocked")
  final bool isBlocked;

  ///Kiểm tra xem người dùng có sửa được bài viết hay không? Không sửa được nếu không phải chủ nhân hoặc đang bị khóa bài viết.
  @override
  @BooleanConverter()
  @JsonKey(name: "can_edit")
  final bool canEdit;

  ///1 bài viết đã bị khóa vì vi phạm tiêu chuẩn cộng đồng, 2 bài viết bị chặn ở một số quốc gia, 3: nội dung của tất cả hình ảnh hoặc video bị che đi. Trường hợp muốn che đi một số ảnh thì trả về một danh sách dạng xâu (chẳng hạn “3,0,2” sẽ che các ảnh số 0 và số 2).
  @override
  @IntegerConverter()
  final int banned;

  @override
  String toString() {
    return 'Post(id: $id, name: $name, created: $created, described: $described, feel: $feel, commentMark: $commentMark, isFelt: $isFelt, image: $image, video: $video, author: $author, state: $state, isBlocked: $isBlocked, canEdit: $canEdit, banned: $banned)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.described, described) ||
                other.described == described) &&
            (identical(other.feel, feel) || other.feel == feel) &&
            (identical(other.commentMark, commentMark) ||
                other.commentMark == commentMark) &&
            (identical(other.isFelt, isFelt) || other.isFelt == isFelt) &&
            const DeepCollectionEquality().equals(other._image, _image) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.banned, banned) || other.banned == banned));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      created,
      described,
      feel,
      commentMark,
      isFelt,
      const DeepCollectionEquality().hash(_image),
      video,
      author,
      state,
      isBlocked,
      canEdit,
      banned);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  const factory _Post(
      @IntegerConverter() @JsonKey(name: "id") final int id,
      final String name,
      @DateTimeConverter() final DateTime created,
      final String described,
      @IntegerOrNullConverter() final int? feel,
      @IntegerOrNullConverter()
      @JsonKey(name: "comment_mark")
      final int? commentMark,
      @BooleanConverter() @JsonKey(name: "is_felt") final bool isFelt,
      final List<Image>? image,
      final Video? video,
      final Author author,
      final String state,
      @BooleanConverter() @JsonKey(name: "is_blocked") final bool isBlocked,
      @BooleanConverter() @JsonKey(name: "can_edit") final bool canEdit,
      @IntegerConverter() final int banned) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override

  ///Id của bài viết.
  @IntegerConverter()
  @JsonKey(name: "id")
  int get id;
  @override
  String get name;
  @override

  ///Thời điểm tạo bài viết.
  @DateTimeConverter()
  DateTime get created;
  @override

  ///Nội dung bài viết.
  String get described;
  @override // ///Thời điểm chỉnh sửa bài viết.
// @DateTimeOrNullConverter() DateTime? modified,
// ///Số người dùng đánh giá bài viết là fake.
// @IntegerOrNullConverter() int? fake,
// ///Số người dùng đánh giá bài viết là trust.
// @IntegerOrNullConverter() int? trust,
// ///Số người dùng bày tỏ cảm xúc là kudos.
// @IntegerOrNullConverter() int? kudos,
  ///Số người dùng bày tỏ cảm xúc là kudos.
  @IntegerOrNullConverter()
  int? get feel;
  @override

  ///Số bình luận và mark
  @IntegerOrNullConverter()
  @JsonKey(name: "comment_mark")
  int? get commentMark;
  @override // ///Số người dùng bày tỏ cảm xúc là disappointed.
// @IntegerOrNullConverter() int? disappointed,
// ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
// @BooleanConverter() @JsonKey(name: "is_rated") bool isRated,
  ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
  @BooleanConverter()
  @JsonKey(name: "is_felt")
  bool get isFelt;
  @override // ///Người dùng đã đánh giá cho bài viết này chưa.
// @BooleanConverter() @JsonKey(name: "is_marked") bool isMarked,
  ///Danh sách các hình ảnh cùng id và url, id này sẽ giúp ứng dụng phân biệt được người dùng muốn xóa/thay thế ảnh nào.
  List<Image>? get image;
  @override

  ///Video tải lên và id cùng url.
  Video? get video;
  @override

  ///Thông tin của người chủ bài viết, bao gồm cả ảnh avatar, số coins, listing: danh sách các id phiên bản cũ của bài viết.
  Author get author;
  @override // ///Danh mục của bài viết, id và tên danh mục này.
// Category? category,
  ///Trạng thái của người viết bài.
  String get state;
  @override

  ///Kiểm tra xem người chủ bài viết có chặn người dùng không?
  @BooleanConverter()
  @JsonKey(name: "is_blocked")
  bool get isBlocked;
  @override

  ///Kiểm tra xem người dùng có sửa được bài viết hay không? Không sửa được nếu không phải chủ nhân hoặc đang bị khóa bài viết.
  @BooleanConverter()
  @JsonKey(name: "can_edit")
  bool get canEdit;
  @override

  ///1 bài viết đã bị khóa vì vi phạm tiêu chuẩn cộng đồng, 2 bài viết bị chặn ở một số quốc gia, 3: nội dung của tất cả hình ảnh hoặc video bị che đi. Trường hợp muốn che đi một số ảnh thì trả về một danh sách dạng xâu (chẳng hạn “3,0,2” sẽ che các ảnh số 0 và số 2).
  @IntegerConverter()
  int get banned;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
