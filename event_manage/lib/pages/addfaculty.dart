import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModifySB extends StatefulWidget {
  @override
  _ModifySBState createState() => _ModifySBState();
}

class _ModifySBState extends State<ModifySB> {
  var url = 'http://192.168.43.104:5000/modifysb';
  //var url = 'http://192.168.0.179:5000/modifysb';
  var result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsb();
  }
  getsb() async {

    var headers = new Map<String, String>();
    var client = new http.Client();
    var uri = Uri.parse(url);

    headers = {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    };
    var response = await client.get(uri, headers: headers);
    result = json.decode(response.body);
    var index = 0;
    print(result);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modify Student Body"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
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
                  Navigator.pushNamed(context, '/modifySB');
                }),
              ),
              Container(
                  height: MediaQuery
                      .of(context)
                      .copyWith()
                      .size
                      .height / 2.5,
                  child: (result != null
                      ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: result.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                      title: Text(
                        "${(result)[index]['StudentId'].toString()}\t\t ${(result)[index]['Name']}"
                      ),
                      subtitle: Text(
                          "Year: ${(result)[index]['Year'].toString()}\t\t Gender: ${(result)[index]['Gender']} \nDOB: ${(result)[index]['DOB']}\t\t"
                      ),
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
      ),
    );
  }
}