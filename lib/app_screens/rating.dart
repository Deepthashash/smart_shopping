import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  var _ratingController = TextEditingController();
  double _rating;
  double _userRating = 3.0;
  int _ratingBarMode = 2;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData _selectedIcon;

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.blue[300],
      border: Border.all(width: 3),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.blue,
        title: Text("Rate us"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: Center(child: Text("How is our service?",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),))),
          ),
          Expanded(
            child: Center(
              child: Container(
                // decoration: myBoxDecoration(),
                // color: Colors.blue,
                child:RatingBar(
                  initialRating: 3,
                  direction: _isVertical ? Axis.vertical : Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
            ),
          ),
          Expanded(
            child: Container(
              child: TextFormField(
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
                    ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                height: 50,
                width: 150,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.blue,
                    child: Text("Submit",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                   onPressed: (){},
                )
                )
              ),
          ),
        ],
      ) 
      
    );
  }
}