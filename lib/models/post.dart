import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/models/author.model.dart';
import 'package:Anti_Fakebook/models/image.dart';
import 'package:Anti_Fakebook/models/video.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  @JsonSerializable(explicitToJson: true)
  const factory Post({
    ///Id của bài viết.
    @IntegerConverter() @JsonKey(name: "id") required int id,
    required String name,

    ///Thời điểm tạo bài viết.
    @DateTimeConverter() required DateTime created,

    ///Nội dung bài viết.
    required String described,

    ///Đã chỉnh sửa chưa.
    @Default(false) @BooleanConverter() bool modified,

    ///Số người dùng đánh giá bài viết là fake.
    @Default(0) @IntegerConverter() int fake,

    ///Số người dùng đánh giá bài viết là trust.
    @Default(0) @IntegerConverter() int trust,

    ///Số người dùng bày tỏ cảm xúc là kudos.
    @Default(0) @IntegerConverter() int kudos,

    ///Số người dùng bày tỏ cảm xúc là kudos.
    @Default(0) @IntegerConverter() int feel,

    ///Số bình luận và mark
    @Default(0) @IntegerConverter() @JsonKey(name: "comment_mark") int commentMark,

    ///Số người dùng bày tỏ cảm xúc là disappointed.
    @Default(0) @IntegerConverter() int disappointed,

    // ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
    // @BooleanConverter() @JsonKey(name: "is_rated") bool isRated,

    ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
    @FeelTypeConverter() @JsonKey(name: "is_felt") required FeelType isFelt,

    // ///Người dùng đã đánh giá cho bài viết này chưa.
    // @BooleanConverter() @JsonKey(name: "is_marked") bool isMarked,

    ///Danh sách các hình ảnh cùng id và url, id này sẽ giúp ứng dụng phân biệt được người dùng muốn xóa/thay thế ảnh nào.
    List<Image>? image,

    ///Video tải lên và id cùng url.
    Video? video,

    ///Thông tin của người chủ bài viết, bao gồm cả ảnh avatar, số coins, listing: danh sách các id phiên bản cũ của bài viết.
    required Author author,

    // ///Danh mục của bài viết, id và tên danh mục này.
    // Category? category,

    ///Trạng thái của người viết bài.
    required String state,

    ///Kiểm tra xem người chủ bài viết có chặn người dùng không?
    @Default(false) @BooleanConverter() @JsonKey(name: "is_blocked") bool isBlocked,

    ///Kiểm tra xem người dùng có sửa được bài viết hay không? Không sửa được nếu không phải chủ nhân hoặc đang bị khóa bài viết.
    @Default(false) @BooleanConverter() @JsonKey(name: "can_edit") bool canEdit,

    ///1 bài viết đã bị khóa vì vi phạm tiêu chuẩn cộng đồng, 2 bài viết bị chặn ở một số quốc gia, 3: nội dung của tất cả hình ảnh hoặc video bị che đi. Trường hợp muốn che đi một số ảnh thì trả về một danh sách dạng xâu (chẳng hạn “3,0,2” sẽ che các ảnh số 0 và số 2).
    @Default(0) @IntegerConverter() int banned,
  }

      // ///Người đọc có thể viết mark cho bài hay không?
      // @IntegerConverter() @JsonKey(name: "can_mark") int canMark,

      // ///Người đọc có thể rate: kudos/disappointed cho bài hay không?
      // @IntegerConverter() @JsonKey(name: "can_rate") int canRate,

      // ///Đường link share bài viết.
      // String? url,

      // ///Thông báo từ server.
      // String messages,
      ) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
