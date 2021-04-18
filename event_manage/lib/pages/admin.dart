import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminHub extends StatefulWidget {
  @override
  _AdminHubState createState() => _AdminHubState();
}

class _AdminHubState extends State<AdminHub> {
  var url = 'http://192.168.43.104:5000/admin';
  //var url = 'http://192.168.0.179:5000/admin';
  var result;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettables();
  }
  gettables() async {
    var client = new http.Client();
    var uri = Uri.parse(url);
    Map<String, String> headers = {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    };
    var response = await client.get(uri, headers: headers);
    result = jsonDecode(response.body);
    print(result);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SuperAdmin"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).copyWith().size.height / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.greenAccent,
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Branch", style: TextStyle(fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),
                    Expanded(
                      child: GestureDetector(onTap: () {
                        Navigator.pushNamed(context, '/branch');
                      }),
                    ),
                    Container(
                        height: MediaQuery.of(context).copyWith().size.height / 2.5,
                        child: (result != null
                        ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: result['branch'].length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                  "${(result['branch'])[index]['BranchID']}\t\t${(result['branch'])[index]['BranchName']}"),
                            ),
                            Divider()
                          ],
                        );
                      },
                    ) : Center(
                      child: CircularProgressIndicator(),
                    )))
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .copyWith()
                    .size
                    .height / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.purpleAccent,
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Committee", style: TextStyle(fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),
                    Expanded(
                      child: GestureDetector(onTap: () {
                        Navigator.pushNamed(context, '/committee');
                      }),
                    ),
                    Container(
                        height: MediaQuery.of(context).copyWith().size.height / 2.5,
                        child: (result != null
                        ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: result['comm'].length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                  "${(result['comm'])[index]['commID']}\t\t${(result['comm'])[index]['Name']}"),
                              subtitle: Text(
                                  "Level: ${(result['comm'])[index]['level'] != '1' ? ((result['comm'])[index]['level'] != '2' ? "Department" : "Student Body") : "Institute"}"),
                            ),
                            Divider()
                          ],
                        );
                      },
                    ) : Center(
                      child: CircularProgressIndicator(),
                    )))
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .copyWith()
                    .size
                    .height / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.blueAccent,
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Student Body", style: TextStyle(fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),
                    Expanded(
                      child: GestureDetector(onTap: () {
                        Navigator.pushNamed(context, '/studbody');
                      }),
                    ),
                    Container(
                        height: MediaQuery.of(context).copyWith().size.height / 2.5,
                      child: (result != null
                        ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: result['sb'].length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                  "${(result['sb'])[index]['CID']}\t\t${(result['sb'])[index]['name']}"),
                            ),
                            Divider()
                          ],
                        );
                      },
                    ) : Center(
                      child: CircularProgressIndicator(),
                    )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

