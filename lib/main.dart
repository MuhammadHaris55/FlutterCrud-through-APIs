import 'package:create_read_through_api/screens/getData.dart';
import 'package:create_read_through_api/screens/postData.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Post n Fetch data through API\'s'),
      home: getData(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: screen.width / 1.1,
          child: Wrap(
            children: [

              ElevatedButton(

                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => getData()));
                },
                child: Text(
                  'Get data from API',
                ),),
              Container(
                height: 20.0,
              ),
              ElevatedButton(

                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => addData()));
                },
                child: Text(
                'Post data with API',
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// Text(
// 'You have pushed the button this many times:',
// ),
// Text(
// '$_counter',
// style: Theme.of(context).textTheme.headline4,
// ),
// ],
// ),

// floatingActionButton: FloatingActionButton(
// onPressed: _incrementCounter,
// tooltip: 'Increment',
// child: Icon(Icons.add),
// ),