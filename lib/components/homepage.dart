import 'package:auto_app/components/favorite.dart';
import 'package:auto_app/components/search.dart';
import 'package:auto_app/components/settings.dart';
import 'package:auto_app/components/themeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomePageState extends State<HomePage> {
  PersistentTabController _controller = PersistentTabController();

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    void _requestPermissions() {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navbarsItems(),
      confineInSafeArea: true,
      backgroundColor: (provider.isDarkMode ? Colors.black : Colors.white),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      navBarStyle: NavBarStyle.style9,
    );
  }
}

List<Widget> _buildScreens() {
  return [
    Settings(),
    Search(),
    Favorite(),
  ];
}

List<PersistentBottomNavBarItem> _navbarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.settings_solid),
      title: "Настройки",
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.search),
      title: "Поиск",
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.bookmark),
      title: "Избранное",
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
