import 'dart:io';
import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AFBVideoPlayer extends StatefulWidget {
  final String url;

  const AFBVideoPlayer({super.key, required this.url});

  @override
  State<AFBVideoPlayer> createState() => _AFBVideoPlayerState();
}

class _AFBVideoPlayerState extends State<AFBVideoPlayer> {
  ChewieController? ctrl;
  Stream<FileResponse>? stream;
  StreamSubscription? sub;
  VideoPlayerController? vctrl;
  Timer? _dispose;
  File? file;

  @override
  void initState() {
    super.initState();
    stream =
        DefaultCacheManager().getFileStream(widget.url, withProgress: true).asBroadcastStream();
    sub = stream?.listen((event) async {
      if (event is FileInfo) {
        sub?.cancel();
        file = event.file;
        start();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction < 0.8) {
          vctrl?.pause().then((value) => setState(() {}));
        }
        if (info.visibleFraction > 0.85) {
          vctrl?.play().then((value) => setState(() {}));
        }
        if (info.visibleFraction == 0 && vctrl != null && ctrl != null) {
          _dispose = Timer(const Duration(seconds: 10), () {
            deactivate();
            end();
            setState(() {});
          });
        } else if (vctrl == null && ctrl == null) {
          activate();
          start().then((value) => setState(() {}));
          _dispose?.cancel();
          _dispose == null;
        }
      },
      key: ObjectKey(widget.url),
      child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("vid err");
            } else if (!snapshot.hasData || snapshot.data is DownloadProgress) {
              return const Text("vid loading");
            } else {
              return SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width,
                  child: ctrl != null ? Chewie(controller: ctrl!) : Container());
            }
          }),
    );
  }

  Future<void> start() async {
    vctrl = VideoPlayerController.file(file!);
    await vctrl!.initialize();
    ctrl = ChewieController(videoPlayerController: vctrl!);
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
