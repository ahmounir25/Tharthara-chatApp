import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/models/myUser.dart';

class DataBaseUtils {
 static CollectionReference<myUser> getUsersCollection() {
   return FirebaseFirestore.instance
        .collection(myUser.collectionName)
        .withConverter<myUser>(
          fromFirestore: (snapshot, options) {
            return myUser.fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addToFireStore(myUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }
  static Future<myUser?> readUserFromFirestore(String id) async{
    DocumentSnapshot<myUser> userRef=await getUsersCollection().doc(id).get();
    return userRef.data();

  }

}
