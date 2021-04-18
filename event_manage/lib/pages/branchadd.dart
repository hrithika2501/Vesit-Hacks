import 'package:event_manage/widgets/labelled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:event_manage/modules/request_functions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BranchAdd extends StatefulWidget {
  @override
  _BranchAddState createState() => _BranchAddState();
}

class _BranchAddState extends State<BranchAdd> {
  ReqFunc reqFunc = new ReqFunc();
  String _branch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Branch"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LabelledTextField(
                labelledtext: "Enter Branch Name",
                preIcon: Icons.text_fields_rounded,
                color: Colors.redAccent,
                obscureText: false,
                onChanged: (val) {
                  _branch = val;
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
                    "add": _branch
                  };
                  var op = await reqFunc.request_(body, "/submit");
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
                      desc: "Branch was not added",
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
