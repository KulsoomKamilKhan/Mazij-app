class Statistics {
  int users;
  int posts;
  int total_upvotes;
  int max_upvotes;

  Statistics({
    required this.users,
    required this.posts,
    required this.total_upvotes,
    required this.max_upvotes,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        users: json["users"],
        posts: json["posts"],
        total_upvotes: json["total upvotes"],
        max_upvotes: json["max upvotes"],
      );

  Map<String, dynamic> toJson() => {
        "users": this.users,
        "posts": this.posts,
        "total_upvotes": this.total_upvotes,
        "max_upvotes": this.max_upvotes,
      };
}
