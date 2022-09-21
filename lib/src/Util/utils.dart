import '../Cache.dart';
import '../models/user-info.dart';

Future<bool> updateAtUser(UserInfo newUser) async {
  return await Cache().setUserInfo(newUser.copyWith(
    updated_at: DateTime.now()
  ));
}