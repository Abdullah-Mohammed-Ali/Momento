import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestorHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addDocToCollection(
      {required String collectionPath,
      required String docPath,
      required Map<String, dynamic> data}) async {
    await _firestore.collection(collectionPath).doc(docPath).set(data);
  }

  Future updateDocInCollection({
    required String collectionPath,
    required String docPath,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collectionPath).doc(docPath).update(data);
  }

  Future<DocumentSnapshot> getDocFromCollection({
    required String collectionPath,
    required String docPath,
  }) async {
    return await _firestore.collection(collectionPath).doc(docPath).get();
  }
}
