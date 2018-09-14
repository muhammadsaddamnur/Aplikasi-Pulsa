import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final crdPulsa = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        height: 80.0,
        child: new Card(
            child: new InkWell(
              onTap: (){print("tapped");},
              child: new ListTile(
                leading: new Icon(Icons.phone, color: Colors.lightBlue,size: 26.0,),
                title: new Text("Pulsa"),
                subtitle: new Text("Ayo Isi Pulsa Disini Lebih Murah"),
              ),
            ),
        ),
      ),
    );


    final crdData = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        height: 80.0,
        child: new Card(
          child: new InkWell(
            onTap: (){print("tapped");},
            child: new ListTile(
              leading: new Icon(Icons.wifi, color: Colors.lightBlue,size: 26.0,),
              title: new Text("Paket Data"),
              subtitle: new Text("Paket Data Lebih Hemat"),
            ),
          ),
        ),
      ),
    );


    final crdToken = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        height: 80.0,
        child: new Card(
          child: new InkWell(
            onTap: (){print("tapped");},
            child: new ListTile(
              leading: new Icon(Icons.battery_charging_full, color: Colors.lightBlue,size: 26.0,),
              title: new Text("Token Listrik"),
              subtitle: new Text("Isi Token Listrikmu"),
            ),
          ),
        ),
      ),
    );

    return new MaterialApp(
      title: "",
      home: new Scaffold(appBar: new AppBar(
        title: new Text("Hello"),
      ),
        body: new Container(
          margin: new EdgeInsets.only(top: 300.0),
          child: new Column(
            children: <Widget>[
              crdPulsa,
              crdData,
              crdToken
            ],
          ),
        ),
      ),
    );
  }

}

