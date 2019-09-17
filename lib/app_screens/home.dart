import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
      border: Border.all(width: 0),
    );
  }

  Widget _buidList(BuildContext context, DocumentSnapshot document){
    return ListTile(
      title: Text(document['brand']),
      subtitle: Text(document['price'].toString()),          
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          elevation: 1.0,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
              margin: EdgeInsets.only(bottom: 2.0),
              // padding: EdgeInsets.all(5.0),
              child: Text('Smart Shopping',
              style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,)),
              decoration: BoxDecoration(
              color: Colors.blue,
              )
              ),              
              ListTile(
                  title: Text("Your Profile"),
                  trailing: Icon(Icons.account_box),
                  onTap: () {
                    Navigator.of(context).pushNamed('/profile');
                  }),
              ListTile(
                  title: Text("Settings"),
                  trailing: Icon(Icons.settings),
                  onTap: () {
                    Navigator.of(context).pushNamed('/settings');
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
                        text: "Pre-order"),
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
                    child: Image.asset("assets/images/image2.jpg")
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
              StreamBuilder(
                stream: Firestore.instance.collection("Barcode_details").snapshots(),
                builder: (context, snapshots){
                  if(!snapshots.hasData) return const Text("Loading...");   
                  return ListView.builder(
                    itemExtent: 80.0,
                    itemCount: snapshots.data.documents.length,
                    itemBuilder: (context, index) =>
                      _buidList(context, snapshots.data.documents[index]),
                  );
                },
              )
          
            ],
          ),
        ),
      ),
    );
  }
}

