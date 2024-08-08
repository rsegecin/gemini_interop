import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_layer_service.g.dart';

@riverpod
class TopLayerService extends _$TopLayerService {
  @override
  bool build() {
    return false;
  }

  showProcessing() {
    state = true;
  }

  hideProcessing() {
    state = false;
  }
}
