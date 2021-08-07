import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'TishApp/screen/FoodBookCart.dart';
import 'TishApp/screen/FoodDescription.dart';
import 'TishApp/screen/FoodViewRestaurants.dart';
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
          '/viewRestaurants': (context) => TishAppViewRestaurants(),
          '/description': (context) => TishAppDescription(),
        },
        title: 'TishApp',
        home: WelcomePage(),
        // home: TishAppDashboard(),
        // home: SearchPage(),
        // home: ProfilePage(),
        builder: scrollBehaviour(),
      ),
    );
  }
}
