import 'package:zenn_app/models/user.dart';

class Article {
  Article({
    /* 記事のユニークID */
    required this.id,
    /* 公開日 */
    required this.publishedAt,
    /* タイトル */
    required this.title,
    /* ユーザーデータ */
    required this.user,
    /* いいね数 */
    this.likesCount = 0,
    /* 記事のURL */
    required this.url,
    /* お気に入り */
    this.isFavorite = false,
  });

  // プロパティ
  final int id;
  final DateTime publishedAt;
  final String title;
  final User user;
  final int likesCount;
  final String url;
  bool isFavorite = false;

  // JSONに変換
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'user': user.toJson(),
    'url': url,
    'publishedAt': publishedAt.toIso8601String(), // DateTimeをISO 8601形式に変換
    'isFavorite': isFavorite,
  };

  // JSONからArticleを生成するファクトリコンストラクタ
  factory Article.fromJson(dynamic json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] as String,
      user: User.fromJson(json['user'], false), // User.fromJson()を使ってUserを生成
      url: json['path'] as String,
      publishedAt: DateTime.parse(json['published_at'] as String), // DateTime.parse()を使って文字列をDateTimeに変換
      likesCount: json['liked_count'] as int,
    );
  }
}
