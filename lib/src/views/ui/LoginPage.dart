import 'dart:convert';
import 'package:firstflutterapp/src/buniness_logic/models/AuthenticationResponseModel.dart';
import 'package:firstflutterapp/src/views/ui/ForgotPasswordPage.dart';
import 'package:firstflutterapp/src/views/ui/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firstflutterapp/src/buniness_logic/models/AuthenticationModel.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailTextField = new TextEditingController();
  TextEditingController passwordTextField = new TextEditingController();

  LoginPage() {
    emailTextField.text = "hello@feathersjs.com";
    passwordTextField.text = "supersecret";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset(
                        'assets/images/edify_safety_logo_1@3x@3x.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 0),
              // padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailTextField,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordTextField,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: () {
                forgotPassword(context);
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  loginPost(context);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.all(10),
              child: Text(
                "Version e1.0",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future loginPost(BuildContext context) async {
    var authenticationModel = AuthenticationModel(
            email: emailTextField.text,
            password: passwordTextField.text,
            strategy: "local")
        .toJson();

    // var email = emailTextField.text;
    // var password = passwordTextField.text;
    var client = http.Client();
    try {
      var uriResponse = await client.post(
          Uri.parse('https://racetrack-api.azurewebsites.net/authentication'),
          body: authenticationModel);
      print("Status Code - " + uriResponse.statusCode.toString());
      if (uriResponse.statusCode == 201) {
        Map<String, dynamic> userMap = jsonDecode(uriResponse.body);
        var user = AuthenticationResponseModel.fromJson(userMap);
        print(user);
        // Navigator.push(
        //               context, MaterialPageRoute(builder: (_) => HomePage()));
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      } else {
        _showMyDialog(context);
      }
      print("Body - " + uriResponse.body);
      print("Reason Phrase - " + uriResponse.reasonPhrase);

      // print(await client.get(uriResponse.bodyFields['uri']));
    } finally {
      client.close();
    }
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Alert!'),
                Text('Unable to Login, Please try again!!!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void forgotPassword(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
  }
}
