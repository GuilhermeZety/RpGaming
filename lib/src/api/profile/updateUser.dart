import 'package:rpgaming/src/Util/NetworkInfo.dart';
import 'package:rpgaming/src/models/UserInfo.dart';

import '../../Util/constants.dart';

updateUserInfo(UserInfo user) async {
  if(await hasInternetConnection()){    
    return await supabase.from('user').upsert(user.toMap()).execute();
  }
}