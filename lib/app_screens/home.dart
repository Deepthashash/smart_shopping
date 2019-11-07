import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_shopping/operations/injection.dart';
import 'package:smart_shopping/operations/calculations.dart';
import 'package:carousel_slider/carousel_slider.dart';



class Home extends StatefulWidget {
 Home({this.auth, this.onSignedOut});

 final BaseAuth auth;
 final VoidCallback onSignedOut;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 Calculations cal = new Calculations();

 int quantity;

 int finalPrice;

 int unitPrice;

 String q;

 int result = 0;

 Future _signOut() async {
   try {
     await widget.auth.signOut();
     widget.onSignedOut();
   } catch (e) {
     print(e);
   }
 }

  setValue(String brand,int price){
       
   Injections.cart.add(brand);
   Injections.priceList.add(price);
   Injections.quantityList.add(int.parse(q));
   finalPrice = price * int.parse(q);
   Calculations.finalPrice.add(finalPrice);
 }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 3),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }

  final List<String> imgList = [
    'assets/images/image1.jpg',
    'assets/images/image4.jpg',
    'assets/images/image3.jpg',
    'assets/images/dis1.jpeg',
    'assets/images/image2.jpg',
 ];

  Widget _buidList(BuildContext context, DocumentSnapshot document){    
    String brand = document["brand"];
    int price = document["price"];
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: myBoxDecoration(),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: ListTile(
                    title: Text(document['brand'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    subtitle: Text("Rs. "+document['price'].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 125.0,right: 5.0),
                    decoration: myBoxDecoration(),
                    alignment: Alignment.centerRight,
                    child: IconButton( 
                      icon: Icon(Icons.add),
                      onPressed: () =>_showDialog(context, brand, price),
                      )
                      ),
                      )
                
              ],
            ),
          ),
        ],
      ),
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
              child: Text('SmartMart',
              style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,)),
              decoration: BoxDecoration(
              color: Colors.blue,
              )
              ),              
              ListTile(
                  title: Text("Your Profile",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.account_box,size: 50.0),
                  onTap: () {
                    Navigator.of(context).pushNamed('/profile');
                  }),
              ListTile(
                  title: Text("Settings",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.settings,size: 50.0,),
                  onTap: () {
                    Navigator.of(context).pushNamed('/settings');
                  }),
              ListTile(
                title: Text("Rate us",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.star_border,size: 50.0,),
                onTap: () {
                  Navigator.of(context).pushNamed('/rating');
                }),
              RaisedButton(
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white)),
                    elevation: 1.0,
                    child: Text(
                      "SignOut",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
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
                pinned: true,
                
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: EdgeInsets.only(bottom: 80.0),
                    title: Text(
                      "SmartMart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // background: Image.asset("assets/images/image2.jpg")
                    ),
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
                crossAxisSpacing: 1.0,
                crossAxisCount: 1,
                children: <Widget>[
                  CarouselSlider(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    pauseAutoPlayOnTouch: const Duration(seconds: 2),
                    autoPlayInterval: const Duration(seconds: 5),
                    height: 300.0,
                    items: [0,1,2,3,4].map((i) {
                      return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                image: DecorationImage(image: AssetImage(imgList[i]),fit: BoxFit.cover)
                                // color: Colors.amber
                              ),
                              // child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                            );
                          },
                        );
                      }).toList(),
                    )
                  
                ],
              ),
              GridView.count(
                crossAxisCount: 1,
                children: <Widget>[
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
                  ),
                ],
              )
          
            ],
          ),
        ),
      ),
    );
  }
}

