class User {
  String first_name;
  String last_name;
  String username;
  String email;
  String passwords;
  String account_type;
  String date_of_birth;

  User({
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.account_type,
    required this.date_of_birth,
    required this.passwords,
  });

  // factory constructor initializes a final variable from a JSON object
  factory User.fromJson(Map<String, dynamic> json) => User( // for constructing a new User instance from a map structure
        username: json["username"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        email: json["email"],
        account_type: json["account_type"],
        date_of_birth: json["date_of_birth"],
        passwords: json["passwords"],
      );

  Map<String, dynamic> toJson() => {
        "username": this.username,
        "first_name": this.first_name,
        "last_name": this.last_name,
        "email": this.email,
        "account_type": this.account_type,
        "date_of_birth": this.date_of_birth,
        "passwords": this.passwords,
      };
}
