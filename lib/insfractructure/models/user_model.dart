class UserModel {
  final String names;
  final String lastNames;
  final String email;

  UserModel({
    required this.names,
    required this.lastNames,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        names: json['names'],
        lastNames: json['last_names'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'names': names,
        'last_names': lastNames,
        'email': email,
      };
}
