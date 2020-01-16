import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping/operations/injection.dart';
import 'package:smart_shopping/operations/calculations.dart';
import 'package:smart_shopping/app_screens/home.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'services.dart';

class CartItems extends StatefulWidget {

  
  @override
  State<StatefulWidget> createState() => _CartItems();
}


class _CartItems extends State<CartItems> {

  List<String> cartGet = [];
  List<int> priceGet = [];
  List<int> quantityGet = [];
  int price = 0;
  int total = 0;
  Calculations cal = new Calculations();
  Home val = new Home();

  DocumentSnapshot snpshot;
  Services ser = Services();
  

  BoxDecoration ratingBoxDecoration() {
    return BoxDecoration(
      color: Colors.blue[300],
      border: Border.all(width: 3),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }

    @override
    void initState() {
    setState(() {
      cartGet = Injections.cart;
      priceGet = Injections.priceList;
      quantityGet = Injections.quantityList;
       ser.getData().then((results) {
      print(results);
      setState(() {
        snpshot = results;
      });
    });
    });
    }

    void delete(index){
      setState(() {
        cartGet.removeAt(index);
        priceGet.removeAt(index);
        quantityGet.removeAt(index);
      });
    }

    void clear(){
      setState(() {
        cartGet.clear();
        priceGet.clear();
        quantityGet.clear();
        Calculations.finalPrice.clear();
        Calculations.temp1 = 2;
      });
    }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Cart"),
      ),
      body: ListView.builder(
                      itemExtent: 80.0,
                      itemCount: Injections.cart.length,
                      itemBuilder: (context, index) =>
                        _buidList(context, cartGet, priceGet, quantityGet, index),
                    ),
      bottomSheet: Container(
        height: 100,
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text("Total",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        )
                      ),
                  Expanded(child: TextFormField(
                    readOnly: true,
                    initialValue: cal.genarateTotal().toString(),
                    decoration: const InputDecoration(
                    border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                  ))),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right:50.0,left:50.0),
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text("Pay",style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: ()=>_showDialog()),
                    )
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right:50.0,left:50.0),
                      child: RaisedButton(
                        color: Colors.red,
                        child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          clear();
                        },),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),            
    );
  }

   void _showDialog() {
    String comment = "";
    var _ratingController = TextEditingController();
    double _userRating = 3.0;
    double _rating = 3.0;
    int _ratingBarMode = 2;
    bool _isRTLMode = false;
    bool _isVertical = false;
    IconData _selectedIcon;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title:  Text("How is our service?",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          content: Container(
              height: 220,
              width: 350,
            child: Column(
        children: <Widget>[
            // Expanded(
            //   child: Container(  
            //     padding: EdgeInsets.only(top: 10),
            //     child: Center(child: Text("How is our service?",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),))),
            // ),
             SizedBox(height:40),
             Container(

                  // decoration: ratingBoxDecoration(),
                  // color: Colors.blue,
                  child:RatingBar(
                    initialRating: 3,
                    direction: _isVertical ? Axis.vertical : Axis.horizontal,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        case 1:
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        case 2:
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        case 3:
                          return Icon(
                           Icons.star,
                            color: Colors.amber,
                          );
                        case 4:
                          return Icon(
                           Icons.star,
                            color: Colors.amber,
                          );
                        default:
                          return Container();
                      }
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                        print(rating);
                      });
                    },
                  )
                ),                
                 SizedBox(height:10),
                 Container(
                child: TextField(
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          // icon: Icon(Icons.security),
                          hintText: 'Any Comments?',
                          labelText: 'Review our service',
                          hasFloatingPlaceholder: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 4,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 4,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                              width: 4,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueGrey,
                              width: 4,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                        onChanged: (value) => comment = value, 
                        // onFieldSubmitted: (val) => _comment = val,
                      ),
              ),
             SizedBox(height:10),
              Center(
                child: Container(
                  height: 50,
                  width: 150,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.blue,
                      child: Text("Submit",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                     onPressed: (){
                        print(_rating);
                        print(comment);
                        // (_rating).toInt();
                        ser.addRatings(comment,_rating);
                        Navigator.of(context).pop();
                     },
                  )
                  )
                ),
        ],
      ),
          ) ,
          // actions: <Widget>[
          //   // usually buttons at the bottom of the dialog
          //    FlatButton(
          //     child:  Text("Close"),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          //    FlatButton(
          //     child: Text("Add"),
          //     onPressed: () {
          //       // print(brand);
          //       // setValue(brand, price);
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 3),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }


Widget _buidList(BuildContext context, List cart, List priceE, List quant, index){    
    return ListView(
      children: <Widget>[
        Container(
          decoration: myBoxDecoration(),
          child: ListTile(
            leading: Text(quant[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            title: Text(cart[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            subtitle: Text(priceE[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            trailing: IconButton(
              icon: Icon(Icons.delete,size: 25.0,),
              onPressed: (){
                Calculations.reducePrice = priceE[index] * quant[index];
                Calculations.temp1 = 1;
                delete(index);
              }
              
            ),
          ),
        )
      ],
    );
}
      

}
