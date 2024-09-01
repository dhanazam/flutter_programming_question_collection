import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_programming_question_collection/gen/assets.gen.dart';
import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:flutter_programming_question_collection/src/utils/index.dart';
import 'package:flutter_programming_question_collection/src/utils/view_utils.dart';
import 'package:flutter_svg/svg.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.questions,
    required this.category,
    required this.index,
  });

  final List<Question> questions;
  final String category;
  final int index;

  @override
  State<StatefulWidget> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionScreen> with _QuestionViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        key: ValueKey(currentIndex),
        controller: _scrollerController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '${currentIndex + 1}/${questions.length}',
                  style:
                      ViewUtils.ubuntuStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  Assets.svg.bookmark,
                  color: Colors.white,
                  height: 19,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: _AnswerView(question: questions[currentIndex]),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ChangeButton(
                child: 'home.previous'.tr(), onPressed: _goToPreviousQuestion),
            _ChangeButton(
                child: 'home.next'.tr(), onPressed: _goToNextQuestion),
          ],
        ),
      ),
    );
  }
}

class _ChangeButton extends StatelessWidget {
  _ChangeButton({
    required this.child,
    required this.onPressed,
  });

  final style = ViewUtils.ubuntuStyle(
    fontSize: 15,
    color: AppColors.primary,
  );

  final String child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          side: MaterialStateProperty.all(
            const BorderSide(
              color: AppColors.primary,
              strokeAlign: 10,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          child,
          style: style,
        ),
      );
}

class _AnswerView extends StatelessWidget {
  const _AnswerView({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        question.answer,
        textAlign: TextAlign.center,
        style: ViewUtils.ubuntuStyle(
          fontSize: 19,
          color: const Color.fromARGB(255, 89, 97, 107),
        ),
      ),
    );
  }
}

mixin _QuestionViewMixin on State<QuestionScreen> {
  late int currentIndex;
  late List<Question> questions;
  late ScrollController _scrollerController;

  Color appBarColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    questions = widget.questions;
    currentIndex = widget.index;

    _scrollerController = ScrollController()
      ..addListener(
        () {
          if (_scrollerController.offset > 200) {
            setState(() => appBarColor = AppColors.primary);
          } else if (_scrollerController.offset <= 200) {
            setState(() => appBarColor = Colors.transparent);
          }
        },
      );
  }

  void _goToNextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    }
  }

  void _goToPreviousQuestion() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }
}
