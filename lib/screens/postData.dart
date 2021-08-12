import 'dart:convert';

import 'package:create_read_through_api/screens/getData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class addData extends StatefulWidget {
  @override
  _addDataState createState() => _addDataState();
}

class _addDataState extends State<addData> {

  Future<http.Response> postRequest (var name, var email) async {
    var url ='https://thevitaldesigning.com/projects/billionaire-solutions/public/test-flutter-post';

    Map data = {
      // 'apikey': '12345678901234567890',
      'name': name,
      'email': email,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  var name, email;
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Post Data with API"),
      ),
      body: Center(
        child: Container(
          width: screen.width / 1.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your name",
                ),
                onChanged: (value) => name = value,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                ),
                onChanged: (value) => email = value,
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: (){
                  postRequest(name, email);

                  Navigator.push(context, MaterialPageRoute(builder: (context) => getData()));
                },
                  child: Text(
                    'Submit response',
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
