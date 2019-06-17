import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Services{

  FirebaseUser user;
    createData(_nic, _nexus, userId,_email) {
    DocumentReference docref = Firestore.instance.document("Users/$_email");
    Map<String, dynamic> details = {
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
}