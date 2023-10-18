import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/detail_image_view.dart';
import 'package:flutter/material.dart';

class GridMediaView extends StatelessWidget {
  final List<Widget> medias;
  final Post? post;
  final void Function(int index) onClickMedia;

  const GridMediaView(
      {super.key, required this.medias, required this.onClickMedia, this.post});

  @override
  Widget build(BuildContext context) {
    return switch (medias.length) {
      1 => GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailImageView(post: post))),
          child: medias.first),
      2 => GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 2,
            crossAxisCount: 4,
            childAspectRatio: 1 / 2,
            children: [
              GestureDetector(
                  onTap: () => onClickMedia(0), child: medias.first),
              GestureDetector(onTap: () => onClickMedia(1), child: medias[1])
            ]),
      3 => Row(children: [
          Expanded(
              child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GestureDetector(
                    onTap: () => onClickMedia(0), child: medias.first),
              ),
              const SizedBox(height: 4),
              AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                      onTap: () => onClickMedia(1), child: medias[1]))
            ],
          )),
          const SizedBox(width: 4),
          Expanded(
              child: AspectRatio(
                  aspectRatio: 1 / 2,
                  child: GestureDetector(
                      onTap: () => onClickMedia(2), child: medias[2])))
        ]),
      _ => GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1,
          children: List.generate(
              medias.length,
              (index) => GestureDetector(
                  onTap: () => onClickMedia(index), child: medias[index])))
    };
  }
}
