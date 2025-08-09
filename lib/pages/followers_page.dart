class Follower {
  final String username;
  final String profileUrl;

  Follower({
    required this.username,
    required this.profileUrl,
  });

  // Data dummy
  static List<Follower> getDummyFollowers() {
    return [
      Follower(username: 'john_doe', profileUrl: 'https://example.com/john'),
      Follower(username: 'jane_doe', profileUrl: 'https://example.com/jane'),
      Follower(username: 'alex123', profileUrl: 'https://example.com/alex'),
    ];
  }
}
