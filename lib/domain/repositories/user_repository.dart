import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<User> getInfoUser(String uid);
  Future<bool> updatePassword(String uid, String newPassword);
  Future<bool> editInfo(String uid, Map<String, dynamic> newData);
}
