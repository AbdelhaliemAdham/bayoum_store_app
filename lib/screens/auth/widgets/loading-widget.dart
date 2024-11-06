import 'package:flutter/material.dart';

class LoadingIndicator {
  static void show(BuildContext context) {
    OverlayEntry entry = OverlayEntry(
      builder: (context) => _LoadingIndicator(),
    );
    Overlay.of(context).insert(entry);
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class _LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
