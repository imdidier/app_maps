import 'package:app_maps_2/config/firebase/firebase_services.dart';
import 'package:app_maps_2/domain/datasources/user_datasource.dart';
import 'package:app_maps_2/domain/entities/user_entity.dart';
import 'package:app_maps_2/insfractructure/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserDatasourceImpl extends UserDatasource {
  @override
  Future<bool> editInfo(String uid, Map<String, dynamic> updateData) async {
    try {
      await FirebaseServices.db
          .collection('app_maps')
          .doc(uid)
          .update(updateData);
      return true;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('UserDatasourceImpl, editInfo, ERROR: $e');
      }
      throw Exception(e);
    }
  }

  @override
  Future<User> getInfoUser(String uid) async {
    try {
      User user;
      DocumentSnapshot querySnapshot =
          await FirebaseServices.db.collection('app_maps').doc(uid).get();
      user = UserModel.fromJson(querySnapshot.data() as Map<String, dynamic>)
          as User;
      return user;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('UserDatasourceImpl, getInfoUser, ERROR: $e');
      }
      throw Exception(e);
    }
  }

  @override
  Future<bool> updatePassword(String uid, String newPassword) {
    throw UnimplementedError();
  }

  @override
  Future<bool> createUser(Map<String, dynamic> data) async {
    try {
      await FirebaseServices.db.collection('app_maps').add(data);
      return true;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('UserDatasourceImpl, createUser, ERROR: $e');
      }
      throw Exception(e);
    }
  }
}
