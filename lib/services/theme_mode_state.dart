import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_state.g.dart';

// This provider value is overriden on main app build
@Riverpod(dependencies: [])
// ignore: functional_ref
ThemeData themeDataState(Ref ref) {
  throw UnimplementedError();
}

// ChangeNotifierProvider is always alive
final themeModeProvider =
    ChangeNotifierProvider<ThemeModeNotifier>((ref) => ThemeModeNotifier(ref));

class ThemeModeNotifier extends ChangeNotifier {
  final Ref ref;
  ThemeMode themeMode = ThemeMode.system;

  ThemeModeNotifier(this.ref) {
    if (kDebugMode) {
      print("building themeNotifier");
    }

    setThemeMode(ThemeMode.dark);
  }

  static ThemeMode getSystemTheme() {
    ThemeMode mode = ThemeMode.system;
    if (mode == ThemeMode.system) {
      if (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light) {
        mode = ThemeMode.light;
      } else {
        mode = ThemeMode.dark;
      }
    }
    return mode;
  }

  setThemeMode(ThemeMode tm) {
    themeMode = tm;
  }

  void toggleThemeMode() {
    if (themeMode == ThemeMode.system) {
      themeMode = getSystemTheme();
    }

    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}

extension LocalizeThemeData on ThemeData {
  ThemeData getLocalized(BuildContext context) {
    final MaterialLocalizations? localizations =
        Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    final ScriptCategory category =
        localizations?.scriptCategory ?? ScriptCategory.englishLike;
    return ThemeData.localize(this, typography.geometryThemeFor(category));
  }
}
