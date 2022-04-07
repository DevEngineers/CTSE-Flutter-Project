import 'package:flutter/cupertino.dart';
import '../model/profile.dart';
import '../services/ProfileService.dart';

class ProfileProvider extends ChangeNotifier {
  late ProfileService _profileService;
  late Profile _profile;

  Profile get profile => _profile;

  ProfileProvider() {
    _profileService = const ProfileService();
    _profile = const Profile(
        id: '',
        userName: '',
        email: '',
        isActive: false,
        title: '',
        password: '');
  }

  void addProfile(Profile profile) {
    _profile = profile;
    notifyListeners();
  }
}
