class Follow {
  int id;
  String followers;
  String follows;

  Follow({required this.id, required this.followers, required this.follows});

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
      id: json["id"], followers: json["followers"], follows: json["follows"]);

  Map<String, dynamic> toJson() =>
      {"id": this.id, "followers": this.followers, "follows": this.follows};
}
