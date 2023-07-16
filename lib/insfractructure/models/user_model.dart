class User {
  final String names;
  final String lastNames;
  final String email;

  User({
    required this.names,
    required this.lastNames,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
