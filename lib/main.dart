import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:net_working/model/cats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Some cat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Cat cat = Cat();

  void getJokeAndUpdate() async {
    Cat responseCat = await getCat();

    setState(() {
      cat = responseCat;
    });
  }

  Future<Cat> getCat() async {
    final Map<String, String> queryParam = {"json": "true"};

    var url = Uri.https("cataas.com", "/cat", queryParam);

    var response = await http.get(
      url,
      headers: {"accept": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      return Cat.build(
        jsonResponse['url'],
        jsonResponse['id'],
        jsonResponse['created_at'],
      );
    } else {
      throw Exception("ERROR STATUS CODE IS:" + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Center(
            child: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
          ),
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cat.imageUrl != null)
              Container(
                margin: const EdgeInsets.all(8),
                child: Image.network(
                  cat.imageUrl,
                  height: 250,
                  width: 300,
                ),
              ),
            if (cat.created != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(
                    flex: 4,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      cat.created,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
          ],
        ),
      ),
      backgroundColor: Colors.cyan,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        elevation: 20,
        onPressed: () {
          getJokeAndUpdate();
        },
        tooltip: 'One more cat',
        child: Icon(
          Icons.autorenew,
          color: Colors.black,
        ),
      ),
    );
  }
}
