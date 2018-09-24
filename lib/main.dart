import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './detailpesanan.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Basics',
      home: Main_Menu(),
      routes: <String, WidgetBuilder>{
        '/Main_Menu': (BuildContext context) => new Main_Menu(),
        '/Pulsa': (BuildContext context) => new Pulsa(),
        '/PaketData': (BuildContext context) => new PaketData(),
        '/Listrik': (BuildContext context) => new Listrik(),
      },
    ));
  });
}


//Halaman-------------------------------------------------------------------------------------------------------------------

class Main_Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final crdPulsa = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        height: 80.0,
        child: new Card(
          child: new InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/Pulsa');
            },
            child: new ListTile(
              leading: new Icon(
                Icons.phone,
                color: Colors.lightBlue,
                size: 26.0,
              ),
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
            onTap: () {
              Navigator.pushNamed(context, '/PaketData');
            },
            child: new ListTile(
              leading: new Icon(
                Icons.wifi,
                color: Colors.lightBlue,
                size: 26.0,
              ),
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
            onTap: () {
              Navigator.pushNamed(context, '/Listrik');
            },
            child: new ListTile(
              leading: new Icon(
                Icons.battery_charging_full,
                color: Colors.lightBlue,
                size: 26.0,
              ),
              title: new Text("Token Listrik"),
              subtitle: new Text("Isi Token Listrikmu"),
            ),
          ),
        ),
      ),
    );

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Hello"),
        ),
        body: new Container(
          margin: new EdgeInsets.only(top: 300.0),
          child: new Column(
            children: <Widget>[crdPulsa, crdData, crdToken],
          ),
        ),
      ),
    );
  }
}





//Halaman Pulsa ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class Pulsa extends StatefulWidget {
  @override
  _Pulsa createState() => _Pulsa();
}

class _Pulsa extends State<Pulsa> {
  String kodeNomor = "";
  String jenis="";

  //final String url = "https://simpixie.com/api/response.php";
  final String url = "https://simpixie.com/api/didagang/slim-api/public/produk/";
  List data;

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(url+"?operator=$kodeNomor&jenis=$jenis"),headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["data"]; //isi dari datanya message "message":[{//
    });

    return "Success";
  }


  @override
  Widget build(BuildContext context) {

    //Objek !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    final lblPulsa = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
      child: new SizedBox(
        child: new Container(
            child: new Text("Isi Ulang Pulsa",
                style: new TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20.0,
                  color: Colors.blue,
                ))),
      ),
    );

    final nomer = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        child: new Container(
          child: new TextField(
            onChanged: cekpaket,
            maxLines: 1,
            keyboardType: TextInputType.phone,
            decoration: new InputDecoration(
              icon: const Icon(Icons.contact_phone),
              hintText: 'Nomor Handphone',
            ),),
        ),
      ),
    );


    final card = ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap:()=>Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context)=>new detailpesanan(list: data,index: index,)
                      )
                  ),
                  child: new Card(
                    child: new ListTile(
                      title: Text(data[index]["nama"],
                        style: TextStyle(
                            fontSize: 7.0,
                            color: Colors.black54
                        ),
                      ),
                      leading: new Icon(Icons.widgets),
                      subtitle: Text(data[index]["harga"],
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.black54
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      },
    );

    //Objek !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


    //Render ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "",
      home: new Scaffold(
        appBar: new AppBar(title: new Text("Produk"),leading: new IconButton(icon: new Icon(Icons.arrow_back), onPressed: () => Navigator.pushNamed(context, '/Main_Menu'),), ),
        body: new Container(
          margin: new EdgeInsets.only(top: 10.0),
          child: new Column(
            children: <Widget>[
              lblPulsa,
              nomer,
              new Text(kodeNomor),
              new Expanded(
                  child: card
              )
            ],
          ),
        ),
      ),
    );
    //Render ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


  }

  //methods????????????????????????????????????????????????????????????????????????????????????????????????????????????????
  @override
  void initState() {
    super.initState();
    this.getSWData();
  }


  void cekpaket(String value) {
    setState(() {
      var kodepulsa = value.substring(0, 4);
      kodeNomor = kodepulsa;
      switch (kodepulsa) {
        case "":
          kodeNomor = "";
          jenis = "pulsa";
          this.getSWData();
          break;
        case "0878":
          kodeNomor = "xl";
          jenis = "pulsa";
          this.getSWData();
          break;
        case "0838":
          kodeNomor = "axis";
          jenis = "pulsa";
          this.getSWData();
          break;
        default :
          kodeNomor = "";
          jenis = "pulsa";
          this.getSWData();

      }

    });
  }

//methods????????????????????????????????????????????????????????????????????????????????????????????????????????????????



}
//Halaman Pulsa ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++







class Listrik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final lblListrik = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
      child: new SizedBox(
        child: new Container(
            child: new Text("Isi Token Listrik",
                style: new TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20.0,
                  color: Colors.blue,
                ))),
      ),
    );

    final nomer = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        child: new Container(
          child: new TextFormField(
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                icon: const Icon(Icons.contact_phone),
                hintText: 'Nomor Handphone',
              )),
        ),
      ),
    );



    return new MaterialApp(
      title: "",
      home: new Scaffold(
        body: new Container(
          margin: new EdgeInsets.only(top: 50.0),
          child: new Column(
            children: <Widget>[
              lblListrik,
              nomer,
            ],
          ),
        ),
      ),
    );
  }
}

class PaketData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final lblPaketData = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
      child: new SizedBox(
        child: new Container(
            child: new Text("Isi Paket Data",
                style: new TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20.0,
                  color: Colors.blue,
                ))),
      ),
    );

    final nomer = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        child: new Container(
          child: new TextFormField(
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                icon: const Icon(Icons.contact_phone),
                hintText: 'Nomor Handphone',
              )),
        ),
      ),
    );



    return new MaterialApp(
      title: "",
      home: new Scaffold(
        body: new Container(
          margin: new EdgeInsets.only(top: 50.0),
          child: new Column(
            children: <Widget>[
              lblPaketData,
              nomer,
            ],
          ),
        ),
      ),
    );
  }
}







//Halaman-------------------------------------------------------------------------------------------------------------------
