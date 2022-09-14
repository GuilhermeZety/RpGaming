import 'package:rpgaming/src/Cache.dart';
import 'package:rpgaming/src/models/UserInfo.dart';

Future<bool> updateAtUser(UserInfo newUser) async {
  return await Cache().setUserInfo(newUser.copyWith(
    updated_at: DateTime.now()
  ));
}