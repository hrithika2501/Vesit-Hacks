import 'dart:convert';
import 'package:event_manage/pages/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}


class _StudentHomeState extends State<StudentHome> {
  //var url = 'http://192.168.0.179:5000/home';
  var url = 'http://192.168.43.104:5000/home';
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
    Map<String, String> headers = {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    };
    var response = await client.get(uri, headers: headers);
    result = json.decode(response.body);
    print(result);
    var index = 0;
    print(Text("From ${(result)[index]['SDate']} ${(result)[index]['STime']} to ${(result)[index]['EDate']} ${(result)[index]['ETime']}"));
    setState(() {});
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Hello Student"),
          backgroundColor: Colors.redAccent,
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

                                              trailing: Icon(Icons.arrow_forward_ios),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => EventRegister(
                                                          id: (result)[index]['EventID'].toString(),
                                                          name: (result)[index]['Name'],
                                                          desc: result[index]['Description'],
                                                          eligibility: result[index]['e_year'].toString(),
                                                          level: result[index]['LevelID'].toString(),
                                                          SDate: result[index]['SDate'],
                                                          STime: result[index]['STime'],
                                                          EDate: result[index]['EDate'],
                                                          ETime: result[index]['ETime'],
                                                        ),
                                                    ),
                                                );
                                              },
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
                //Row(
                //  mainAxisAlignment: MainAxisAlignment.center,
                //  children: [
                //    FlatButton(
                //      color: Colors.redAccent,
                //      child: Text('Registered events',
                //        style: TextStyle(
                //            color: Colors.white
                //        ),
                //      ),
                //      onPressed: () {
//
                //      },
                //    ),
                //    SizedBox(
                //      height: 50,
                //    ),
                //  ],
                //),
              ]
            ),
          ),
        ),
      );
    }
  }


