import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/json_converter.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/author.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/video.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/image.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  @Assert("image == null || video == null")
  @JsonSerializable(explicitToJson: true)
  const factory Post(
    ///Id của bài viết.
    @IntegerConverter() @JsonKey(name: "id") int id,
    String name,

    ///Thời điểm tạo bài viết.
    @DateTimeConverter() DateTime created,

    ///Nội dung bài viết.
    String described,

    // ///Thời điểm chỉnh sửa bài viết.
    // @DateTimeOrNullConverter() DateTime? modified,

    // ///Số người dùng đánh giá bài viết là fake.
    // @IntegerOrNullConverter() int? fake,

    // ///Số người dùng đánh giá bài viết là trust.
    // @IntegerOrNullConverter() int? trust,

    // ///Số người dùng bày tỏ cảm xúc là kudos.
    // @IntegerOrNullConverter() int? kudos,

    ///Số người dùng bày tỏ cảm xúc là kudos.
    @IntegerOrNullConverter() int? feel,

    ///Số bình luận và mark
    @IntegerOrNullConverter() @JsonKey(name: "comment_mark") int? commentMark,

    // ///Số người dùng bày tỏ cảm xúc là disappointed.
    // @IntegerOrNullConverter() int? disappointed,

    // ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
    // @BooleanConverter() @JsonKey(name: "is_rated") bool isRated,

    ///Người dùng đã bày tỏ cảm xúc cho bài viết này chưa.
    @BooleanConverter() @JsonKey(name: "is_felt") bool isFelt,

    // ///Người dùng đã đánh giá cho bài viết này chưa.
    // @BooleanConverter() @JsonKey(name: "is_marked") bool isMarked,

    ///Danh sách các hình ảnh cùng id và url, id này sẽ giúp ứng dụng phân biệt được người dùng muốn xóa/thay thế ảnh nào.
    List<Image>? image,

    ///Video tải lên và id cùng url.
    Video? video,

    ///Thông tin của người chủ bài viết, bao gồm cả ảnh avatar, số coins, listing: danh sách các id phiên bản cũ của bài viết.
    Author author,

    // ///Danh mục của bài viết, id và tên danh mục này.
    // Category? category,

    ///Trạng thái của người viết bài.
    String state,

    ///Kiểm tra xem người chủ bài viết có chặn người dùng không?
    @BooleanConverter() @JsonKey(name: "is_blocked") bool isBlocked,

    ///Kiểm tra xem người dùng có sửa được bài viết hay không? Không sửa được nếu không phải chủ nhân hoặc đang bị khóa bài viết.
    @BooleanConverter() @JsonKey(name: "can_edit") bool canEdit,

    ///1 bài viết đã bị khóa vì vi phạm tiêu chuẩn cộng đồng, 2 bài viết bị chặn ở một số quốc gia, 3: nội dung của tất cả hình ảnh hoặc video bị che đi. Trường hợp muốn che đi một số ảnh thì trả về một danh sách dạng xâu (chẳng hạn “3,0,2” sẽ che các ảnh số 0 và số 2).
    @IntegerConverter() int banned,

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
