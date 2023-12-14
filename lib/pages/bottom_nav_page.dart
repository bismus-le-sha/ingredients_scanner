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
      Icons.person,
      size: 30,
    ),
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.qr_code_scanner,
      size: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: const [
        UserMenuRoute(),
        HomeRoute(),
        ScannerRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
              title: Text(context.topRoute.name),
              leading: const AutoLeadingButton()),
          body: child,
          bottomNavigationBar: CurvedNavigationBar(
            index: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: items,
            height: 70,
            backgroundColor: Colors.transparent,
            animationDuration: const Duration(milliseconds: 300),
          ),
        );
      },
    );
  }
}
