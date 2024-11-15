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

  // JSONに変換
  Map<String, dynamic> toJson() => {
    'id': id,
    'avatarSmallUrl': avatarSmallUrl,
  };

  // JSONからUserを生成するファクトリコンストラクタ
  factory User.fromJson(Map<String, dynamic> json, isStorage) {
    String key = '';
    isStorage
    ? key = 'avatarSmallUrl'
    : key = 'avatar_small_url';

    return User(
      id: json['id'].toString(),
      avatarSmallUrl: json[key] as String,
    );
  }
}