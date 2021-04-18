import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:event_manage/modules/request_functions.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  ReqFunc req_ = new ReqFunc();
  String _name, _desc, _branch, _level, _comm, _e_year, _CID, _sdate, _edate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Events"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  var body =
                    {
                      "name" : _name,
                      "des" : _desc,
                      "start" : _sdate,
                      "end" : _edate,
                      "sb" : _CID,
                      "comm": _comm,
                      "branch": _branch,
                      "level": _level,
                      "year": _e_year
                    };
                  print(body);
                  var res = await req_.add_event_req(body);
                  print(res);
                  if (res == "Successful") {
                    Navigator.pop(context);
                    Alert(
                      context: context,
                      title: "Success",
                      desc: "Event Added",
                    ).show();
                  }
                  },
                child: Icon(
                  Icons.check,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(

            children: [
              TextField(
                onChanged: (value) {
                  _name = value;
                },
              decoration: InputDecoration(
                labelText: "Event Name",
              )
              ),
              SizedBox(
                height: 10
              ),
              TextField(
                  onChanged: (value) {
                    _desc = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Description",
                  )
              ),
              SizedBox(
                  height: 10
              ),
              DateTimeFormField(
                decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'Start Date Time',
                ),
                onDateSelected: (val) {
                  _sdate = DateFormat('yyyy-MM-dd – kk:mm').format(val);
                  print(_sdate);
                },
              ),
              SizedBox(
                  height: 10
              ),
              DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'End Date Time',
                ),
                onDateSelected: (val) {
                  _edate = DateFormat('yyyy-MM-dd – kk:mm').format(val);
                  print(_edate);
                },
              ),
              DropDownFormField(
                titleText: "Branch",
                hintText: "Choose proper branch",
                value: _branch,
                onSaved: (value) {
                  setState(() {
                    _branch = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _branch = value;
                  });
                },
                dataSource: [
                  {
                    "display": "ALL",
                    "value": '1',
                  },
                  {
                    "display": "CMPN",
                    "value": '2',
                  },
                  {
                    "display": "IT",
                    "value": '3',
                  },
                  {
                    "display": "EXTC",
                    "value": '4',
                  },
                  {
                    "display": "ETRX",
                    "value": '5',
                  },
                  {
                    "display": "INST",
                    "value": '6',
                  },
                  {
                    "display": "AIDS",
                    "value": '7',
                  },
                ],
                textField: 'display',
                valueField: 'value',
              ),
              DropDownFormField(
                titleText: "Level",
                hintText: "Choose event level",
                value: _level,
                onSaved: (value) {
                  setState(() {
                    _level = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _level = value;
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
              DropDownFormField(
                titleText: "Committee",
                hintText: "Choose proper committee",
                value: _comm,
                onSaved: (value) {
                  setState(() {
                    _comm = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _comm = value;
                  });
                },
                dataSource: [
                  {
                    "display": "CR",
                    "value": '1',
                  },
                  {
                    "display": "SORT",
                    "value": '2',
                  },
                  {
                    "display": "MUSIC",
                    "value": '3',
                  },
                  {
                    "display": "SPORT",
                    "value": '4',
                  },
                  {
                    "display": "NONE",
                    "value": '5',
                  },
                ],
                textField: 'display',
                valueField: 'value',
              ),
              DropDownFormField(
                titleText: "Eligible Students",
                hintText: "Choose year",
                value: _e_year,
                onSaved: (value) {
                  setState(() {
                    _e_year = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _e_year = value;
                  });
                },
                dataSource: [
                  {
                    "display": "ALL",
                    "value": '1',
                  },
                  {
                    "display": "CSI",
                    "value": '2',
                  },
                  {
                    "display": "IEEE",
                    "value": '3',
                  },
                  {
                    "display": "ISA",
                    "value": '4',
                  },
                  {
                    "display": "ISTE",
                    "value": '5',
                  },
                  {
                    "display": "NONE",
                    "value": '6',
                  }
                ],
                textField: 'display',
                valueField: 'value',
              ),
              DropDownFormField(
                titleText: "Student Body",
                hintText: "Choose a student body",
                value: _CID,
                onSaved: (value) {
                  setState(() {
                    _CID = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _CID = value;
                  });
                },
                dataSource: [
                  {
                    "display": "FE",
                    "value": '1',
                  },
                  {
                    "display": "SE",
                    "value": '2',
                  },
                  {
                    "display": "TE",
                    "value": '3',
                  },
                  {
                    "display": "BE",
                    "value": '4',
                  }
                ],
                textField: 'display',
                valueField: 'value',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
