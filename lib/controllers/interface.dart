import 'dart:io';

abstract interface class PostEditable {
  Future<void> editPost(
      {required int id,
      List<File>? image,
      File? video,
      String? described,
      String? status,
      List<int>? imageDel,
      List<int>? imageSort});
}

abstract interface class PostAddable {
  Future<void> addPost({List<File>? image, File? video, String? described, String? status});
}
