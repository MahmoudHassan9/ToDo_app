class UserDM {
  static const String collectionName = 'users';

  String? email;
  String? uid;
  String? name;
  String? phoneNumber;


  UserDM({
    required this.email,
    required this.uid,
    required this.name,
    required this.phoneNumber,
  });

  UserDM.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
