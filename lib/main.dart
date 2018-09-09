import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main(){
  runApp(MaterialApp(
    home: simpixiedata(),
  ));
}

class simpixiedata extends StatefulWidget{
  @override
  simpixiestate createState() => simpixiestate();
}

class simpixiestate extends State<simpixiedata>{
  /*final String url = "https://simpixie.com/api/android/Gameidx/slim-api/public/news/";*/
  final String url = "https://simpixie.com/api/response.php";
  List data;

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(url),headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["message"]; //isi dari datanya message "message":[{//
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simpixie"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Text("Kode :"),
                          Text(data[index]["code"],
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54
                            ),
                          ),
                          Text("Harga :"),
                          Text(data[index]["price"],
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54
                            ),
                          ),
                        ],
                      )

                    ),
                  ),



//                  Card(
//                    child: Container(
//                      padding: EdgeInsets.all(15.0),
//                      child: Text(data[index]["price"],
//                        style: TextStyle(
//                            fontSize: 18.0,
//                            color: Colors.black54
//                        ),),
//                    ),
//                  )



                ],
              ),
            ),
          );
        },
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}