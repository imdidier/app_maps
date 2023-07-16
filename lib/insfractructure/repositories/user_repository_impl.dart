import 'package:app_maps_2/domain/entities/user_entity.dart';
import 'package:app_maps_2/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<bool> editInfo(String uid, Map<String, dynamic> newData) {
    // TODO: implement editInfo
    throw UnimplementedError();
  }

  @override
  Future<User> getInfoUser(String uid) {
    // TODO: implement getInfoUser
    throw UnimplementedError();
  }

  @override
  Future<bool> updatePassword(String uid, String newPassword) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}
