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

  void updateProfile(Profile profile) async {
    final response = await _profileService.updateProfile(profile);

    if (response == true) {
      _profile = profile;
    }
    notifyListeners();
  }

  void deleteProfile(String id) async {
    final response = await _profileService.deleteProfileByID(id);

    if (response == true) {
      _profile = const Profile(
          id: '',
          userName: '',
          email: '',
          isActive: false,
          title: '',
          password: '');
    }
    notifyListeners();
  }

  void logout() {
    _profile = const Profile(
        id: '',
        userName: '',
        email: '',
        isActive: false,
        title: '',
        password: '');

    notifyListeners();
  }
}
