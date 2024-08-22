import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
        screenIndex.isEqual(0) ? 'Category' : 'Library',
      ),
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
    );
  }

  List<BottomNavigationBarItem> get _buildItems {
    return [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.library_books), label: 'library')
    ];
  }
}

extension on int {
  bool isEqual(int value) => this == value;
}
