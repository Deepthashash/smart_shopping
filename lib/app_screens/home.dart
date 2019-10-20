import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_shopping/operations/injection.dart';
import 'package:smart_shopping/operations/calculations.dart';


class Home extends StatelessWidget {
 Home({this.auth, this.onSignedOut});

 Calculations cal = new Calculations();

 final BaseAuth auth;
 final VoidCallback onSignedOut;
 int quantity;
 int finalPrice;
 int unitPrice;
 String q;

 

// look forward to implement
//  calculatePrice(String q, int unitPrice){
//    quantity = int.parse(q);
//    finalPrice = finalPrice + (quantity * unitPrice);
//    print("finalPrice");
//  }

 Future _signOut() async {
   try {
     await auth.signOut();
     onSignedOut();
   } catch (e) {
     print(e);
   }
 }

 int setValue(String brand,int price){
       
   Injections.cart.add(brand);
   Injections.priceList.add(price);
   Injections.quantityList.add(int.parse(q));
   finalPrice = price * int.parse(q);
   Calculations.finalPrice.add(finalPrice);
 }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 0),
    );
  }

  Widget _buidList(BuildContext context, DocumentSnapshot document){
    String brand = document["brand"];
    int price = document["price"];
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: ListTile(
          title: Text(document['brand']),
          subtitle: Text("Rs. "+document['price'].toString()),          
          )),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: IconButton( 
              icon: Icon(Icons.add),
              onPressed: () =>_showDialog(context, brand, price),
              )
              ),
              )
        
      ],
    );
  }

    void _showDialog(context, brand, price) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title:  Text("Enter the quantity"),
          content:  TextField(            
            onChanged: (value) => q = value,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
             FlatButton(
              child:  Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             FlatButton(
              child: Text("Add"),
              onPressed: () {
                print(brand);
                setValue(brand, price);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
      floatingActionButton: SpeedDial(
        elevation: 12.0,
        child: Icon(Icons.menu),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
            child: Icon(Icons.shopping_cart),
            onTap: () => Navigator.of(context).pushNamed('/cart')
          ),
          SpeedDialChild(
            child: Icon(Icons.scanner),
            onTap: () => Navigator.of(context).pushNamed('/billing')
          )
        ],
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
                  if(!snapshots.hasData) return Center(child: CircularProgressIndicator());   
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

