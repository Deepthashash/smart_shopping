import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Services{

  FirebaseUser user;
    createData(_name,_nic, _nexus, userId,_email) {
    DocumentReference docref = Firestore.instance.document("Users/$_email");
    Map<String, dynamic> details = {
      "profname": _name,
      "userId": userId,
      "NIC": _nic,
      "Nexus": _nexus
    };
    docref.setData(details).whenComplete(() {
      print("done");
    });
  }

  getData() async{
    
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    // return user.email;
    return await Firestore.instance.collection("Users").document(user.email).get();
  }

  addRatings(String comment,double _rating) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    CollectionReference colref = Firestore.instance.collection("Rating");
    Map<String, dynamic> details = {
      "userEmail": user.email,
      "rating": _rating,
      "comment": comment,
    };
    colref.add(details).whenComplete(() {
      print("done");
    });

  }

  
}