class Profile {
  String username;
  String bio;
  String account_type;
  String profile_pic;

  Profile({
    required this.username,
    required this.bio,
    required this.account_type,
    required this.profile_pic,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        username: json["username"],
        bio: json["bio"],
        account_type: json["account_type"],
        profile_pic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "username": this.username,
        "bio": this.bio,
        "account_type": this.account_type,
        "profile_pic": this.profile_pic,
      };
}
