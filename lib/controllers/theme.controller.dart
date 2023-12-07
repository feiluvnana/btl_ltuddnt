import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "theme.controller.freezed.dart";
part "theme.controller.g.dart";

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({ThemeMode? themeMode}) = _ThemeState;
}

@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeState build() {
    return const ThemeState();
  }

  void setThemeMode(ThemeMode themeMode) {
    state = ThemeState(themeMode: themeMode);
  }
}
