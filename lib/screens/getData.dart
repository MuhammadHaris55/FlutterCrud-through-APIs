import 'dart:convert';

import 'package:create_read_through_api/screens/postData.dart';
import 'package:create_read_through_api/screens/updateData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class getData extends StatefulWidget {
  @override
  _getDataState createState() => _getDataState();
}

class _getDataState extends State<getData> {

  var items = [];
  late Map data;
  late List _notes;

  @override
  void initState(){
    refreshData();
    super.initState();

    // fetchAlbum();
  }

  Future refreshData() async {
    Uri uri = Uri.parse('https://thevitaldesigning.com/projects/billionaire-solutions/public/test-flutter');

    final response = await http.get(uri);
    var data = json.decode(response.body);
    this.items = [];

    setState(() {
      for (var i = 0; i < data['Data'].length; i++){
        this.items.add(data['Data'][i]);

      }
      // print(this.items[0]);
      _notes = data['Data'];

    });
  }



  fetchAlbum() async {
    var url = 'https://thevitaldesigning.com/projects/billionaire-solutions/public/test-flutter';
    var response = await http
        .get(Uri.parse(url), headers: {"content-type": "application/json"}).then((value){
      print(value.statusCode);
      // if (value.statusCode == 200) {
        print(value.body);
        setState(() {
          data = json.decode(value.body);
          _notes = data['Data'];
        });
        print('after decode');
        print(_notes[0]['id']);
      // }
    });


    try {
      var response = await http
          .get(Uri.parse(url), headers: {"content-type": "application/json"});

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          data = json.decode(response.body);
          _notes = data['Data'];
        });
        print('after decode');
        print(_notes[0]['id']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<http.Response> postRequest (var id) async {
    var url ='https://thevitaldesigning.com/projects/billionaire-solutions/public/api/test-flutter-delete/$id';

    Map data = {
      // 'apikey': '12345678901234567890',
      'id': id,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},

    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  deleteData(var id) async {
    var url = 'https://thevitaldesigning.com/projects/billionaire-solutions/public/api/test-flutter-delete/$id';
    try {
      var response = await http
          .get(Uri.parse(url), headers: {"content-type": "application/json"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          data = json.decode(response.body);
          _notes = data['Data'];
        });
        print('after decode');
        print(_notes[0]['id']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'Data from the API',
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => addData()));
          }, icon: Icon(Icons.add)),
        ],
      ),

      // body: _notes == null
      body: items == []
          ? Center(child: Text("Data is loading"))
          : RefreshIndicator(
        onRefresh: refreshData,
            child: ListView.builder(
        // itemCount: _notes.length,
        // itemBuilder: (context, int index) {
    itemCount: items.length,
        itemBuilder: (context, index) {
            return Center(
              child: Container(
                padding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => updateData(
                              jsondata: _notes,
                              // jsondata: items[index],
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // _notes[index]['name'],
                              items[index]['name'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _notes[index]['email'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        deleteData(_notes[index]['id']);
                        refreshData();
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
        },
      ),
          ),
 // : Text('hadb'),
    );
  }
}
