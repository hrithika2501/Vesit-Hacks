import 'package:flutter/material.dart';
import 'package:event_manage/modules/request_functions.dart';
import 'package:toast/toast.dart';

class EventRegister extends StatelessWidget {
  final String id, name, desc, eligibility, level, SDate, STime, EDate, ETime;
  EventRegister({Key key, @required this.id, @required this.name, @required this.desc, @required this.eligibility, @required this.level, @required this.SDate, @required this.STime, @required this.EDate, @required this.ETime}) : super(key: key);
  ReqFunc eventReg = new ReqFunc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Event Details",),
              backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.event_available_outlined,
                size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                    "${name}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30
            ),
            FractionallySizedBox(
              alignment: Alignment.topCenter,
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  border: Border.all(
                    color: Colors.red[200],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: MediaQuery.of(context).copyWith().size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "\n\t${desc}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "(You have to be atleast Year-${eligibility} to participate)",
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("Start DateTime: ${STime} ${SDate}", style: TextStyle(color: Colors.grey)),
                  Text("End DateTime: ${ETime} ${EDate}", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    color: Colors.redAccent,
                      onPressed: () async {
                      print(id);
                      var res = await eventReg.send_reg_req(id);
                      print(res);
                      Toast.show("Enrollment Complete", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                      },
                    child: Text("Enroll", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                      ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
