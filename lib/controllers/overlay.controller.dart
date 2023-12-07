import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'overlay.controller.freezed.dart';
part 'overlay.controller.g.dart';

@freezed
class OverlayState with _$OverlayState {
  const factory OverlayState({OverlayEntry? entry}) = _OverlayState;
}

@Riverpod(keepAlive: true)
class OverlayController extends _$OverlayController {
  @override
  OverlayState build() {
    return const OverlayState();
  }

  void insert(OverlayEntry entry, BuildContext context) {
    state = state.copyWith(entry: entry);
    Overlay.of(context).insert(state.entry!);
  }

  void remove() {
    state.entry?.remove();
    state = state.copyWith(entry: null);
  }
}
