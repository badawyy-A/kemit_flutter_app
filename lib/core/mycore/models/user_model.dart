class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final String userName;
  final String? profileImg;
  final bool createReport;
  final String role;
  final String id;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userName,
    this.profileImg,
    required this.createReport,
    required this.role,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      userName: json['userName'] ?? '',
      profileImg: json['profileImg'] ?? '',
      createReport: json['createReport'] ?? false,
      role: json['role'] ?? '',
      id: json['_id'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'profileImg': profileImg,
      'createReport': createReport,
      'role': role,
      '_id': id,
    };
  }

  UserModel copyWith({
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    String? userName,
    String? profileImg,
    bool? createReport,
    String? role,
    String? id,
  }) {
    return UserModel(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      profileImg: profileImg ?? this.profileImg,
      createReport: createReport ?? this.createReport,
      role: role ?? this.role,
      id: id ?? this.id,
    );
  }
}
