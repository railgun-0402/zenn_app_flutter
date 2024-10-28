import 'package:zenn_app/models/user.dart';

class Article {
  Article({
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
  });

  // プロパティ
  final DateTime publishedAt;
  final String title;
  final User user;
  final int likesCount;
  final String url;

  // JSONからArticleを生成するファクトリコンストラクタ
  factory Article.fromJson(dynamic json) {
    return Article(
      title: json['title'] as String,
      user: User.fromJson(json['user']), // User.fromJson()を使ってUserを生成
      url: json['path'] as String,
      publishedAt: DateTime.parse(json['published_at'] as String), // DateTime.parse()を使って文字列をDateTimeに変換
      likesCount: json['liked_count'] as int,
    );
  }
}
