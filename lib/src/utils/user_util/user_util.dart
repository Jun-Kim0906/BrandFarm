import 'package:friendlyeats/src/model/user_model/user_model.dart';

class UserUtil {
  static CredentialUser _user;
  static void setUser(CredentialUser user) async {
    _user = user;
  }

  static CredentialUser getUser() {
    return _user;
  }
}
