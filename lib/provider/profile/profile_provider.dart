import 'package:flutter/material.dart';

import '../../data/model/respone/user_profile.dart';

class ProfileProvider with ChangeNotifier {
  UserProfile _userProfile = UserProfile.empty();

  UserProfile get userProfile => _userProfile;

  void setUserProfile(UserProfile userProfile) {
    _userProfile = userProfile;
    notifyListeners();
  }
}
