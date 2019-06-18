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

//   @override
//   void initState(){
//     super.initState();
//    ser.getData().then((xxx){
//     emailg = xxx;
// });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Profile"),
      ),
      body: _profData(),
      //     ListView(
      //   children: <Widget>[
      //     Text(emailg),
      //     StreamBuilder(
      //       stream: Firestore.instance
      //           .collection("Data")
      //           .document(emailg)
      //           .snapshots(),
      //       builder: (BuildContext context,
      //           AsyncSnapshot<DocumentSnapshot> snapshot) {
      //         if (!snapshot.hasData)
      //           return new Container(
      //               child: Center(
      //             child: Text("Loading..."),
      //           ));

      //         return TaskList(documents: snapshot.data.documents);
      //       },
      //     )
      //   ],
      // )
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
          SizedBox( 
            height: 150.0,
            child: Container(
              decoration: BoxDecoration(
          image: DecorationImage(
            image:  ExactAssetImage('assets/dog.png'),
            fit: BoxFit.cover,
          ),
              ),
              alignment: Alignment.center,
              width: 50.0,
              height: 50.0,
              child: Text("Prof pic comes here"),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                title: Text("Profile name"),
                subtitle: Text(snpshot.data["profname"]),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.edit),
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
                title: Text("NIC number"),
                subtitle: Text(snpshot.data["NIC"]),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.lock_outline),
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                title: Text("Nexus card number"),
                subtitle: Text(snpshot.data["Nexus"]),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.lock_outline),
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
//  class TaskList extends StatelessWidget {
//   TaskList({this.documents});
//   final List<DocumentSnapshot> documents;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: documents.length,
//       itemBuilder: (BuildContext context, int i){
//         String title = documents[i].data['title'].toString();
//         return Text(title);
//       },
//     );
//   }
//}
