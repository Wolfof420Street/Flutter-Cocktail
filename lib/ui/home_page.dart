import 'package:cocktails/ui/category_screen.dart';
import 'package:cocktails/ui/favorites-screen.dart';
import 'package:cocktails/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  final List<Widget> _pageList = [];

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);

    _pageList.add(const HomeScreen());
    _pageList.add(const CategoryScreen());
    _pageList.add(const GlassesScreen());
  }

  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          inactiveColorPrimary: Colors.white,
          activeColorPrimary: const Color(0xFFFFB300),
          icon: const Align(
            child: Icon(Icons.home_filled),
          ),
          title: ('Home'),
        ),
        PersistentBottomNavBarItem(
          inactiveColorPrimary: Colors.white,
          activeColorPrimary: const Color(0xFFFFB300),
          icon: const Align(
            child: Icon(Icons.wine_bar),
          ),
          title: ('Category'),
        ),
        PersistentBottomNavBarItem(
          inactiveColorPrimary: Colors.white,
          activeColorPrimary: const Color(0xFFFFB300),
          icon: const Align(
            child: Icon(Icons.wine_bar_outlined),
          ),
          title: ('Glasses'),
        ),
      ];
    }

    return Scaffold(
        body: PersistentTabView(
      context,
      controller: _controller,
      screens: _pageList,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: const Color(0xFF2A5DAB),
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    ));
  }
}
