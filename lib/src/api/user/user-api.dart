import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Util/Log/LogException/LoggerExceptionUtil.dart';
import '../../Util/constants.dart';

class UserApi {

  ///Update an existing user
  ///Pass a [jwt] and [userAttributes]
  ///Return [bool] ]
  ///[true = exist] and [false = not exist]
  Future<bool> updateUser(String jwt, UserAttributes userAttributes) async {
    try{      
      var response = await supabase.auth.api.updateUser(jwt, userAttributes);

      if(response.error == null){
        return true;
      }

    }catch(err, s){      
      LoggerExceptionUtil().writeException(err, s);
      if (kDebugMode) {
        print(err);
      }      
    }
    return false;
  }
}