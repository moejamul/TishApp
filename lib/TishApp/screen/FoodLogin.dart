import 'dart:async';

import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/TishApp/viewmodel/authViewModel.dart';
import 'package:flutter/material.dart';
import 'package:prokit_flutter/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:provider/provider.dart';

import 'FoodDashboard.dart';

class FoodLogIn extends StatefulWidget {
  @override
  FoodLogIn_State createState() => FoodLogIn_State();
}

class FoodLogIn_State extends State<FoodLogIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool busy = false;
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('TishApp'),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(maxWidth: 400),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                              child: Text('Login'),
                              onPressed: () async {
                                setState(() {
                                  busy = true;
                                });
                                await Provider.of<AuthViewModel>(context,
                                        listen: false)
                                    .Login(nameController.text,
                                        passwordController.text);
                                if (Provider.of<AuthViewModel>(context,
                                        listen: false)
                                    .login_response) {
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
                                      msg: "Login Failed \n",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.blueGrey,
                                      textColor: Colors.black87,
                                      fontSize: 16.0);
                                }
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: Text('Forgot your password?'),
                                onTap: () {
                                  Navigator.pushNamed(context, '/dashboard');
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
                  ],
                ),
              ),
            )));
  }
}
