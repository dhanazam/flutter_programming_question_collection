import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/category/category_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/widgets/question_card.dart';
import 'package:flutter_programming_question_collection/src/utils/view_utils.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<StatefulWidget> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    context
        .read<CategoryBloc>()
        .add(CategoryEvent.fetchBookmarkedQuestionsStart());
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'home.bookmarks'.tr(),
          style: ViewUtils.ubuntuStyle(fontSize: 19),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
            controller: _tabController,
            tabs: [
              DefaultTextStyle(
                style: const TextStyle().isActive(_tabController.index == 0),
                child: Text('home.questions'.tr()),
              ),
              DefaultTextStyle(
                style: const TextStyle().isActive(_tabController.index == 1),
                child: Text('home.books'.tr()),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.loading!) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final qCategories = state.questionCategories;
              if (qCategories!.isEmpty) {
                return const Center(
                  child: Text('No Saved Questions'),
                );
              }

              return ListView.builder(
                itemCount: qCategories.length,
                itemBuilder: (context, index) {
                  final qCategory = qCategories[index];
                  if (qCategory.questions!.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return ExpansionTile(
                    title: Text(
                      qCategory.name!,
                      style: ViewUtils.ubuntuStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: qCategory.questions!.length,
                        itemBuilder: (context, qIndex) {
                          return QuestionCard(
                            questions: qCategory.questions!,
                            category: qCategory.name!,
                            fromBookmarkPage: true,
                            index: qIndex,
                          );
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

extension on TextStyle {
  isActive(bool isActive) {
    switch (isActive) {
      case true:
        return const TextStyle(
          color: Colors.black,
          fontSize: 16,
        );

      default:
        return const TextStyle(
          color: Colors.black,
          fontSize: 14,
        );
    }
  }
}
