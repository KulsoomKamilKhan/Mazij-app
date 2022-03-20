class Library {
  int id;
  String post;
  String user;
  String caption;
  int upvotes;
  String created_on;
  String account_type;
  String collaborators;

  Library(
      {required this.id,
      required this.post,
      required this.user,
      required this.caption,
      required this.upvotes,
      required this.created_on,
      required this.account_type, required this.collaborators});

  factory Library.fromJson(Map<String, dynamic> json) => Library(
      id: json["id"],
      post: json["post"],
      user: json["user"],
      caption: json["caption"],
      upvotes: json["upvotes"],
      created_on: json["created_on"],
      account_type: json["account_type"],
      collaborators: json["collaborators"]
      );

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "post": this.post,
        "user": this.user,
        "caption": this.caption,
        "upvotes": this.upvotes,
        "created_on": this.created_on,
        "collaborators": this.collaborators
      };
}
