import 'package:flutter/material.dart';
import 'package:flutter_programming_question_collection/src/presentation/widgets/spinkit_circle_loading_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(child: KSpinKitCirlce()),
    );
  }
}
