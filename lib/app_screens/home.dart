import 'package:flutter/material.dart';
import 'auth.dart';

class Home extends StatelessWidget {
  Home({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2),
      
    );
  }

  Future _signOut() async {
    try {
      onSignedOut();
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text("Welcome to Keells"),
          actions: <Widget>[
            RaisedButton(
              color: Colors.greenAccent,
              shape:
                  RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
              elevation: 1.0,
              child: Text(
                "SignOut",
              ),
              textColor: Colors.white,
              onPressed: _signOut,
            ),
          ],
        ),
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
        body: Material(
            child: Column(children: <Widget>[
          Expanded(
            child: Container(
              decoration: myBoxDecoration(),
              // child: Text("stocks"),
              child: GridView.count(
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
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: myBoxDecoration(),
              // child: Text("stocks"),
              child: CustomScrollView(
  primary: false,
  slivers: <Widget>[
    SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverGrid.count(
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        children: <Widget>[
          const Text('He\'d have you all unravel at the'),
          const Text('Heed not the rabble'),
          const Text('Sound of screams but the'),
          const Text('Who scream'),
          const Text('Revolution is coming...'),
          const Text('Revolution, they...'),
        ],
      ),
    ),
  ],
)
            ))])),
        drawer: Drawer(
          elevation: 1.0,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Keells"),
              ),
              ListTile(
                  title: Text("Your Profile"),
                  trailing: Icon(Icons.account_box),
                  onTap: () {
                    Navigator.of(context).pushNamed('/profile');
                  }),
              ListTile(
                  title: Text("Promotions"),
                  trailing: Icon(Icons.shopping_cart),
                  onTap: () {
//                    Navigator.of(context).pop();
                  }),
              ListTile(
                  title: Text("Settings"),
                  trailing: Icon(Icons.settings),
                  onTap: () {
                    Navigator.of(context).pushNamed('/settings');
                  }),
            ],
          ),
        ));
  }
}
