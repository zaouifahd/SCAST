// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../constants.dart';
import '../main.dart';
import '../provider/navigationBarProvider.dart';
import '../widgets/load_web_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late AnimationController navigationContainerAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context
          .read<NavigationBarProvider>()
          .setAnimationController(navigationContainerAnimationController);
    });
  }

  @override
  void dispose() {
    navigationContainerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Column(children: const [
          Flexible(child: LoadWebView(url: websiteInitialUrl, flag: true)),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FadeTransition(
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
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    setState(() {
                      navigatorKey.currentState!.pushNamed('settings');
                    });
                  },
                ))));
  }
}
