import 'dart:convert';
import 'package:ctse_flutter_project/model/profile.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/login.dart';

class ProfileService {
  static String endpoint = '${dotenv.env['API_URL']}/profile';
  const ProfileService();

  Future<bool?> addProfile(Profile profile) async {
    final response = await post(Uri.parse(endpoint),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(profile));
    if (response.statusCode == 200) {
      return true;
    }
    throw Exception("Error in Getting the Profile post");
  }

  Future<Profile>? login(Login login) async {
    final response = await post(Uri.parse('$endpoint/login'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(login));
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);

      if (data['status'] == "User Doesn't exist") {
        Profile profile = const Profile(
            id: '',
            userName: '',
            email: '',
            isActive: false,
            title: '',
            password: '');
        return profile;
      } else {
        Profile profile = Profile(
            id: data['_id'],
            userName: data['userName'],
            email: data['email'],
            title: data['title'],
            isActive: data['isActive'],
            password: data['password']);

        return profile;
      }
    }

    throw Exception('Error in getting the Profile');
  }

  Future<bool?> updateProfile(Profile profile) async {
    final response = await put(Uri.parse(endpoint + '/' + profile.id),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(profile));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Error in updating the profile');
  }

  Future<bool?> deleteProfileByID(id) async {
    final response = await delete(Uri.parse(endpoint + '/' + id), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Error in delete profile');
  }
}
