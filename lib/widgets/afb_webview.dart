import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_image.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class AFBWebPreview extends StatelessWidget {
  final String url;

  const AFBWebPreview({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return FutureBuilder(
        future: MetadataFetch.extract(url),
        builder: (context, snapshot) {
          return InkWell(
            onTap: () {
              InAppBrowser().openUrlRequest(
                  urlRequest: URLRequest(url: Uri.tryParse(url)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: themeData.colorScheme.onInverseSurface)),
              child: AspectRatio(
                aspectRatio: 4,
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AFBNetworkImage(
                        url: snapshot.data?.image ?? "",
                        fit: BoxFit.contain,
                        width: MediaQuery.sizeOf(context).width / 4,
                      ),
                    )),
                    Expanded(
                        flex: 3,
                        child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: themeData.colorScheme.onInverseSurface),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(url,
                                    style: themeData.textTheme.labelSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300)),
                                AFBShimmer(
                                  enabled: snapshot.data == null,
                                  child: Text(
                                      snapshot.data?.title ??
                                          "Không có tiêu đề",
                                      style: themeData.textTheme.titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                AFBShimmer(
                                  enabled: snapshot.data == null,
                                  child: Text(
                                      snapshot.data?.description ??
                                          "Không có mô tả nào.",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            )))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
