import 'package:flutter/material.dart';
import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:flutter_programming_question_collection/src/presentation/widgets/index.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.questions,
    required this.category,
  });

  final List<Question> questions;
  final String category;

  @override
  State<StatefulWidget> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with QuestionCardMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
}

mixin QuestionCardMixin on State<QuestionScreen> {
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