import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:event_manage/widgets/labelled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String e_email,old_password, new_password, _role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              LabelledTextField(
                labelledtext: "Enter Email",
                preIcon: Icons.text_fields_rounded,
                color: Colors.redAccent,
                obscureText: false,
                onChanged: (val) {
                  e_email = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              LabelledTextField(
                labelledtext: "Enter old password",
                preIcon: Icons.lock_rounded,
                color: Colors.redAccent,
                obscureText: true,
                onChanged: (val) {
                  old_password = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              LabelledTextField(
                labelledtext: "Enter new password",
                preIcon: Icons.lock_rounded,
                color: Colors.redAccent,
                obscureText: true,
                onChanged: (val) {
                  new_password = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              DropDownFormField(
                titleText: "Level",
                hintText: "Choose event level",
                value: _role,
                onSaved: (value) {
                  setState(() {
                    _role = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _role = value;
                  });
                },
                dataSource: [
                  {
                    "display": "Student",
                    "value": 'student',
                  },
                  {
                    "display": "Faculty",
                    "value": 'faculty',
                  },
                ],
                textField: 'display',
                valueField: 'value',
              ),
              SizedBox(
                height: 20
              ),
              FlatButton(
                color: Colors.redAccent,
                  onPressed: () async {
                    var body = new Map<String, String>();
                    var headers = new Map<String, String>();
                    var client = new http.Client();
                    //var url = 'http://192.168.0.179:5000/verifydetails';
                    var url = 'http://192.168.43.104:5000/verifydetails';
                    var uri = Uri.parse(url);
                    body = {
                      'oldpassword': old_password,
                      'newpassword': new_password,
                      'type': _role,
                      'email': e_email
                    };
                    headers = {
                      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
                    };
                    print(body);
                    var response = await client.post(uri, headers: headers, body: body);
                    print(response.body);
                    Alert(
                      context: context,
                      title: "Alert",
                      desc: response.body,
                    ).show();
                  },
                  child: Text("Reset",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
}
