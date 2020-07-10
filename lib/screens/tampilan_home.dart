import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

import './tampilan_webview.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String kode = "";
  var getKode;
  Future scanBarcode() async {
    getKode = await BarcodeScanner.scan();
    setState(() {
      kode = getKode.rawContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplikasi Scan Barcode"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.indigo,
                    Colors.lightBlueAccent
                  ])
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        elevation: 10,
                        child: Padding(padding: EdgeInsets.all(8.0),
                        child: Image.asset('images/gambar1.png',width: 90,height: 90,),),
                      ),
                      Padding(padding: EdgeInsets.all(8.0),child: Text('QR CODE',style: TextStyle(color: Colors.white,fontSize: 13.0),),)
                    ],
                  ),
                )),
            CustomListTitle(Icons.person,'Profil',()=>{}),
            CustomListTitle(Icons.notifications,'Notifikasi',()=>{}),
            CustomListTitle(Icons.settings,'Setting',()=>{}),
            CustomListTitle(Icons.lock,'Log Out',()=>{}),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Image.network("https://www.pngitem.com/pimgs/m/115-1150464_mobile-phone-scan-qr-code-png-transparent-png.png"),
          SizedBox(
            height: 10.0,
          ),
          FlatButton(
            onPressed: () {
              scanBarcode();
            },
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Scan Barcode",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          FlatButton(
            onPressed: kode == ""
                ? () {}
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebScreen(kode),
                      ),
                    );
                  },
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: kode == ""
                      ? Text(
                          "Lihat Hasil",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        )
                      : Text(
                          kode,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomListTitle extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;

  CustomListTitle(this.icon,this.text,this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
        child: InkWell(
          splashColor: Colors.lightBlueAccent,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                    children: <Widget>[
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(text,style: TextStyle(
                          fontSize: 16.0
                        ),),
                      ),
                    ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}