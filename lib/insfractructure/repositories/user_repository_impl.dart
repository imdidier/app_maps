import 'package:app_maps_2/domain/entities/user_entity.dart';
import 'package:app_maps_2/domain/repositories/user_repository.dart';
import 'package:app_maps_2/insfractructure/datasources/user_datasource_impl.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasourceImpl datasourceImpl;
  UserRepositoryImpl(this.datasourceImpl);
  @override
  Future<bool> editInfo(String uid, Map<String, dynamic> updateData) {
    return datasourceImpl.editInfo(uid, updateData);
  }

  @override
  Future<User> getInfoUser(String uid) {
    return datasourceImpl.getInfoUser(uid);
  }

  @override
  Future<bool> updatePassword(String uid, String newPassword) {
    return datasourceImpl.updatePassword(uid, newPassword);
  }

  @override
  Future<bool> createUser(Map<String, dynamic> data) {
    return datasourceImpl.createUser(data);
  }
}
