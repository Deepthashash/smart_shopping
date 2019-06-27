import 'package:flutter/material.dart';
import 'auth.dart';

class Home extends StatelessWidget {
 Home({this.auth, this.onSignedOut});

 final BaseAuth auth;
 final VoidCallback onSignedOut;

 Future _signOut() async {
   try {
     await auth.signOut();
     onSignedOut();
   } catch (e) {
     print(e);
   }
 }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
               ListTile(
                  title: Text("SignOut"),
                  trailing: Icon(Icons.account_box),
                  onTap: () {
                    _signOut();
                  }),
              RaisedButton(
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white)),
                    elevation: 1.0,
                    child: Text(
                      "SignOut",
                    ),
                    textColor: Colors.white,
                    onPressed: _signOut,
                  ),
                ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
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
                    background: Image.asset("assets/images/image2.jpg")),
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
              GridView.count(
                primary: false,
                padding: const EdgeInsets.all(5.0),
                crossAxisSpacing: 5.0,
                crossAxisCount: 2,
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
              GridView.count(
                primary: false,
                padding: const EdgeInsets.all(5.0),
                crossAxisSpacing: 5.0,
                crossAxisCount: 2,
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
