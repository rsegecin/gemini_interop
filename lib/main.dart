import 'package:flutter/material.dart';
import 'package:gemini_interop/common/app_theme.dart';
import 'package:gemini_interop/common/loading_layer.dart';
import 'package:gemini_interop/integration_screen.dart';
import 'package:gemini_interop/services/theme_mode_state.dart';
import 'package:gemini_interop/services/top_layer_service.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider).themeMode;
    final ThemeData themeData = (themeMode == ThemeMode.light)
        ? AppTheme.lightTheme.getLocalized(context)
        : AppTheme.darkTheme.getLocalized(context);

    return Portal(
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        title: 'Flutter Demo',
        builder: (context, child) {
          return PortalTarget(
            visible: ref.watch(topLayerServiceProvider),
            portalFollower: const LoadingLayer(),
            child: ProviderScope(
              overrides: [
                themeDataStateProvider.overrideWithValue(themeData),
              ],
              child: child!,
            ),
          );
        },
        home: const IntegrationScreen(),
      ),
    );
  }
}
