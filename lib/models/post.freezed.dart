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
  String get described => throw _privateConstructorUsedError;

  ///Thời điểm chỉnh sửa bài viết.
  @DateTimeOrNullConverter()
  DateTime? get modified => throw _privateConstructorUsedError;

  ///Số người dùng đánh giá bài viết là fake.
  @IntegerConverter()
  int get fake => throw _privateConstructorUsedError;

  ///Số người dùng đánh giá bài viết là trust.
  @IntegerConverter()
  int get trust => throw _privateConstructorUsedError;

  ///Số người dùng bày tỏ cảm xúc là kudos.
  @IntegerConverter()
  int get kudos => throw _privateConstructorUsedError;

  ///Số người dùng bày tỏ cảm xúc là disappointed.
  @IntegerConverter()
  int get disappointed => throw _privateConstructorUsedError;

  ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
  @BooleanConverter()
  @JsonKey(name: "is_rated")
  bool get isRated => throw _privateConstructorUsedError;

  ///Người dùng đã đánh giá cho bài viết này chưa.
  @BooleanConverter()
  @JsonKey(name: "is_marked")
  bool get isMarked => throw _privateConstructorUsedError;

  ///Danh sách các hình ảnh cùng id và url, id này sẽ giúp ứng dụng phân biệt được người dùng muốn xóa/thay thế ảnh nào.
  List<Image>? get image => throw _privateConstructorUsedError;

  ///Video tải lên và id cùng url.
  Video? get video => throw _privateConstructorUsedError;

  ///Thông tin của người chủ bài viết, bao gồm cả ảnh avatar, số coins, listing: danh sách các id phiên bản cũ của bài viết.
  Author get author => throw _privateConstructorUsedError;

  ///Danh mục của bài viết, id và tên danh mục này.
  Category get category => throw _privateConstructorUsedError;

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
  @BooleanConverter()
  bool get banned => throw _privateConstructorUsedError;

  ///Người đọc có thể viết mark cho bài hay không?
  @IntegerConverter()
  @JsonKey(name: "can_mark")
  int get canMark => throw _privateConstructorUsedError;

  ///Người đọc có thể rate: kudos/disappointed cho bài hay không?
  @IntegerConverter()
  @JsonKey(name: "can_rate")
  int get canRate => throw _privateConstructorUsedError;

  ///Đường link share bài viết.
  String get url => throw _privateConstructorUsedError;

  ///Thông báo từ server.
  String get messages => throw _privateConstructorUsedError;

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
      @DateTimeOrNullConverter() DateTime? modified,
      @IntegerConverter() int fake,
      @IntegerConverter() int trust,
      @IntegerConverter() int kudos,
      @IntegerConverter() int disappointed,
      @BooleanConverter() @JsonKey(name: "is_rated") bool isRated,
      @BooleanConverter() @JsonKey(name: "is_marked") bool isMarked,
      List<Image>? image,
      Video? video,
      Author author,
      Category category,
      String state,
      @BooleanConverter() @JsonKey(name: "is_blocked") bool isBlocked,
      @BooleanConverter() @JsonKey(name: "can_edit") bool canEdit,
      @BooleanConverter() bool banned,
      @IntegerConverter() @JsonKey(name: "can_mark") int canMark,
      @IntegerConverter() @JsonKey(name: "can_rate") int canRate,
      String url,
      String messages});

  $VideoCopyWith<$Res>? get video;
  $AuthorCopyWith<$Res> get author;
  $CategoryCopyWith<$Res> get category;
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
    Object? modified = freezed,
    Object? fake = null,
    Object? trust = null,
    Object? kudos = null,
    Object? disappointed = null,
    Object? isRated = null,
    Object? isMarked = null,
    Object? image = freezed,
    Object? video = freezed,
    Object? author = null,
    Object? category = null,
    Object? state = null,
    Object? isBlocked = null,
    Object? canEdit = null,
    Object? banned = null,
    Object? canMark = null,
    Object? canRate = null,
    Object? url = null,
    Object? messages = null,
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
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fake: null == fake
          ? _value.fake
          : fake // ignore: cast_nullable_to_non_nullable
              as int,
      trust: null == trust
          ? _value.trust
          : trust // ignore: cast_nullable_to_non_nullable
              as int,
      kudos: null == kudos
          ? _value.kudos
          : kudos // ignore: cast_nullable_to_non_nullable
              as int,
      disappointed: null == disappointed
          ? _value.disappointed
          : disappointed // ignore: cast_nullable_to_non_nullable
              as int,
      isRated: null == isRated
          ? _value.isRated
          : isRated // ignore: cast_nullable_to_non_nullable
              as bool,
      isMarked: null == isMarked
          ? _value.isMarked
          : isMarked // ignore: cast_nullable_to_non_nullable
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
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
              as bool,
      canMark: null == canMark
          ? _value.canMark
          : canMark // ignore: cast_nullable_to_non_nullable
              as int,
      canRate: null == canRate
          ? _value.canRate
          : canRate // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as String,
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

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
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
      @DateTimeOrNullConverter() DateTime? modified,
      @IntegerConverter() int fake,
      @IntegerConverter() int trust,
      @IntegerConverter() int kudos,
      @IntegerConverter() int disappointed,
      @BooleanConverter() @JsonKey(name: "is_rated") bool isRated,
      @BooleanConverter() @JsonKey(name: "is_marked") bool isMarked,
      List<Image>? image,
      Video? video,
      Author author,
      Category category,
      String state,
      @BooleanConverter() @JsonKey(name: "is_blocked") bool isBlocked,
      @BooleanConverter() @JsonKey(name: "can_edit") bool canEdit,
      @BooleanConverter() bool banned,
      @IntegerConverter() @JsonKey(name: "can_mark") int canMark,
      @IntegerConverter() @JsonKey(name: "can_rate") int canRate,
      String url,
      String messages});

  @override
  $VideoCopyWith<$Res>? get video;
  @override
  $AuthorCopyWith<$Res> get author;
  @override
  $CategoryCopyWith<$Res> get category;
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
    Object? modified = freezed,
    Object? fake = null,
    Object? trust = null,
    Object? kudos = null,
    Object? disappointed = null,
    Object? isRated = null,
    Object? isMarked = null,
    Object? image = freezed,
    Object? video = freezed,
    Object? author = null,
    Object? category = null,
    Object? state = null,
    Object? isBlocked = null,
    Object? canEdit = null,
    Object? banned = null,
    Object? canMark = null,
    Object? canRate = null,
    Object? url = null,
    Object? messages = null,
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
      freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      null == fake
          ? _value.fake
          : fake // ignore: cast_nullable_to_non_nullable
              as int,
      null == trust
          ? _value.trust
          : trust // ignore: cast_nullable_to_non_nullable
              as int,
      null == kudos
          ? _value.kudos
          : kudos // ignore: cast_nullable_to_non_nullable
              as int,
      null == disappointed
          ? _value.disappointed
          : disappointed // ignore: cast_nullable_to_non_nullable
              as int,
      null == isRated
          ? _value.isRated
          : isRated // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isMarked
          ? _value.isMarked
          : isMarked // ignore: cast_nullable_to_non_nullable
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
      null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
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
              as bool,
      null == canMark
          ? _value.canMark
          : canMark // ignore: cast_nullable_to_non_nullable
              as int,
      null == canRate
          ? _value.canRate
          : canRate // ignore: cast_nullable_to_non_nullable
              as int,
      null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as String,
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
      @DateTimeOrNullConverter() this.modified,
      @IntegerConverter() this.fake,
      @IntegerConverter() this.trust,
      @IntegerConverter() this.kudos,
      @IntegerConverter() this.disappointed,
      @BooleanConverter() @JsonKey(name: "is_rated") this.isRated,
      @BooleanConverter() @JsonKey(name: "is_marked") this.isMarked,
      final List<Image>? image,
      this.video,
      this.author,
      this.category,
      this.state,
      @BooleanConverter() @JsonKey(name: "is_blocked") this.isBlocked,
      @BooleanConverter() @JsonKey(name: "can_edit") this.canEdit,
      @BooleanConverter() this.banned,
      @IntegerConverter() @JsonKey(name: "can_mark") this.canMark,
      @IntegerConverter() @JsonKey(name: "can_rate") this.canRate,
      this.url,
      this.messages)
      : assert(image == null || video == null),
        _image = image;

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

  ///Thời điểm chỉnh sửa bài viết.
  @override
  @DateTimeOrNullConverter()
  final DateTime? modified;

  ///Số người dùng đánh giá bài viết là fake.
  @override
  @IntegerConverter()
  final int fake;

  ///Số người dùng đánh giá bài viết là trust.
  @override
  @IntegerConverter()
  final int trust;

  ///Số người dùng bày tỏ cảm xúc là kudos.
  @override
  @IntegerConverter()
  final int kudos;

  ///Số người dùng bày tỏ cảm xúc là disappointed.
  @override
  @IntegerConverter()
  final int disappointed;

  ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
  @override
  @BooleanConverter()
  @JsonKey(name: "is_rated")
  final bool isRated;

  ///Người dùng đã đánh giá cho bài viết này chưa.
  @override
  @BooleanConverter()
  @JsonKey(name: "is_marked")
  final bool isMarked;

  ///Danh sách các hình ảnh cùng id và url, id này sẽ giúp ứng dụng phân biệt được người dùng muốn xóa/thay thế ảnh nào.
  final List<Image>? _image;

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

  ///Danh mục của bài viết, id và tên danh mục này.
  @override
  final Category category;

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
  @BooleanConverter()
  final bool banned;

  ///Người đọc có thể viết mark cho bài hay không?
  @override
  @IntegerConverter()
  @JsonKey(name: "can_mark")
  final int canMark;

  ///Người đọc có thể rate: kudos/disappointed cho bài hay không?
  @override
  @IntegerConverter()
  @JsonKey(name: "can_rate")
  final int canRate;

  ///Đường link share bài viết.
  @override
  final String url;

  ///Thông báo từ server.
  @override
  final String messages;

  @override
  String toString() {
    return 'Post(id: $id, name: $name, created: $created, described: $described, modified: $modified, fake: $fake, trust: $trust, kudos: $kudos, disappointed: $disappointed, isRated: $isRated, isMarked: $isMarked, image: $image, video: $video, author: $author, category: $category, state: $state, isBlocked: $isBlocked, canEdit: $canEdit, banned: $banned, canMark: $canMark, canRate: $canRate, url: $url, messages: $messages)';
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
            (identical(other.modified, modified) ||
                other.modified == modified) &&
            (identical(other.fake, fake) || other.fake == fake) &&
            (identical(other.trust, trust) || other.trust == trust) &&
            (identical(other.kudos, kudos) || other.kudos == kudos) &&
            (identical(other.disappointed, disappointed) ||
                other.disappointed == disappointed) &&
            (identical(other.isRated, isRated) || other.isRated == isRated) &&
            (identical(other.isMarked, isMarked) ||
                other.isMarked == isMarked) &&
            const DeepCollectionEquality().equals(other._image, _image) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.banned, banned) || other.banned == banned) &&
            (identical(other.canMark, canMark) || other.canMark == canMark) &&
            (identical(other.canRate, canRate) || other.canRate == canRate) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.messages, messages) ||
                other.messages == messages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        created,
        described,
        modified,
        fake,
        trust,
        kudos,
        disappointed,
        isRated,
        isMarked,
        const DeepCollectionEquality().hash(_image),
        video,
        author,
        category,
        state,
        isBlocked,
        canEdit,
        banned,
        canMark,
        canRate,
        url,
        messages
      ]);

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
      @DateTimeOrNullConverter() final DateTime? modified,
      @IntegerConverter() final int fake,
      @IntegerConverter() final int trust,
      @IntegerConverter() final int kudos,
      @IntegerConverter() final int disappointed,
      @BooleanConverter() @JsonKey(name: "is_rated") final bool isRated,
      @BooleanConverter() @JsonKey(name: "is_marked") final bool isMarked,
      final List<Image>? image,
      final Video? video,
      final Author author,
      final Category category,
      final String state,
      @BooleanConverter() @JsonKey(name: "is_blocked") final bool isBlocked,
      @BooleanConverter() @JsonKey(name: "can_edit") final bool canEdit,
      @BooleanConverter() final bool banned,
      @IntegerConverter() @JsonKey(name: "can_mark") final int canMark,
      @IntegerConverter() @JsonKey(name: "can_rate") final int canRate,
      final String url,
      final String messages) = _$PostImpl;

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
  @override

  ///Thời điểm chỉnh sửa bài viết.
  @DateTimeOrNullConverter()
  DateTime? get modified;
  @override

  ///Số người dùng đánh giá bài viết là fake.
  @IntegerConverter()
  int get fake;
  @override

  ///Số người dùng đánh giá bài viết là trust.
  @IntegerConverter()
  int get trust;
  @override

  ///Số người dùng bày tỏ cảm xúc là kudos.
  @IntegerConverter()
  int get kudos;
  @override

  ///Số người dùng bày tỏ cảm xúc là disappointed.
  @IntegerConverter()
  int get disappointed;
  @override

  ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
  @BooleanConverter()
  @JsonKey(name: "is_rated")
  bool get isRated;
  @override

  ///Người dùng đã đánh giá cho bài viết này chưa.
  @BooleanConverter()
  @JsonKey(name: "is_marked")
  bool get isMarked;
  @override

  ///Danh sách các hình ảnh cùng id và url, id này sẽ giúp ứng dụng phân biệt được người dùng muốn xóa/thay thế ảnh nào.
  List<Image>? get image;
  @override

  ///Video tải lên và id cùng url.
  Video? get video;
  @override

  ///Thông tin của người chủ bài viết, bao gồm cả ảnh avatar, số coins, listing: danh sách các id phiên bản cũ của bài viết.
  Author get author;
  @override

  ///Danh mục của bài viết, id và tên danh mục này.
  Category get category;
  @override

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
  @BooleanConverter()
  bool get banned;
  @override

  ///Người đọc có thể viết mark cho bài hay không?
  @IntegerConverter()
  @JsonKey(name: "can_mark")
  int get canMark;
  @override

  ///Người đọc có thể rate: kudos/disappointed cho bài hay không?
  @IntegerConverter()
  @JsonKey(name: "can_rate")
  int get canRate;
  @override

  ///Đường link share bài viết.
  String get url;
  @override

  ///Thông báo từ server.
  String get messages;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
