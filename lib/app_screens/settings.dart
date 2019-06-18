import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class Settings extends StatelessWidget {
//  Home({this.auth, this.onSignedOut});
//
//  final BaseAuth auth;
//  final VoidCallback onSignedOut;
//
//  Future _signOut() async {
//    try {
//      await auth.signOut();
//      onSignedOut();
//    } catch (e) {
//      print(e);
//    }
//  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     appBar: AppBar(
      //   backgroundColor: Colors.greenAccent,
      //   title: Text("Settings"),
      // )
      floatingActionButton: FloatingActionButton(
//          mini: true,
        elevation: 12.0,
        onPressed: () {
          Navigator.of(context).pushNamed('/billing');
        },
        child: Icon(Icons.shopping_cart),
        foregroundColor: Colors.white,
        backgroundColor: Colors.greenAccent,
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: EdgeInsets.only(bottom: 80.0),
                    title: Text(
                      "Smart Shopping",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
                bottom: TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                   Tab(
                      //icon:  Icon(Icons.info),
                      text: "Discounts",
                    ),
                    Tab(
                      //icon:  Icon(Icons.info),
                     text: "Promotions"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),

              GridView.count(
                primary: false,
                padding: const EdgeInsets.all(5.0),
                crossAxisSpacing: 5.0,
                crossAxisCount: 3,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: myBoxDecoration(),
                    child: Text("Hello"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
