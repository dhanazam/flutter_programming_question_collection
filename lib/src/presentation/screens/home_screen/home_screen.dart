import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/questions/question_bloc.dart';
import 'package:flutter_programming_question_collection/src/utils/constants/categories.dart';
import 'package:flutter_programming_question_collection/src/utils/constants/category_titles.dart';
import 'package:flutter_programming_question_collection/src/utils/constants/interview_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<QuestionBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addQuestionsToCache();
  }

  void addQuestionsToCache() async {
    for (var category in InterviewCategories.categories.toList()) {
      _bloc.add(QuestionEvent.addQuestionsInitial(
          category, context.locale.languageCode));
    }
  }

  String category = '';
  late QuestionBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
      listener: (context, state) {
        if (!state.loading!) {}
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: GridView.builder(
          itemBuilder: (context, index) {
            final card =
                CategoryCards.cards(CategoryTitles.homeCategory[index]);
            return GestureDetector(
              onTap: () async {},
              child: card,
            );
          },
          addRepaintBoundaries: false,
          addAutomaticKeepAlives: true,
          physics: const BouncingScrollPhysics(),
          itemCount: InterviewCategories.categories.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 1,
            mainAxisSpacing: 30,
          ),
        ),
      ),
    );
  }
}
