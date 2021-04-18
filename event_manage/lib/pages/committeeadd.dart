import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:event_manage/widgets/labelled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:event_manage/modules/request_functions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ComitteeAdd extends StatefulWidget {
  @override
  _ComitteeAddState createState() => _ComitteeAddState();
}

class _ComitteeAddState extends State<ComitteeAdd> {
  String cname, level;
  ReqFunc reqFunc = new ReqFunc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Committee"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LabelledTextField(
                labelledtext: "Enter Comittee Name",
                preIcon: Icons.text_fields_rounded,
                color: Colors.redAccent,
                obscureText: false,
                onChanged: (val) {
                  cname = val;
                },
              ),
              SizedBox(
                height: 40,
              ),
              DropDownFormField(
                titleText: "Level",
                hintText: "Choose level of influcence",
                value: level,
                onSaved: (value) {
                  setState(() {
                    level = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    level = value;
                  });
                },
                dataSource: [
                  {
                    "display": "Institute",
                    "value": '1',
                  },
                  {
                    "display": "Department",
                    "value": '2',
                  },
                  {
                    "display": "Student Body",
                    "value": '3',
                  }
                ],
                textField: 'display',
                valueField: 'value',
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
                    "add": cname,
                    "level": level
                  };
                  var op = await reqFunc.request_(body, "/submit1");
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
                      desc: "Committee was not added",
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
