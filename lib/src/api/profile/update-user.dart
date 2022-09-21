import '../../Util/constants.dart';
import '../../models/user-info.dart';

updateUserInfo(UserInfo user) async {
  return await supabase.from('user').upsert(user.toMap()).execute();
}