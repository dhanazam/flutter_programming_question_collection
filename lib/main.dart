import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/config/router/router_config.dart';
import 'src/presentation/provider/bloc/introduction/introduction_bloc.dart';

void main() {
  runApp(const ProgrammingQuestionCollection());
}

class ProgrammingQuestionCollection extends StatelessWidget {
  const ProgrammingQuestionCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc()..add(AppEvent.get()),
        )
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.loading) return const SizedBox.shrink();
          return MaterialApp.router(
            title: "Programming Question Collection",
            routerConfig: AppRouterConfig.init.config,
          );
        },
      ),
    );
  }
}
