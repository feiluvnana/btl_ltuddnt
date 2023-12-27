import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:Anti_Fakebook/controllers/overlay.controller.dart';
import 'package:Anti_Fakebook/controllers/theme.controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AFBVideoPlayer extends ConsumerStatefulWidget {
  final String url;

  const AFBVideoPlayer({super.key, required this.url});

  @override
  ConsumerState<AFBVideoPlayer> createState() => _AFBVideoPlayerState();
}

class _AFBVideoPlayerState extends ConsumerState<AFBVideoPlayer> {
  static final cacheManager =
      CacheManager(Config("afb", stalePeriod: const Duration(seconds: 30), maxNrOfCacheObjects: 5));
  ChewieController? ctrl;
  Stream<FileResponse>? stream;
  StreamSubscription? sub;
  VideoPlayerController? vctrl;
  File? file;
  bool isInDefault = true;
  Timer? remove;

  void getFile() {
    setState(() {
      stream = cacheManager.getFileStream(widget.url, withProgress: true).asBroadcastStream();
      sub = stream?.listen((event) async {
        if (event is FileInfo) {
          sub?.cancel();
          file = event.file;
          start().then((value) {
            if (!mounted) return;
            vctrl?.play();
            setState(() {});
          });
        }
      });
    });
  }

  void toFullScreen() {
    ref.read(themeControllerProvider.notifier).setThemeMode(ThemeMode.dark);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PopScope(
        onPopInvoked: (didPop) {
          ref.read(themeControllerProvider.notifier).setThemeMode(ThemeMode.light);
          ref.read(overlayControllerProvider.notifier).insert(OverlayEntry(builder: (context) {
            return Align(
              alignment: Alignment.topLeft,
              child: FloatDraggableWidget(
                  ctrl: vctrl!,
                  onDismiss: () {
                    setState(() {
                      isInDefault = true;
                      ctrl?.pause();
                    });
                  },
                  onRemove: () {
                    setState(() {
                      ctrl?.pause();
                    });
                  },
                  onTap: () {
                    ref.read(overlayControllerProvider.notifier).remove();
                    toFullScreen();
                  }),
            );
          }), context);
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.maybePop(_);
                  },
                  icon: const Icon(Icons.splitscreen)),
            ),
            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
            body: Chewie(controller: ctrl!)),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return VisibilityDetector(
      onVisibilityChanged: (VisibilityInfo info) {
        if (!mounted) return;
        if (!isInDefault || ref.read(overlayControllerProvider).entry != null) return;
        if (info.visibleFraction == 1) {
          getFile();
        }
        if (info.visibleFraction < 0.8) {
          vctrl?.pause();
        }
        if (info.visibleFraction > 0.85) {
          vctrl?.play();
        }
      },
      key: ObjectKey(widget.url),
      child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width + 40,
                  child: const Text("Có lỗi xảy ra! Hãy thử lại sau!"));
            } else if (!snapshot.hasData || snapshot.data is DownloadProgress) {
              return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width + 40,
                  decoration: BoxDecoration(color: themeData.colorScheme.inverseSurface),
                  child: CircularProgressIndicator(
                      value: (snapshot.data as DownloadProgress?)?.progress,
                      color: themeData.colorScheme.surface));
            } else {
              return SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width + 40,
                  child: ctrl != null
                      ? GestureDetector(
                          onDoubleTap: () {
                            ref.read(overlayControllerProvider.notifier).remove();
                            setState(() {
                              isInDefault = false;
                            });
                            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                              toFullScreen();
                            });
                          },
                          onTap: () {},
                          child: Stack(
                            children: [
                              Positioned.fill(
                                  child: Container(
                                      decoration: const BoxDecoration(color: Colors.black38))),
                              if (isInDefault) ...[
                                VideoPlayer(vctrl!),
                                Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          vctrl?.setVolume(vctrl?.value.volume == 0 ? 1 : 0);
                                        });
                                      },
                                      child: vctrl?.value.volume == 0
                                          ? const Icon(Icons.volume_off, color: Colors.white)
                                          : const Icon(Icons.volume_up, color: Colors.white),
                                    ))
                              ],
                            ],
                          ),
                        )
                      : Container());
            }
          }),
    );
  }

  Future<void> start() async {
    if (file == null) {
      getFile();
      return;
    }
    vctrl = VideoPlayerController.file(file!);
    await vctrl!.initialize();
    await vctrl!.setVolume(0);
    ctrl = ChewieController(videoPlayerController: vctrl!, autoPlay: false, looping: true);
  }

  void end() {
    ctrl?.dispose();
    vctrl?.dispose();
    ctrl = vctrl = null;
  }

  @override
  void dispose() {
    end();
    super.dispose();
  }
}

class FloatDraggableWidget extends ConsumerStatefulWidget {
  final VideoPlayerController ctrl;
  final void Function() onDismiss, onTap, onRemove;

  const FloatDraggableWidget(
      {super.key,
      required this.onTap,
      required this.onRemove,
      required this.onDismiss,
      required this.ctrl});

  @override
  ConsumerState<FloatDraggableWidget> createState() => _FloatDraggableWidgetState();
}

class _FloatDraggableWidgetState extends ConsumerState<FloatDraggableWidget> {
  late Offset offset = Offset(
      MediaQuery.sizeOf(context).width - 240, MediaQuery.sizeOf(context).height - 240 / 16 * 9);
  late Offset baseOffset = Offset(
      MediaQuery.sizeOf(context).width - 240, MediaQuery.sizeOf(context).height - 240 / 16 * 9);
  Offset? startPoint;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(overlayControllerProvider, (previous, next) {
      if (previous?.entry != null && next.entry == null) {
        widget.onRemove();
      }
    });
    return Transform.translate(
      offset: offset,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPressStart: (details) {
          setState(() {
            startPoint = details.globalPosition;
          });
        },
        onLongPressMoveUpdate: (details) {
          double dx = min(max(baseOffset.dx + details.globalPosition.dx - startPoint!.dx, 0),
              MediaQuery.sizeOf(context).width - 240);
          double dy = min(max(baseOffset.dy + details.globalPosition.dy - startPoint!.dy, 0),
              MediaQuery.sizeOf(context).height - 240 / 16 * 9 + 100);
          setState(() {
            offset = Offset(dx, dy);
          });
        },
        onLongPressEnd: (details) {
          setState(() {
            baseOffset = offset;
            startPoint = null;
          });
          if (offset.dy - 80 > MediaQuery.sizeOf(context).height - 240 / 16 * 9) {
            ref.read(overlayControllerProvider.notifier).remove();
            widget.onDismiss();
          }
        },
        child: Container(
            constraints: BoxConstraints.loose(const Size(240, 240 / 16 * 9)),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Theme.of(context).colorScheme.onSurface, blurRadius: 4)
            ], borderRadius: BorderRadius.circular(10)),
            child: VideoPlayer(widget.ctrl)),
      ),
    );
  }
}
