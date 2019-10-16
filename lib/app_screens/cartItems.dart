import 'package:flutter/material.dart';
import 'package:smart_shopping/operations/injection.dart';

class CartItems extends StatefulWidget {

  
  @override
  State<StatefulWidget> createState() => _CartItems();
}


class _CartItems extends State<CartItems> {
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Cart"),
      ),
      body: ListView.builder(
                      itemExtent: 80.0,
                      itemCount: Injections.cart.length,
                      itemBuilder: (context, index) =>
                        _buidList(context, Injections.cart, index),
                    ),
    );
  }

}


Widget _buidList(BuildContext context, List cart, index){


    
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(cart[index]),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () =>  cart.removeAt(index)
            
          ),
        )
      ],
    );
}
      

