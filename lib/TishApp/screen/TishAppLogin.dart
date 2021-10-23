import 'package:TishApp/TishApp/screen/TishAppDashboard.dart';
import 'package:TishApp/TishApp/screen/TishAppMainPage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/viewmodel/authViewModel.dart';
import 'package:provider/provider.dart';

import 'TishAppSignUp.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool busy = false;
  bool done = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getBool('IsLoggedIn') == true
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TishAppMainPage()),
          )
        // ignore: unnecessary_statements
        : null;
    print(
        "prefs.getBool('IsLoggedIn') ====>>>> ${prefs.getBool('IsLoggedIn')}");
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      constraints: BoxConstraints(maxWidth: 550),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
        setState(() {
          busy = true;
        });
        await Provider.of<AuthViewModel>(context, listen: false)
            .Login(nameController.text, passwordController.text);
        if (Provider.of<AuthViewModel>(context, listen: false).login_response) {
          setState(() {
            busy = false;
            done = true;
          });
          nameController.text = '';
          passwordController.text = '';
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              done = false;
            });

            Navigator.pushNamed(context, '/dashboard');
          });
        } else {
          setState(() {
            done = false;
            busy = false;
          });
          Fluttertoast.showToast(
              webBgColor: "linear-gradient(to right, #ff2196f3, #ff2196bf)",
              msg: "Login Failed \n",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 550),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.blue, Colors.blue.shade400])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      constraints: BoxConstraints(maxWidth: 550),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return GestureDetector(
      onTap: () async {
        print('pressed');
        // final LoginResult result = await FacebookAuth.instance.login();
        // if (result.status == LoginStatus.success) {
        //   // you are logged
        //   final AccessToken accessToken = result.accessToken!;
        //   print(accessToken.toJson());
        //   print(accessToken.token);
        //   dynamic UserInfo = await http.get(Uri.parse(
        //       'https://graph.facebook.com/me?fields=id,name,first_name,last_name,email,picture,name_format,middle_name,short_name&access_token=' +
        //           accessToken.token +
        //           ''));
        //   dynamic temp = jsonDecode(UserInfo.body);
        //   _localStorage.setItem('email', temp['email']);
        //   _localStorage.setItem('name', temp['name']);
        //   Navigator.pushReplacementNamed(context, '/dashboard');
        // }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 550),
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1959a9),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('f',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff2872ba),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('Log in with Facebook',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 550),
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'T',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.blue,
          ),
          children: [
            TextSpan(
              text: 'ish',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'App',
              style: TextStyle(color: Colors.blue, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email/Username", nameController),
        _entryField("Password", passwordController, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // fillFields();
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .1),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  // Container(
                  //   constraints: BoxConstraints(maxWidth: 550),
                  //   padding: EdgeInsets.symmetric(vertical: 10),
                  //   alignment: Alignment.centerRight,
                  //   child: Text('Forgot Password ?',
                  //       style: TextStyle(
                  //           fontSize: 14, fontWeight: FontWeight.w500)),
                  // ),
                  _divider(),
                  _facebookButton(),
                  Center(
                    child: busy
                        ? CircularProgressIndicator()
                        : done
                            ? Text(
                                'Redirecting',
                                style: TextStyle(color: Colors.green),
                              )
                            : Text(''),
                  ),
                  SizedBox(height: height * .003),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
