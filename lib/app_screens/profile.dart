import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'services.dart';

class Profile extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DocumentSnapshot snpshot;
  Services ser =  Services();

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
    ser.getData().then((results){ 
      print(results); 
      setState(() {
        snpshot = results;
      });
    });
  }

  Widget _profData(){
    if(snpshot != null){
      return ListView(children: <Widget>[
        
       Text(snpshot.data["NIC"]),
       Text(snpshot.data["Nexus"])
      ],
        //Container()
      );
      // return ListView.builder(
      //   itemCount: snpshot.documents.length,
      //   padding: EdgeInsets.all(5.0),
      //   itemBuilder: (BuildContext context, int i){
      //     return ListTile(
      //       title: Text(snpshot.documents[i].data["NIC"].toString()),
      //     );
      //   },
      // );
    }else{
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
