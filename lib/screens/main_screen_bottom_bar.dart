import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pro_web/constants.dart';
import 'package:pro_web/provider/theme_provider.dart';
import 'package:pro_web/screens/web_url_screen.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';
import '../provider/navigationBarProvider.dart';
import '../widgets/GlassBoxCurve.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _selectedIndex = 1;
  var _previousIndex;
  late TabController _tabController;
  late AnimationController idleAnimation;
  late AnimationController onSelectedAnimation;
  late AnimationController onChangedAnimation;
  Duration animationDuration = const Duration(milliseconds: 700);

  late AnimationController navigationContainerAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));

  final List<GlobalKey<NavigatorState>> _navigatorKeys =
      kTabs.map((e) => GlobalKey<NavigatorState>()).toList();

  List<Widget> _tabsScreen = [];

  @override
  void dispose() {
    super.dispose();
    // dispose controller
    _tabController.dispose();
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
    onChangedAnimation.dispose();
    navigationContainerAnimationController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
    onChangedAnimation =
        AnimationController(vsync: this, duration: animationDuration);

    Future.delayed(Duration.zero, () {
      context
          .read<NavigationBarProvider>()
          .setAnimationController(navigationContainerAnimationController);
    });

    initFirebaseState();
    // for settings screen
    _navigatorKeys.add(GlobalKey<NavigatorState>());
    _tabsScreen = _buildTabScreens();
  }

  void initFirebaseState() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {}
    });
    _firebaseMessaging.getToken().then((value) {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // var data = message.notification!;
      // var title = data.title.toString();
      // var body = data.body.toString();
      // var image = message.data['image'] ?? '';
      // print(image);
      // print(data);
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: notificationIcon,
                ),
                iOS: const IOSNotificationDetails()));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).cardColor,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    ));
    return WillPopScope(
      onWillPop: () => _navigateBack(context),
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                CurvedAnimation(
                    parent: navigationContainerAnimationController,
                    curve: Curves.easeInOut)),
            child: SlideTransition(
                position: Tween<Offset>(
                        begin: Offset.zero, end: const Offset(0.0, 1.0))
                    .animate(CurvedAnimation(
                        parent: navigationContainerAnimationController,
                        curve: Curves.easeInOut)),
                child: _bottomNavigationBar),
          ),
          body: Stack(children: [
            IndexedStack(
              index: _selectedIndex,
              children: _tabsScreen,
            ),
          ]),
        ),
      ),
    );
  }

  Future<bool> _navigateBack(BuildContext context) async {
    if (Platform.isIOS && Navigator.of(context).userGestureInProgress) {
      return Future.value(true);
    }
    final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_selectedIndex].currentState!.maybePop();
    if (!context
        .read<NavigationBarProvider>()
        .animationController
        .isAnimating) {
      context.read<NavigationBarProvider>().animationController.reverse();
    }
    if (!isFirstRouteInCurrentTab) {
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Do you want to exit app?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ));

      return Future.value(true);
    }
  }

  Widget get _bottomNavigationBar {
    return Container(
      height: 65,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: ThemeGuide.isDarkMode(context)
            ? const [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 40,
                )
              ]
            : const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 40,
                )
              ],
      ),
      child: GlassBoxCurve(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: buildTabs(),
        ),
      ),
    );
  }

  List<Widget> buildTabs() {
    final temp = <Widget>[];
    for (var i = 0; i < kTabs.length; ++i) {
      final o = kTabs[i];
      temp.add(_buildNavItem(i, o['tabName'], Icon(o['icon'])));
    }

    temp.add(
        _buildNavItem(kTabs.length, 'Settings', const Icon(Icons.settings)));
    return temp;
  }

  Widget _buildNavItem(int index, String title, Widget icon) {
    return InkWell(
      onTap: () {
        onButtonPressed(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 10.0),
          Opacity(
            opacity: _selectedIndex == index ? 1 : 0.5,
            child: icon,
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: _selectedIndex == index
                  ? TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    )
                  : const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void onButtonPressed(int index) {
    if (_navigatorKeys[_selectedIndex].currentState!.canPop()) {
      //
      _navigatorKeys[_selectedIndex]
          .currentState!
          .popUntil((route) => route.isFirst);
    }
    onSelectedAnimation.reset();
    onSelectedAnimation.forward();

    onChangedAnimation.value = 1;
    onChangedAnimation.reverse();

    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
      if (!context
          .read<NavigationBarProvider>()
          .animationController
          .isAnimating) {
        context.read<NavigationBarProvider>().animationController.reverse();
      }
    });
  }

  List<Widget> _buildTabScreens() {
    final temp = <Widget>[];

    for (var i = 0; i < kTabs.length; ++i) {
      var o = kTabs[i];
      temp.add(Navigator(
        key: _navigatorKeys[i],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (_) => WebUrlScreen(o['url']));
        },
      ));
    }

    temp.add(Navigator(
      key: _navigatorKeys.last,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      },
    ));
    return temp;
  }
}
