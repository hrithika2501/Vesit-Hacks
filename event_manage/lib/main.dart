import 'package:event_manage/pages/addevent.dart';
import 'package:event_manage/pages/addfaculty.dart';
import 'package:event_manage/pages/admin.dart';
import 'package:event_manage/pages/branchadd.dart';
import 'package:event_manage/pages/committeeadd.dart';
import 'package:event_manage/pages/facultyhome.dart';
import 'package:event_manage/pages/login_verif.dart';
import 'package:event_manage/pages/modify_sb.dart';
import 'package:event_manage/pages/sbadd.dart';
import 'package:event_manage/pages/studenthome.dart';
import 'package:flutter/material.dart';
import 'package:event_manage/pages/login.dart';
class myApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Event Management",
      initialRoute: '/',
      routes: {
        '/':(context) => LoginPage(),
        '/studhome':(context) => StudentHome(),
        '/facultyhome':(context) => FacultyHub(),
        '/admin':(context) => AdminHub(),
        '/addevent':(context) => AddEvent(),
        '/verify':(context) => Verification(),
        '/branch':(context) => BranchAdd(),
        '/committee':(context) => ComitteeAdd(),
        '/studbody': (context) => StudBodyAdd(),
        '/modify':(context) => ModifySB(),
        '/modifySB':(context) => UpdateSB()
      },
    );
  }
}
void main(){
  runApp(myApp());
}
