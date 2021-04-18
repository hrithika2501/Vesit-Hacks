import 'package:event_manage/modules/request_functions.dart';
import 'package:event_manage/widgets/labelled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StudBodyAdd extends StatefulWidget {
  @override
  _StudBodyAddState createState() => _StudBodyAddState();
}

class _StudBodyAddState extends State<StudBodyAdd> {
  String sb_name;
  ReqFunc reqFunc = new ReqFunc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student Body"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LabelledTextField(
                labelledtext: "Enter Body Name",
                preIcon: Icons.text_fields_rounded,
                color: Colors.redAccent,
                obscureText: false,
                onChanged: (val) {
                  sb_name = val;
                },
              ),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                color: Colors.redAccent,
                child: Text('Add',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: () async {
                  var body = {
                    "add": sb_name
                  };
                  var op = await reqFunc.request_(body, "/submit2");
                  print(op);
                  if (op == "Successful"){
                    Alert(
                      context: context,
                      title: "Alert",
                      desc: op.toString(),
                    ).show();
                  }else {
                    Alert(
                      context: context,
                      title: "Alert",
                      desc: "Body was not added",
                    ).show();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
