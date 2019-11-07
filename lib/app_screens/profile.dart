import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'services.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DocumentSnapshot snpshot;
  Services ser = Services();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Profile"),
      ),
      body: _profData(),
    );
  }

    BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      image: DecorationImage(image: AssetImage("assets/images/save1.jpeg"),fit: BoxFit.cover),
      border: Border.all(width: 3),
      borderRadius: const BorderRadius.all(Radius.circular(108)),
    );
  }

  @override
  void initState() {
    super.initState();
    ser.getData().then((results) {
      print(results);
      setState(() {
        snpshot = results;
      });
    });
  }

  Widget _profData() {
    if (snpshot != null) {
      return ListView(
        children: <Widget>[
          Container(margin: EdgeInsets.all(75.0),
            decoration: myBoxDecoration(),
            width: 100.0,
            height: 200.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                title: Text("Profile name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                subtitle: Text(snpshot.data["profname"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.edit,size: 40.0,),
                  onPressed: () {
                    print("filled background");
                  },
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                title: Text("NIC number",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                subtitle: Text(snpshot.data["NIC"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.lock_outline,size: 40.0,), onPressed: () {},
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                title: Text("Card number",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                subtitle: Text(snpshot.data["Nexus"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.lock_outline,size: 40.0,), onPressed: () {},
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                title: Text("Wallet Balance",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                subtitle: Text(snpshot.data["Wallet_balance"].toString()),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.lock_outline,size: 40.0,), onPressed: () {},
                ),
              )),
            ],
          )
        ],
      );
    } else {
      return (Center(child: CircularProgressIndicator()));
    }
  }
}