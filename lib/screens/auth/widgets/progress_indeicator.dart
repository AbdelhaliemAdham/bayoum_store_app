import 'package:flutter/material.dart';

class LoadingIndicatorFb2 extends StatelessWidget {
  const LoadingIndicatorFb2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      
      semanticsLabel: 'Loading',
      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
    );
  }
}
