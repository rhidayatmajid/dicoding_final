class Profile {
  final String username;
  final String avatarUrl;
  final String name;
  final String bio;
  final int publicRepos;
  final int followers;
  final int following;
  final String htmlUrl;

  Profile({
    required this.username,
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.htmlUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      htmlUrl: json['html_url'] ?? '',
    );
  }
}
