import 'package:event_manage/modules/request_functions.dart';
import 'package:event_manage/widgets/labelled_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpdateSB extends StatefulWidget {
  @override
  _UpdateSBState createState() => _UpdateSBState();
}

class _UpdateSBState extends State<UpdateSB> {
  ReqFunc reqFunc = new ReqFunc();
  String sid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Members"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LabelledTextField(
                labelledtext: "Enter Student ID",
                preIcon: Icons.text_fields_rounded,
                color: Colors.redAccent,
                obscureText: false,
                onChanged: (val) {
                  sid = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                color: Colors.blueAccent,
                  onPressed: () async {
                    var body = {
                      "studentID" : sid
                    };
                    var res = await reqFunc.request_(body, '/modifysb');
                    if(res == 'success'){
                      Alert(
                        context: context,
                        title: "Alert",
                        desc: "Success",
                      ).show();
                    }else{
                      Alert(
                        context: context,
                        title: "Alert",
                        desc: "Student body was not modified",
                      ).show();
                    }
                  },
                  child: Text("Add", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
