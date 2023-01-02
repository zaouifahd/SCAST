// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_web/screens/webview_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

import '../constants.dart';
import '../strings.dart';
import '../widgets/admob_service.dart';
import '../widgets/change_theme_button_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    if (showInterstitialAds) {
      AdMobService.createInterstitialAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: !showBottomNavigationBar
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
            )
          : null,
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.color_lens_outlined),
                  title: _buildTitle(CustomStrings.darkMode),
                  trailing: ChangeThemeButtonWidget(),
                ),
                ListTile(
                    leading: Icon(Icons.info_outline_rounded),
                    title: _buildTitle(CustomStrings.aboutUs),
                    onTap: () => _onPressed(WebviewScreen(CustomStrings.aboutUs,
                        CustomStrings.aboutPageContent, aboutPageURL))),
                ListTile(
                    leading: Icon(Icons.lock_outline_rounded),
                    title: _buildTitle(CustomStrings.privacyPolicy),
                    onTap: () => _onPressed(WebviewScreen(
                        CustomStrings.privacyPolicy,
                        CustomStrings.privacyPageContent,
                        privacyPageURL))),
                ListTile(
                    leading: Icon(Icons.miscellaneous_services_outlined),
                    title: _buildTitle(CustomStrings.terms),
                    onTap: () => _onPressed(WebviewScreen(CustomStrings.terms,
                        CustomStrings.termsPageContent, termsPageURL))),
                ListTile(
                  leading: Icon(Icons.share_outlined),
                  title: _buildTitle(CustomStrings.share),
                  onTap: () => Share.share(
                      Platform.isAndroid
                          ? shareAndroidAppMessage
                          : shareiOSAppMessage,
                      subject: Platform.isAndroid
                          ? shareAndroidAppMessage
                          : shareiOSAppMessage),
                ),
                ListTile(
                    leading: Icon(Icons.star_rate_rounded),
                    title: _buildTitle(CustomStrings.rateUs),
                    onTap: () => StoreRedirect.redirect(
                        androidAppId: androidAppId, iOSAppId: iOSAppId))
              ],
            ),
          )),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  void _onPressed(Widget routeName) {
    if (showInterstitialAds) {
      AdMobService.showInterstitialAd();
    }
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) => routeName));
  }
}
