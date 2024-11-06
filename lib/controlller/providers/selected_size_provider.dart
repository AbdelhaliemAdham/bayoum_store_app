import 'package:flutter_riverpod/flutter_riverpod.dart';

final sizeProvider = StateNotifierProvider<SelectedSizeProvider, String>(
    (ref) => SelectedSizeProvider());

class SelectedSizeProvider extends StateNotifier<String> {
  SelectedSizeProvider() : super('');

  void selectSize(String size) {
    state = size;
    state = size;
    
  }
}
