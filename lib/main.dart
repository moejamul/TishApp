import 'dart:io';

import 'package:TishApp/TishApp/viewmodel/Place_BadgeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:universal_platform/universal_platform.dart';

import 'TishApp/screen/FoodBookCart.dart';
import 'TishApp/screen/PlaceDescription.dart';
import 'TishApp/screen/SearchPage.dart';
import 'TishApp/screen/TishAppMainPage.dart';
import 'TishApp/screen/TishAppLogin.dart';
import 'TishApp/screen/TishAppProfilePage.dart';
import 'TishApp/screen/TishAppSignUp.dart';
import 'TishApp/screen/TishAppWelcomePage.dart';
import 'TishApp/viewmodel/Place_TypeViewModel.dart';
import 'TishApp/viewmodel/authViewModel.dart';
import 'TishApp/viewmodel/PlaceViewModel.dart';

final GlobalKey<NavigatorState> navigator =
    GlobalKey<NavigatorState>(); //Create a key for navigator
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isIos = UniversalPlatform.isIOS;
  bool isWeb = UniversalPlatform.isWeb;
  bool isAndroid = UniversalPlatform.isAndroid;
  if (isWeb) {
    // FacebookAuth.i.webInitialize(
    //   appId: "370299251118262", //<-- YOUR APP_ID
    //   cookie: true,
    //   xfbml: true,
    //   version: "v11.0",
    // );
  }
  runApp(TishApp());
}

class TishApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider<PlaceViewModel>(
          create: (_) => PlaceViewModel(),
        ),
        ChangeNotifierProvider<Place_TypeViewModel>(
          create: (_) => Place_TypeViewModel(),
        ),
        ChangeNotifierProvider<Place_BadgeViewModel>(
          create: (_) => Place_BadgeViewModel(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/welcome': (context) => WelcomePage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/search': (context) => SearchPage(),
          '/dashboard': (context) => TishAppMainPage(),
          '/TishAppCart': (context) => TishAppBookCart(),
        },
        title: 'TishApp',
        home: WelcomePage(),
        // home: TishAppMainPage(),

        builder: scrollBehaviour(),
        navigatorKey: navigator,
      ),
    );
  }
}
