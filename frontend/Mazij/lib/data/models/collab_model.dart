class Collab {
  int id;
  String user;
  String draft;

  Collab({required this.id, required this.user, required this.draft});

  factory Collab.fromJson(Map<String, dynamic> json) => Collab(
      id: json["id"], user: json["user"], draft: json["draft"]);

  Map<String, dynamic> toJson() =>
      {"id": this.id, "user": this.user, "draft": this.draft};
}
