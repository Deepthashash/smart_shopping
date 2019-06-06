
import 'package:cloud_firestore/cloud_firestore.dart';


class Services{
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
}