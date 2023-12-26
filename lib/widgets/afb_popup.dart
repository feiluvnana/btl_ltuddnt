import 'package:Anti_Fakebook/controllers/theme.controller.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:Anti_Fakebook/widgets/afb_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AFBPopUp on BuildContext {
  Future<T?> showAFBOptionModalBottomSheet<T>(
      {Widget? header, required List<List<Widget>> blocks}) {
    final themeData = Theme.of(this);
    return showModalBottomSheet<T>(
        backgroundColor: themeData.colorScheme.onInverseSurface,
        context: this,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (header != null)
                Padding(padding: const EdgeInsets.only(left: 10, right: 10), child: header),
              if (header != null) const SizedBox(height: 8),
              ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: blocks[index]
                              .map((e) => Material(
                                    color: themeData.colorScheme.onPrimary,
                                    child: e,
                                  ))
                              .toList())),
                  itemCount: blocks.length)
            ],
          );
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        showDragHandle: true);
  }

  Future<T?> showAFBDialog<T>(
      {required Widget title, required List<Widget> actions, required Widget content}) {
    return showDialog<T>(
        context: this,
        builder: (context) => AlertDialog(title: title, content: content, actions: actions));
  }

  Future<void> showImageView({required String url}) async {
    await Navigator.push(this, MaterialPageRoute(builder: (context) => _ImageView(url: url)));
  }
}

class _ImageView extends ConsumerStatefulWidget {
  final String url;

  const _ImageView({required this.url});

  @override
  ConsumerState<_ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends ConsumerState<_ImageView> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(themeControllerProvider.notifier).setThemeMode(ThemeMode.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        ref.read(themeControllerProvider.notifier).setThemeMode(ThemeMode.light);
      },
      child: Scaffold(
        appBar: AFBAppBar(
            leading: IconButton(
                onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back))),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: AspectRatio(
                  aspectRatio: 1,
                  child: InteractiveViewer(
                      child: AFBNetworkImage(url: widget.url, fit: BoxFit.contain)))),
        ),
      ),
    );
  }
}
