import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../util/logger.dart';

part 'loading_provider.g.dart';

@riverpod
class Loading extends _$Loading {
  @override
  bool build() {
    ref.onDispose(() {
      logger.info('dispose.');
    });

    return false;
  }

  Future<T> wrap<T>(Future<T> future) {
    return Future.microtask(present).then((_) => future).whenComplete(dismiss);
  }

  void present() {
    state = true;
  }

  void dismiss() {
    state = false;
  }
}
