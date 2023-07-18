import 'package:app_maps_2/insfractructure/datasources/user_datasource_impl.dart';
import 'package:app_maps_2/insfractructure/repositories/user_repository_impl.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  Future<bool> createUser({required Map<String, dynamic> newUser}) async {
    try {
      UserRepositoryImpl repository = UserRepositoryImpl(
        UserDatasourceImpl(),
      );
      bool resp = await repository.createUser(newUser);
      notifyListeners();
      return resp;
    } catch (e) {
      if (kDebugMode) {
        print('UserProvider, createUser, ERROR: $e');
      }
      throw Exception(e);
    }
  }
}
