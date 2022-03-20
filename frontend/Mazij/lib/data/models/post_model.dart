class Post {
  int id;
  String post;
  String user;
  String caption;
  int upvotes;
  String created_on;
  String collaborators;

  Post({
    required this.id,
    required this.post,
    required this.user,
    required this.caption,
    required this.upvotes,
    required this.created_on,
    required this.collaborators
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        post: json["post"],
        user: json["user"],
        caption: json["caption"],
        upvotes: json["upvotes"],
        created_on: json["created_on"],
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
