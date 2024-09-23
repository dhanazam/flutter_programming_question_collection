import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_programming_question_collection/gen/assets.gen.dart';
import 'package:flutter_programming_question_collection/src/utils/constants/route_names.dart';
import 'package:flutter_programming_question_collection/src/utils/index.dart';
import 'package:flutter_programming_question_collection/src/utils/view_utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'src/presentation/screens/drawer_screen/index.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.body});
  final StatefulNavigationShell body;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  void goBranch(index) => widget.body.goBranch(
        index,
        initialLocation: index == widget.body.currentIndex,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.body.currentIndex),
      body: widget.body,
      drawer: widget.body.currentIndex.isEqual(0)
          ? DrawerView(key: ValueKey(context.locale.languageCode))
          : null,
      bottomNavigationBar: _BottomNavBar(
          changeScreen: goBranch, screenIndex: widget.body.currentIndex),
    );
  }

  AppBar appBar(int screenIndex) {
    return AppBar(
      title: Text(
        screenIndex.isEqual(0) ? 'home.categories'.tr() : 'home.library'.tr(),
        style: ViewUtils.ubuntuStyle(fontSize: 19),
      ),
      centerTitle: false,
      elevation: 0,
      actions: [
        screenIndex.isEqual(0)
            ? IconButton(
                onPressed: () => context.goNamed(AppRouteConstant.bookmark),
                icon:
                    SvgPicture.asset(Assets.svg.bookmark, color: Colors.white),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.screenIndex, required this.changeScreen});

  final ValueChanged<int> changeScreen;
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _buildItems,
      onTap: changeScreen,
      currentIndex: screenIndex,
      selectedItemColor: AppColors.primary,
      backgroundColor: Colors.white,
      selectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 15),
      unselectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 13),
    );
  }

  List<BottomNavigationBarItem> get _buildItems {
    return [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home), label: 'home.home'.tr()),
      BottomNavigationBarItem(
          icon: const Icon(Icons.auto_stories), label: 'home.library'.tr()),
    ];
  }
}

extension on int {
  bool isEqual(int value) => this == value;
}
