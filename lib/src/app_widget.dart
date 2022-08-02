

import 'package:flutter/material.dart';
import 'package:rpgaming/src/pages/create-account/continue_create_account_page.dart';
import 'package:rpgaming/src/pages/create-account/create_account_page.dart';
import 'package:rpgaming/src/pages/forgot-password/forgot-password-page.dart';
import 'package:rpgaming/src/pages/load/load_page.dart';
import 'package:rpgaming/src/pages/login/login_page.dart';
import 'package:rpgaming/src/pages/report-error/report_error_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: TextStyle(color: Color(0xFF2D3140)),
          elevation: 7,
        ),
        primaryColor: const Color(0xFF666CDE),
        secondaryHeaderColor: const Color(0xFFAAAAAA),
        canvasColor: const Color(0xFFAAAAAA),
        backgroundColor: const Color(0xFF121222),
        scaffoldBackgroundColor: const Color(0xFF121222),        
        primarySwatch: createMaterialColor(const Color(0xFF666CDE)), 
        // cardColor: const Color(0xFFAAAAAA),
        unselectedWidgetColor:const Color(0xFFAAAAAA),
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          headline1: TextStyle(color: Color(0xFFAAAAAA), fontSize: 16),
          headline2: TextStyle(color: Color(0xFFAAAAAA), fontSize: 16),
          bodyText2: TextStyle(color: Color(0xFFAAAAAA), fontSize: 16),
          subtitle1: TextStyle(color: Color(0xFFAAAAAA), fontSize: 16),
        ),
        fontFamily: 'Sahitya',
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const LoadPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/create-account': (BuildContext context) => const CreateAccountPage(),
        '/continue-create-account': (BuildContext context) => const ContinueCreateAccountPage(),
        '/forgot-password': (BuildContext context) => const ForgotPasswordPage(),
        '/report-error': (BuildContext context) => const ReportErrorPage(error: 'null',),
      },
      initialRoute: '/',
    );
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}



