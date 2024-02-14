import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ingredients_scanner/router/router.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

@RoutePage()
class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  final items = const [
    Icon(
      Icons.menu,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.qr_code_scanner,
      size: 30,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter.pageView(
      routes: const [
        UserMenuRoute(),
        HomeRoute(),
        ScannerRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: CurvedNavigationBar(
            index: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: items,
            height: 70,
            backgroundColor: Colors.white,
            color: theme.primaryColor,
            animationDuration: const Duration(milliseconds: 300),
          ),
        );
      },
    );
  }
}
