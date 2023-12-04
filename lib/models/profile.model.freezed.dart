// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  @IntegerConverter()
  int get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get created => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: "cover_image")
  String get coverImage => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  @IntegerConverter()
  int get listing => throw _privateConstructorUsedError;
  @JsonKey(name: "is_friend")
  @BooleanConverter()
  bool get isFriend => throw _privateConstructorUsedError;
  @BooleanConverter()
  bool get online => throw _privateConstructorUsedError;
  @IntegerConverter()
  int get coins => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call(
      {@IntegerConverter() int id,
      String username,
      @DateTimeConverter() DateTime created,
      String description,
      String avatar,
      @JsonKey(name: "cover_image") String coverImage,
      String link,
      String address,
      String city,
      String country,
      @IntegerConverter() int listing,
      @JsonKey(name: "is_friend") @BooleanConverter() bool isFriend,
      @BooleanConverter() bool online,
      @IntegerConverter() int coins});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? created = null,
    Object? description = null,
    Object? avatar = null,
    Object? coverImage = null,
    Object? link = null,
    Object? address = null,
    Object? city = null,
    Object? country = null,
    Object? listing = null,
    Object? isFriend = null,
    Object? online = null,
    Object? coins = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: null == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      listing: null == listing
          ? _value.listing
          : listing // ignore: cast_nullable_to_non_nullable
              as int,
      isFriend: null == isFriend
          ? _value.isFriend
          : isFriend // ignore: cast_nullable_to_non_nullable
              as bool,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
          _$ProfileImpl value, $Res Function(_$ProfileImpl) then) =
      __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntegerConverter() int id,
      String username,
      @DateTimeConverter() DateTime created,
      String description,
      String avatar,
      @JsonKey(name: "cover_image") String coverImage,
      String link,
      String address,
      String city,
      String country,
      @IntegerConverter() int listing,
      @JsonKey(name: "is_friend") @BooleanConverter() bool isFriend,
      @BooleanConverter() bool online,
      @IntegerConverter() int coins});
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
      _$ProfileImpl _value, $Res Function(_$ProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? created = null,
    Object? description = null,
    Object? avatar = null,
    Object? coverImage = null,
    Object? link = null,
    Object? address = null,
    Object? city = null,
    Object? country = null,
    Object? listing = null,
    Object? isFriend = null,
    Object? online = null,
    Object? coins = null,
  }) {
    return _then(_$ProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: null == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      listing: null == listing
          ? _value.listing
          : listing // ignore: cast_nullable_to_non_nullable
              as int,
      isFriend: null == isFriend
          ? _value.isFriend
          : isFriend // ignore: cast_nullable_to_non_nullable
              as bool,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl(
      {@IntegerConverter() required this.id,
      required this.username,
      @DateTimeConverter() required this.created,
      required this.description,
      required this.avatar,
      @JsonKey(name: "cover_image") required this.coverImage,
      required this.link,
      required this.address,
      required this.city,
      required this.country,
      @IntegerConverter() required this.listing,
      @JsonKey(name: "is_friend") @BooleanConverter() required this.isFriend,
      @BooleanConverter() required this.online,
      @IntegerConverter() required this.coins});

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  @IntegerConverter()
  final int id;
  @override
  final String username;
  @override
  @DateTimeConverter()
  final DateTime created;
  @override
  final String description;
  @override
  final String avatar;
  @override
  @JsonKey(name: "cover_image")
  final String coverImage;
  @override
  final String link;
  @override
  final String address;
  @override
  final String city;
  @override
  final String country;
  @override
  @IntegerConverter()
  final int listing;
  @override
  @JsonKey(name: "is_friend")
  @BooleanConverter()
  final bool isFriend;
  @override
  @BooleanConverter()
  final bool online;
  @override
  @IntegerConverter()
  final int coins;

  @override
  String toString() {
    return 'Profile(id: $id, username: $username, created: $created, description: $description, avatar: $avatar, coverImage: $coverImage, link: $link, address: $address, city: $city, country: $country, listing: $listing, isFriend: $isFriend, online: $online, coins: $coins)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.listing, listing) || other.listing == listing) &&
            (identical(other.isFriend, isFriend) ||
                other.isFriend == isFriend) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.coins, coins) || other.coins == coins));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      created,
      description,
      avatar,
      coverImage,
      link,
      address,
      city,
      country,
      listing,
      isFriend,
      online,
      coins);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  const factory _Profile(
      {@IntegerConverter() required final int id,
      required final String username,
      @DateTimeConverter() required final DateTime created,
      required final String description,
      required final String avatar,
      @JsonKey(name: "cover_image") required final String coverImage,
      required final String link,
      required final String address,
      required final String city,
      required final String country,
      @IntegerConverter() required final int listing,
      @JsonKey(name: "is_friend")
      @BooleanConverter()
      required final bool isFriend,
      @BooleanConverter() required final bool online,
      @IntegerConverter() required final int coins}) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  @IntegerConverter()
  int get id;
  @override
  String get username;
  @override
  @DateTimeConverter()
  DateTime get created;
  @override
  String get description;
  @override
  String get avatar;
  @override
  @JsonKey(name: "cover_image")
  String get coverImage;
  @override
  String get link;
  @override
  String get address;
  @override
  String get city;
  @override
  String get country;
  @override
  @IntegerConverter()
  int get listing;
  @override
  @JsonKey(name: "is_friend")
  @BooleanConverter()
  bool get isFriend;
  @override
  @BooleanConverter()
  bool get online;
  @override
  @IntegerConverter()
  int get coins;
  @override
  @JsonKey(ignore: true)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
