import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ReqFunc{
  Future<String> signin(String email, String password, String role) async {
    var client = new http.Client();
    var url = 'http://192.168.43.104:5000/login';
    //var url = 'http://192.168.0.179:5000/login';
    var uri = Uri.parse(url);
    Map<String, String> headers = {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    };
    var body = {
      'email': email,
      'password': password,
      'optradio': role
    };
    var response =  await client.post(url, headers: headers ,body: body);
    return response.body;
  }

  Future<String> send_reg_req(String eventID) async {
    var client = new http.Client();
    var url = 'http://192.168.43.104:5000/register';
    //var url = 'http://192.168.0.179:5000/register';
    var uri = Uri.parse(url);
    Map<String, String> headers = {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    };
    var body = {
      'id': eventID,
    };
    var response =  await client.post(uri, headers: headers, body: body);
    return response.body;
  }
  Future<String> add_event_req(var body) async {
    var body_ = new Map<String, String>();
    var headers = new Map<String, String>();
    var client = new http.Client();
    var url = 'http://192.168.43.104:5000/event';
    //var url = 'http://192.168.0.179:5000/event';
    var uri = Uri.parse(url);
    body_ = body;
    headers = {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    };
    print(body.runtimeType);
    var response = await client.post(uri, headers: headers, body: body_);
    return response.body;
  }

  Future<String> request_(var body, var route) async {
    var body_ = new Map<String, String>();
    var headers = new Map<String, String>();
    var client = new http.Client();
    var url = 'http://192.168.43.104:5000'+route;
    //var url = 'http://192.168.0.179:5000'+route;
    var uri = Uri.parse(url);
    body_ = body;
    headers = {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    };
    var response = await client.post(uri, headers: headers, body: body_);
    return response.body;
  }




}