import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/app/Translations.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/ui/NotFoundPage.dart';
import 'package:gitclub/ui/Splash.dart';
import 'package:gitclub/ui/home/HomePage.dart';
import 'package:gitclub/ui/login/login.dart';
import 'package:gitclub/ui/meizi/BeautiesPage.dart';
import 'package:gitclub/ui/my/PersonPage.dart';
import 'package:gitclub/ui/register/register.dart';
import 'package:gitclub/ui/search/SearchPage.dart';
import 'package:gitclub/ui/settings/SetPage.dart';
import 'package:gitclub/ui/submit/SubmitPage.dart';
import 'package:gitclub/ui/video/VideoPage.dart';

//首页
class GitClubApp extends StatefulWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<StatefulWidget> createState() {
    return GitClubAppState();
  }
}

class GitClubAppState extends State<GitClubApp> {
  static SpecificLocalizationDelegate localeOverrideDelegate;

  @override
  void initState() {
    super.initState();
    init();
    // Initializes a callback should something need
    // to be done when the language is changed
    allTranslations.onLocaleChangedCallback = _onLocaleChanged;
  }

  void init() async {
    await allTranslations.init();
  }

  _onLocaleChanged() async {
    // do anything you need to do if the language changes
    print('Language has been changed to: ${allTranslations.currentLanguage}');
  }

  @override
  Widget build(BuildContext context) {
    return materialApp;
  }

  static final materialApp = MaterialApp(
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: <String, WidgetBuilder>{
      "/home": (BuildContext context) => HomePage(),
      "/search": (BuildContext context) => SearchPage(null),
      "/login": (BuildContext context) => LoginPage(),
      "/register": (BuildContext context) => RegisterPage(),
      "/set": (BuildContext context) => SetPage(),
      "/person": (BuildContext context) => PersonPage(),
      "/submit": (BuildContext context) => SubmitPage(),
      "/meizi": (BuildContext context) => BeautiesPage(),
      "/video": (BuildContext context) => VideoPage()
    },
    onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
        builder: (context) => new NotFoundPage(
              appTitle: Constants.coming_soon,
              icon: Icons.error,
              title: Constants.coming_soon,
              message: "Under Development",
              iconColor: Colors.green,
            )),
    theme: new ThemeData(
        primaryColor: AppColors.colorPrimary,
        accentColor: AppColors.colorPrimary),
    home: SplashPage(),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: allTranslations.supportedLocales(),
  );
}
