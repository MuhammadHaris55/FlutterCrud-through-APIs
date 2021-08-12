import 'dart:convert';
import 'package:create_read_through_api/screens/getData.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class updateData extends StatefulWidget {
  final List jsondata;
  var index;


  updateData({
    // required Key key,
    required this.jsondata,
    this.index,
  })
      // : super(key: key)
  ;

  @override
  _updateDataState createState() => _updateDataState();
}

class _updateDataState extends State<updateData> {

  Future<http.Response> updatedata(var id, var name, var email) async {
  // Future<http.Response> updatedata(var id, var name, var email) {
    print("$id   $name   $email");
    var url ='https://thevitaldesigning.com/projects/billionaire-solutions/public/api/test-flutter-update/$id';

    Map data = {
      // 'apikey': '12345678901234567890',
      // 'id': id,
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

  // var name, email;

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    var preName = widget.jsondata[widget.index]['name'];
    var preEmail = widget.jsondata[widget.index]['name'];

    name.text = widget.jsondata[widget.index]['name'];
    email.text = widget.jsondata[widget.index]['email'];

    var screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'Update Data'
        ),
        centerTitle: true,

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
                controller: name,
                // initialValue: preName,
                // onChanged: (value) => name = value,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                ),
                controller: email,
                // initialValue: preEmail,
                // onChanged: (value) => email = value,
              ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     hintText: "Enter your email",
              //   ),
              //   onChanged: (value) => email = value,
              // ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: (){
                  updatedata(widget.jsondata[widget.index]['id'], name.text, email.text);

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
