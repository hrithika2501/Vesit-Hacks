import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:event_manage/modules/request_functions.dart';
import 'package:event_manage/widgets/labelled_text_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ReqFunc authprovider = ReqFunc();
  String _email,_password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Event Manager",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(
                height: 80,
              ),
              LabelledTextField(
                labelledtext: "Enter Email",
                preIcon: Icons.text_fields_rounded,
                color: Colors.redAccent,
                obscureText: false,
                onChanged: (val) {
                  _email = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              LabelledTextField(
                labelledtext: "Enter password",
                preIcon: Icons.lock_rounded,
                color: Colors.redAccent,
                obscureText: true,
                onChanged: (val) {
                  _password = val;
                },
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    color: Colors.redAccent,
                    child: Text(
                      'Student Login',
                        style: TextStyle(
                          color: Colors.white
                        ),
                    ),
                    onPressed: () async {
                      var op = await authprovider.signin(_email, _password, 'student');
                      print(op);
                      if (op == "logged in"){
                        Navigator.pushNamed(context, '/studhome');
                      }else if (op == "Admin"){
                        Navigator.pushNamed(context, '/admin');
                      }else{
                        Alert(
                            context: context,
                            title: "Caution",
                            desc: op.toString(),
                        ).show();
                      }
                    },
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  FlatButton(
                    color: Colors.redAccent,
                    child: Text('Faculty Login',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () async {
                      var op = await authprovider.signin(_email, _password, 'faculty');
                      print(op);
                      if (op == "Admin"){
                        Navigator.pushNamed(context, '/admin');
                      }else if (op == 'success') {
                        Navigator.pushNamed(context, '/facultyhome');
                      }else {
                      Alert(
                        context: context,
                        title: "Caution",
                        desc: op.toString(),
                      ).show();
                    }
                    },
                  ),
                ],
              ),
              SizedBox(
                  height: 20
              ),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/verify');
                    }, icon: Icon(Icons.info_outline_rounded, size: 15,), label: Text("Forgot Password ?", style: TextStyle(fontSize: 12),))
            ],
          ),
        ),
      ),
    );
  }
}