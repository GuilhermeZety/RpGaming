




// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rpgaming/src/pages/notification/notification-page.dart';
import 'package:rpgaming/src/pages/profile/profile-page.dart';
import 'Cache.dart';
import 'styles/CustomTheme.dart';

import 'pages/create-account/continue_create_account_page.dart';
import 'pages/create-account/create_account_page.dart';
import 'pages/forgot-password/change-password-page.dart';
import 'pages/forgot-password/forgot-password-page.dart';
import 'pages/home/home_page.dart';
import 'pages/load/load_page.dart';
import 'pages/login/login_page.dart';
import 'pages/report-error/report_error_page.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var themeData = CustomTheme().theme;

Color _primary = themeData.primaryColor;
FToast fToast = FToast();

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);
  
  @override
  State<AppWidget> createState() => _AppWidgetState();  

  static void setTheme(BuildContext context, Color newColor) {    
    _AppWidgetState? state = context.findAncestorStateOfType<_AppWidgetState>();

    Cache().setPrimaryColor(newColor);

    state?.setState(() {
     _primary = newColor;
    });
  }
}

class _AppWidgetState extends State<AppWidget> {

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    Timer.run(() => onLoaded());
  }
  
  onLoaded() async {
    var color = await Cache().getPrimaryColor();

    if(color != null){
      setState(() {
        _primary = color;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // theme: customTheme.theme,
      theme: themeData.copyWith(
        primaryColor: _primary,
        colorScheme: ColorScheme.dark(
          primary: _primary,
          secondary: _primary.withOpacity(0.8)
        )
      ),      
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'),
        Locale('en'),
      ],
      locale: Locale('pt'),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const LoadPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/create-account': (BuildContext context) => const CreateAccountPage(),
        '/continue-create-account': (BuildContext context) => const ContinueCreateAccountPage(),
        '/forgot-password': (BuildContext context) => const ForgotPasswordPage(),
        '/change-password': (BuildContext context) => const ChangePasswordPage(),
        '/report-error': (BuildContext context) => const ReportErrorPage(error: 'null',),
        '/home': (BuildContext context) => const HomePage(),
        '/notifications': (BuildContext context) => const NotificationPage(),
        '/profile': (BuildContext context) => const ProfilePage(),
      },
      initialRoute: '/',
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}

