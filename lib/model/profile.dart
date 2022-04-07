class Profile {
  final String id;
  final String userName;
  final String email;
  final bool isActive;
  final String title;
  final String password;
  

  const Profile({
    required this.id,
    required this.userName,
    required this.email,
    required this.isActive,
    required this.title,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'title': title,
        'password': password,
        "isActive": isActive,
      };
}
