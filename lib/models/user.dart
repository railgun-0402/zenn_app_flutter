class User {
  User({
    /* ユーザID */
    required this.id,
    /* ユーザプロフィールURL */
    required this.avatarSmallUrl,
  });

  // プロパティ
  final String id;
  final String avatarSmallUrl;

  // JSONからUserを生成するファクトリコンストラクタ
  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'] as String,
      avatarSmallUrl: json['avatar_small_url'] as String,
    );
  }
}