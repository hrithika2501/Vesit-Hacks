import 'dart:convert';
import 'package:event_manage/pages/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:event_manage/modules/stud_functions.dart';
import 'package:flutter/material.dart';

class FacultyHub extends StatefulWidget {
  @override
  _FacultyHubState createState() => _FacultyHubState();
}


class _FacultyHubState extends State<FacultyHub> {
  var url = 'http://192.168.43.104:5000/home';
  //var url = 'http://192.168.0.179:5000/home';
  var result;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getevents();
  }
  getevents() async {
    var client = new http.Client();
    var uri = Uri.parse(url);
    Map <String, String> headers = {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    };
    var response = await client.get(uri, headers: headers);
    result = json.decode(response.body);
    var index = 0;
    print(Text("From ${(result)[index]['SDate']} ${(result)[index]['STime']} to ${(result)[index]['EDate']} ${(result)[index]['ETime']}"));
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Faculty"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addevent');
                },
                child: Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/modify');
                },
                child: Icon(
                  Icons.person_add,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: SizedBox(
                        height: 700,
                        child: (result != null
                            ? new ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: result.length,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text((result)[index]['Name']),
                                  subtitle: Text("From ${(result)[index]['SDate']} ${(result)[index]['STime']} to ${(result)[index]['EDate']} ${(result)[index]['ETime']}"),
                                ),
                                Divider()
                              ],
                            );
                          },
                        ) : Center(
                          child: CircularProgressIndicator(),
                        )
                        )
                    )
                ),
              ]
          ),
        ),
      ),
    );
  }
}