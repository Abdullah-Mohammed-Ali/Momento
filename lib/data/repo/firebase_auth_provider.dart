import 'package:firebase_auth/firebase_auth.dart';
import 'package:social/const/strings.dart';
import 'package:social/data/models/user.dart';
import 'package:social/data/provider/network/firestor.dart';

import '../../presentation/const.dart';
import '../provider/local/cashe_helper.dart';

class FirebaseAuthRepository {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirestorHelper _firestorHelper = FirestorHelper();

  static Users? userModel;

  static Future<Users?> login(
      {required Users user,
      Function? action,
      required Function onError,
      required}) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(
            email: user.email!, password: user.password!)
        .then((value) async {
      await CasheHelper.saveDate(key: uidKey, value: value.user!.uid);
      userModel = user;

      print('my uid : ' + CasheHelper.getData(key: uidKey));
      await _firestorHelper
          .getDocFromCollection(
        collectionPath: usersCollection,
        docPath: value.user!.uid,
      )
          .then((value) {
        Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
        userModel = Users.FromJSON(json: data!);
        value.data();
      });
    });
  }

  static Future<UserCredential?> register({
    required Users user,
    Function? then,
  }) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: user.email!, password: user.password!)
        .then((value) async {
      await CasheHelper.saveDate(key: uidKey, value: value.user!.uid);
      user.uId = value.user!.uid;
      await _firestorHelper.addDocToCollection(
          collectionPath: usersCollection,
          docPath: user.uId!,
          data: Users.toMap(user: user));

      userModel = user;
      print(Users.toMap(user: userModel!).toString());
      then!();
    }).catchError((error) => print(error.toString()));
  }

  static Future updateUser({
    required Users user,
  }) async {
    await _firestorHelper.updateDocInCollection(
        collectionPath: usersCollection,
        docPath: user.uId!,
        data: Users.toMap(user: user));
    await _firestorHelper
        .getDocFromCollection(
            collectionPath: usersCollection, docPath: user.uId!)
        .then((value) async {
      userModel = Users.FromJSON(json: value.data() as Map<String, dynamic>);
    });
  }
}
