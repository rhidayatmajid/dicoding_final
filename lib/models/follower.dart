class Follower {
  final String username;
  final String avatarUrl;

  Follower({
    required this.username,
    required this.avatarUrl,
  });

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      username: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
    );
  }
}
