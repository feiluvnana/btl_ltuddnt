import 'package:device_info_plus/device_info_plus.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';
import 'package:permission_handler/permission_handler.dart';

extension Extension on HLImagePickerAndroid {
  Future<List<HLPickerItem>> image({
    List<String>? selectedIds,
    HLPickerOptions? pickerOptions,
    bool? cropping,
    HLCropOptions? cropOptions,
    LocalizedImagePicker? localized,
  }) async {
    var usedPermission = ((await DeviceInfoPlugin().androidInfo).version.sdkInt <= 32)
        ? Permission.storage
        : Permission.photos;
    var status = await usedPermission.status.then((value) async {
      if (value == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
        return await usedPermission.request();
      } else if (value != PermissionStatus.granted) {
        return await usedPermission.request();
      }
      return value;
    });
    return status == PermissionStatus.granted
        ? openPicker(
            selectedIds: selectedIds,
            pickerOptions: pickerOptions?.copyWith(
                mediaType: MediaType.image, maxFileSize: 1024 * 2, enablePreview: true),
            cropping: cropping,
            cropOptions: cropOptions,
            localized: localized ??
                const LocalizedImagePicker(
                    maxSelectedAssetsErrorText: "Chỉ được chọn tối đa 4 ảnh.",
                    maxFileSizeErrorText: "Ảnh được chọn vượt quá dung lượng cho phép"),
          )
        : Future.value([]);
  }

  Future<List<HLPickerItem>> video({
    List<String>? selectedIds,
    HLPickerOptions? pickerOptions,
    bool? cropping,
    HLCropOptions? cropOptions,
    LocalizedImagePicker? localized,
  }) async {
    var usedPermission = ((await DeviceInfoPlugin().androidInfo).version.sdkInt <= 32)
        ? Permission.storage
        : Permission.photos;
    var status = await usedPermission.status.then((value) async {
      if (value == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
        return await usedPermission.request();
      } else if (value != PermissionStatus.granted) {
        return await usedPermission.request();
      }
      return value;
    });
    return status == PermissionStatus.granted
        ? openPicker(
            selectedIds: selectedIds,
            pickerOptions: pickerOptions?.copyWith(
                mediaType: MediaType.video, maxFileSize: 1024 * 5, enablePreview: true),
            cropping: cropping,
            cropOptions: cropOptions,
            localized: localized ??
                const LocalizedImagePicker(
                    maxSelectedAssetsErrorText: "Chỉ được chọn tối đa 1 video.",
                    maxFileSizeErrorText: "Video được chọn vượt quá dung lượng cho phép."),
          )
        : Future.value([]);
  }
}

extension Helper on HLPickerOptions {
  HLPickerOptions copyWith({
    MediaType? mediaType,
    int? maxSelectedAssets,
    int? minSelectedAssets,
    double? maxFileSize,
    double? minFileSize,
    bool? enablePreview,
    bool? convertHeicToJPG,
    bool? convertLivePhotosToJPG,
    int? recordVideoMaxSecond,
    bool? isExportThumbnail,
    double? thumbnailCompressQuality,
    CompressFormat? thumbnailCompressFormat,
    int? maxDuration,
    int? minDuration,
    int? numberOfColumn,
    bool? usedCameraButton,
    bool? isGif,
    double? compressQuality,
    CompressFormat? compressFormat,
    MaxSizeOutput? maxSizeOutput,
  }) {
    return HLPickerOptions(
        mediaType: mediaType ?? this.mediaType,
        maxSelectedAssets: maxSelectedAssets ?? this.maxSelectedAssets,
        minSelectedAssets: minSelectedAssets ?? this.minSelectedAssets,
        maxFileSize: maxFileSize ?? this.maxFileSize,
        minFileSize: minFileSize ?? this.minFileSize,
        enablePreview: enablePreview ?? this.enablePreview,
        convertHeicToJPG: convertHeicToJPG ?? this.convertHeicToJPG,
        convertLivePhotosToJPG: convertLivePhotosToJPG ?? this.convertLivePhotosToJPG,
        recordVideoMaxSecond: recordVideoMaxSecond ?? this.recordVideoMaxSecond,
        isExportThumbnail: isExportThumbnail ?? this.isExportThumbnail,
        thumbnailCompressQuality: thumbnailCompressQuality ?? this.thumbnailCompressQuality,
        thumbnailCompressFormat: thumbnailCompressFormat ?? this.thumbnailCompressFormat,
        maxDuration: maxDuration ?? this.maxDuration,
        minDuration: minDuration ?? this.minDuration,
        numberOfColumn: numberOfColumn ?? this.numberOfColumn,
        usedCameraButton: usedCameraButton ?? this.usedCameraButton,
        isGif: isGif ?? this.isGif,
        compressQuality: compressQuality ?? this.compressQuality,
        compressFormat: compressFormat ?? this.compressFormat,
        maxSizeOutput: maxSizeOutput ?? this.maxSizeOutput);
  }
}
