import 'dart:io';

import 'package:Anti_Fakebook/models/post.dart';
import 'package:Anti_Fakebook/widgets/afb_image.dart';
import 'package:flutter/material.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class AFBGridImageView extends StatelessWidget {
  final List<AFBNetworkImage> medias;
  final Post? post;
  final void Function(int index) onClickMedia;

  const AFBGridImageView({super.key, required this.medias, required this.onClickMedia, this.post});

  @override
  Widget build(BuildContext context) {
    return switch (medias.length) {
      1 => GestureDetector(
          onTap: () => onClickMedia(0),
          child: medias.first.copyWith(width: MediaQuery.sizeOf(context).width)),
      2 => Row(children: [
          Expanded(
              child: AspectRatio(
                  aspectRatio: 1 / 2,
                  child: GestureDetector(
                      onTap: () => onClickMedia(2),
                      behavior: HitTestBehavior.translucent,
                      child: medias[0].copyWith(width: MediaQuery.sizeOf(context).width / 2)))),
          const SizedBox(width: 4),
          Expanded(
              child: LongPressDraggable(
            feedback: Container(),
            child: AspectRatio(
                aspectRatio: 1 / 2,
                child: GestureDetector(
                    onTap: () => onClickMedia(2),
                    child: medias[1].copyWith(width: MediaQuery.sizeOf(context).width / 2))),
          ))
        ]),
      3 => Row(children: [
          Expanded(
              child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GestureDetector(
                    onTap: () => onClickMedia(0),
                    child: medias.first.copyWith(width: MediaQuery.sizeOf(context).width / 2)),
              ),
              const SizedBox(height: 4),
              AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                      onTap: () => onClickMedia(1),
                      child: medias[1].copyWith(width: MediaQuery.sizeOf(context).width / 2)))
            ],
          )),
          const SizedBox(width: 4),
          Expanded(
              child: AspectRatio(
                  aspectRatio: 1 / 2,
                  child: GestureDetector(
                      onTap: () => onClickMedia(2),
                      child: medias[2].copyWith(width: MediaQuery.sizeOf(context).width / 2))))
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
                  onTap: () => onClickMedia(index),
                  child: medias[index].copyWith(width: MediaQuery.sizeOf(context).width / 2))))
    };
  }
}

class AFBGridImageEdit extends StatelessWidget {
  final List<dynamic> image;
  final void Function(List<dynamic> media)? onUpdated;

  const AFBGridImageEdit({super.key, required this.image, this.onUpdated});

  @override
  Widget build(BuildContext context) {
    var image = this
        .image
        .map((e) => (e is HLPickerItem) ? Image.file(File(e.path), fit: BoxFit.cover) : e)
        .toList();
    return switch (image.length) {
      1 => GestureDetector(
          onDoubleTap: () {
            onUpdated?.call([]);
          },
          child: image.first),
      2 => Row(children: [
          Expanded(
              child: DragTarget<int>(
            builder: (context, _, __) => GestureDetector(
              onDoubleTap: () {
                onUpdated?.call(this.image.sublist(1));
              },
              child: LongPressDraggable<int>(
                  feedback: SizedBox(
                      height: MediaQuery.sizeOf(context).width,
                      width: MediaQuery.sizeOf(context).width / 2,
                      child: image[0]),
                  data: 0,
                  child: AspectRatio(aspectRatio: 1 / 2, child: image[0])),
            ),
            onWillAccept: (object) => object == 1,
            onAccept: (object) {
              onUpdated?.call(this.image.reversed.toList());
            },
          )),
          const SizedBox(width: 4),
          Expanded(
              child: GestureDetector(
            onDoubleTap: () {
              onUpdated?.call(this.image.sublist(0, 1));
            },
            child: DragTarget<int>(
              builder: (context, _, __) => LongPressDraggable<int>(
                data: 1,
                feedback: SizedBox(
                    height: MediaQuery.sizeOf(context).width,
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: image[1]),
                child: AspectRatio(aspectRatio: 1 / 2, child: image[1]),
              ),
              onWillAccept: (object) => object == 0,
              onAccept: (object) {
                onUpdated?.call(this.image.reversed.toList());
              },
            ),
          ))
        ]),
      3 => Row(children: [
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: GestureDetector(
                onDoubleTap: () {
                  onUpdated?.call(this.image.sublist(1));
                },
                child: DragTarget<int>(
                  builder: (context, _, __) => LongPressDraggable<int>(
                      feedback: SizedBox(
                          height: MediaQuery.sizeOf(context).width / 2,
                          width: MediaQuery.sizeOf(context).width / 2,
                          child: image[0]),
                      data: 0,
                      child: AspectRatio(aspectRatio: 1, child: image[0])),
                  onWillAccept: (object) => object != 0,
                  onAccept: (object) {
                    var temp = this.image;
                    dynamic mid = temp[object];
                    temp[object] = temp[0];
                    temp[0] = mid;
                    onUpdated?.call(temp);
                  },
                ),
              )),
              const SizedBox(width: 4),
              Expanded(
                  child: GestureDetector(
                onDoubleTap: () {
                  onUpdated?.call([this.image[0], this.image[2]]);
                },
                child: DragTarget<int>(
                  builder: (context, _, __) => LongPressDraggable<int>(
                    data: 1,
                    feedback: SizedBox(
                        height: MediaQuery.sizeOf(context).width / 2,
                        width: MediaQuery.sizeOf(context).width / 2,
                        child: image[1]),
                    child: AspectRatio(aspectRatio: 1, child: image[1]),
                  ),
                  onWillAccept: (object) => object != 1,
                  onAccept: (object) {
                    var temp = this.image;
                    dynamic mid = temp[object];
                    temp[object] = temp[1];
                    temp[1] = mid;
                    onUpdated?.call(temp);
                  },
                ),
              ))
            ],
          )),
          const SizedBox(width: 4),
          Expanded(
              child: GestureDetector(
            onDoubleTap: () {
              onUpdated?.call([this.image[0], this.image[1]]);
            },
            child: DragTarget<int>(
              builder: (context, _, __) => LongPressDraggable<int>(
                data: 2,
                feedback: SizedBox(
                    height: MediaQuery.sizeOf(context).width,
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: image[2]),
                child: AspectRatio(aspectRatio: 1 / 2, child: image[2]),
              ),
              onWillAccept: (object) => object != 2,
              onAccept: (object) {
                var temp = this.image;
                dynamic mid = temp[object];
                temp[object] = temp[2];
                temp[2] = mid;
                onUpdated?.call(temp);
              },
            ),
          ))
        ]),
      _ => GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1,
          children: List.generate(
              image.length,
              (index) => GestureDetector(
                    onDoubleTap: () {
                      onUpdated?.call(
                          [...this.image.sublist(0, index), ...this.image.sublist(index + 1, 4)]);
                    },
                    child: DragTarget<int>(
                      builder: (context, _, __) => LongPressDraggable<int>(
                        data: index,
                        feedback: SizedBox(
                            height: MediaQuery.sizeOf(context).width / 2,
                            width: MediaQuery.sizeOf(context).width / 2,
                            child: image[index]),
                        child: AspectRatio(aspectRatio: 1, child: image[index]),
                      ),
                      onWillAccept: (object) => object != index,
                      onAccept: (object) {
                        var temp = this.image;
                        dynamic mid = temp[object];
                        temp[object] = temp[index];
                        temp[index] = mid;
                        onUpdated?.call(temp);
                      },
                    ),
                  )))
    };
  }
}
