import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenn_app/models/article.dart';

class HttpApiArticles {
  /* 記事取得APIの実行メソッド */
  static Future<List<Article>> searchArticles() async {
    final url = Uri.parse('https://zenn.dev/api/articles?order=latest');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> articles = jsonResponse['articles'];
      return articles.map((dynamic json) => Article.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}