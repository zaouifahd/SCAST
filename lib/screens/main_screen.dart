import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pro_web/constants.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';
import '../provider/navigationBarProvider.dart';
import '../screens/home_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final GlobalKey<NavigatorState> _homeNavigatorKey =
      GlobalKey<NavigatorState>();
  late AnimationController navigationContainerAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));
  @override
  void dispose() {
    navigationContainerAnimationController.dispose();
    super.dispose();
    // dispose controller
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context
          .read<NavigationBarProvider>()
          .setAnimationController(navigationContainerAnimationController);
    });
    initFirebaseState();
  }

  void initFirebaseState() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {}
    });
    _firebaseMessaging.getToken().then((value) {
      print(value);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    ));
    return WillPopScope(
      onWillPop: () => _navigateBack(context),
      child: SafeArea(
        child: Scaffold(
          extendBody: false,
          body: Navigator(
            key: _homeNavigatorKey,
            initialRoute: 'home',
            onGenerateRoute: (routeSettings) {
              return MaterialPageRoute(builder: (_) => const HomeScreen());
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _navigateBack(BuildContext context) async {
    if (mounted) {
      if (!context
          .read<NavigationBarProvider>()
          .animationController
          .isAnimating) {
        context.read<NavigationBarProvider>().animationController.reverse();
      }
    }
    final isFirstRouteInCurrentTab =
        !await _homeNavigatorKey.currentState!.maybePop();

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
}
