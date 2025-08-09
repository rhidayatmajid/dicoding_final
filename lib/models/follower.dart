class Follower {
  final String login;
  final String avatarUrl;
  final String htmlUrl;

  Follower({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
    );
  }
}
