import 'package:flutter/material.dart';
import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:flutter_programming_question_collection/src/utils/constants/route_names.dart';
import 'package:flutter_programming_question_collection/src/utils/view_utils.dart';
import 'package:go_router/go_router.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.fromBookmarkPage,
    required this.questions,
    required this.category,
    required this.index,
  });

  final List<Question> questions;
  final bool fromBookmarkPage;
  final String category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.sizeOf(context).width * .8,
      decoration: ViewUtils.questionCardDecor(),
      margin: const EdgeInsets.all(7),
      child: ListTile(
        onTap: () {
          context.goNamed(
            AppRouteConstant.questionView,
            queryParameters: {
              'index': index.toString(),
              "category": category,
            },
            extra: questions,
          );
        },
        title: Text(
          '${index + 1}. ${questions[index].question}',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: ViewUtils.ubuntuStyle(fontSize: 17, color: Colors.black),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            questions[index].answer,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: ViewUtils.ubuntuStyle(
              fontSize: 15,
              color: Colors.blueGrey.withOpacity(.6).withBlue(155),
            ),
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}
