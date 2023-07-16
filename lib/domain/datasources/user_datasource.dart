import 'package:app_maps_2/domain/entities/user_entity.dart';

abstract class UserDatasource {
  Future<User> getInfoUser(String uid);
  Future<bool> updatePassword(String uid, String newPassword);
  Future<bool> editInfo(String uid, Map<String, dynamic> newData);
}
