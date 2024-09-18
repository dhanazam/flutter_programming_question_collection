import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:flutter_programming_question_collection/src/presentation/widgets/index.dart';
import 'package:flutter_programming_question_collection/src/utils/index.dart';
import 'package:flutter_programming_question_collection/src/utils/view_utils.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.questions,
    required this.category,
  });

  final List<Question> questions;
  final String category;

  @override
  State<StatefulWidget> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen>
    with QuestionCardMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWithSearchSwitch(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return QuestionCard(
            category: widget.category,
            fromBookmarkPage: false,
            questions: searchedList,
            index: index,
          );
        },
        padding: const EdgeInsets.only(top: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: searchedList.length,
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: false,
      ),
      backgroundColor: Colors.white,
    );
  }

  AppBarWithSearchSwitch _appBarWithSearchSwitch() {
    return AppBarWithSearchSwitch(
      onChanged: (input) {
        setState(() {});
        searchedList = widget.questions.where((v) {
          return v.question.contains(input.toLowerCase());
        }).toList();
      },
      appBarBuilder: (context) => AppBar(
        centerTitle: false,
        title: Text(
          widget.category,
          style: ViewUtils.ubuntuStyle(fontSize: 19),
        ),
        actions: const [AppBarSearchButton()],
      ),
      elevation: 0,
      backgroundColor: AppColors.primary,
      titleTextStyle: const TextStyle(),
    );
  }
}

mixin QuestionCardMixin on State<QuestionsScreen> {
  final searchBarController = TextEditingController();

  late List<Question> searchedList;

  @override
  void initState() {
    super.initState();
    searchedList = widget.questions;
  }

  void clearSearchBar() {
    searchBarController.clear();
    searchedList = widget.questions;
    setState(() {});
  }
}
