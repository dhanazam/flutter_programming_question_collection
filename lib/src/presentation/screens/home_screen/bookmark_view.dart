import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_programming_question_collection/gen/assets.gen.dart';
import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/category/category_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/widgets/index.dart';
import 'package:flutter_programming_question_collection/src/utils/constants/route_names.dart';
import 'package:flutter_programming_question_collection/src/utils/view_utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
    final width = MediaQuery.sizeOf(context).width * 0.5;
    final height = MediaQuery.sizeOf(context).height * 0.3;
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
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.loading!) {
                return const Center(child: CircularProgressIndicator());
              }
              final bCategories = state.bookCategories;
              if (bCategories!.isEmpty) {
                return const Center(
                  child: Text('No Saved Books'),
                );
              }
              return ListView.builder(
                itemCount: bCategories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final bCategory = bCategories[index];
                  if (bCategory.books!.isEmpty) return const SizedBox.shrink();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                          child: Text(
                            bCategory.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            ...bCategory.books!.map(
                              (book) {
                                return GestureDetector(
                                  onTap: () {
                                    context.goNamed(
                                      AppRouteConstant.bookmarkedBookView,
                                      extra: BookViewDetails(
                                        book: book,
                                        category: bCategory.name,
                                        otherBooks: [],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Hero(
                                          tag: book.name,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              SizedBox(
                                                height: height,
                                                width: width,
                                                child: CachedNetworkImage(
                                                  imageUrl: book.imageUrl,
                                                  progressIndicatorBuilder:
                                                      (context, url, progress) {
                                                    return const KShimmer();
                                                  },
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Transform.scale(
                                                      scale: .15,
                                                      child: SvgPicture.asset(
                                                          Assets.svg
                                                              .connectionLost),
                                                    );
                                                  },
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ))),
                                );
                              },
                            ),
                          ]),
                        ),
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
