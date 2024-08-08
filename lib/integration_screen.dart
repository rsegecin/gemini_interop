import 'package:flutter/material.dart';
import 'package:gemini_interop/services/integration_service.dart';
import 'package:gemini_interop/services/theme_mode_state.dart';
import 'package:gemini_interop/services/top_layer_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntegrationScreen extends HookConsumerWidget {
  const IntegrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData themeData = ref.watch(themeDataStateProvider);
    final controller = useTextEditingController();

    ref.watch(integrationServiceProvider);

    Future onTapConvertFile() async {
      ref.read(topLayerServiceProvider.notifier).showProcessing();

      controller.text =
          await ref.read(integrationServiceProvider.notifier).convertFile();

      ref.read(topLayerServiceProvider.notifier).hideProcessing();
    }

    Future onTapGenerateMultipleFiles() async {
      ref.read(topLayerServiceProvider.notifier).showProcessing();

      await ref
          .read(integrationServiceProvider.notifier)
          .generateMultipleFiles();

      ref.read(topLayerServiceProvider.notifier).hideProcessing();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Text(
                      "Flutter Backend Integration",
                      style: themeData.textTheme.headlineMedium,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: (ref.watch(themeModeProvider).themeMode ==
                              ThemeMode.light)
                          ? const Icon(Icons.dark_mode)
                          : const Icon(Icons.light_mode),
                      onPressed: () {
                        ref.read(themeModeProvider).toggleThemeMode();
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                    child: const Text("Convert a file"),
                    onPressed: () {
                      onTapConvertFile();
                    },
                  ),
                  FilledButton(
                    child: const Text("Generate multiple files"),
                    onPressed: () {
                      onTapGenerateMultipleFiles();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller,
                minLines: 20,
                maxLines: 2000,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
