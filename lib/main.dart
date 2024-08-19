import 'package:flutter/material.dart';

import 'src/config/router/router_config.dart';

void main() {
  runApp(const ProgrammingQuestionCollection());
}

class ProgrammingQuestionCollection extends StatelessWidget {
  const ProgrammingQuestionCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouterConfig.init.config,
    );
  }
}
