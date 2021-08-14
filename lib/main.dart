import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:universal_platform/universal_platform.dart';

import 'TishApp/screen/FoodBookCart.dart';
import 'TishApp/screen/FoodDescription.dart';
import 'TishApp/screen/SearchPage.dart';
import 'TishApp/screen/TishAppDashboard.dart';
import 'TishApp/screen/TishAppLogin.dart';
import 'TishApp/screen/TishAppProfilePage.dart';
import 'TishApp/screen/TishAppSignUp.dart';
import 'TishApp/screen/TishAppWelcomePage.dart';
import 'TishApp/viewmodel/authViewModel.dart';
import 'TishApp/viewmodel/PlaceViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isIos = UniversalPlatform.isIOS;
  bool isWeb = UniversalPlatform.isWeb;
  bool isAndroid = UniversalPlatform.isAndroid;
  if (isWeb) {
    FacebookAuth.i.webInitialize(
      appId: "370299251118262", //<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v11.0",
    );
  }
  runApp(TishApp());
  //endregion
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
      ],
      child: MaterialApp(
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/search': (context) => SearchPage(),
          '/dashboard': (context) => TishAppDashboard(),
          '/TishAppCart': (context) => TishAppBookCart(),
          '/description': (context) => TishAppDescription(),
        },
        title: 'TishApp',
        // home: WelcomePage(),
        home: TishAppDashboard(),
        // home: SearchPage(),
        // home: ProfilePage(),
        builder: scrollBehaviour(),
      ),
    );
  }
}
