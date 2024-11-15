import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:zenn_app/models/article.dart';
import 'package:zenn_app/models/user.dart';

class StorageHelper {
  /* SharedPreferencesへお気に入りデータを保存する */
  static Future<void> saveFavorites(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteArticles = prefs.getStringList('favorites') ?? [];

    // 既存リストに対象の記事がない場合のみ追加
    if (!favoriteArticles.any((favorite) => jsonDecode(favorite)['id'] == article.id)) {
      favoriteArticles.add(jsonEncode(article.toJson()));
      await prefs.setStringList('favorites', favoriteArticles);
    }
  }

  /* SharedPreferencesからお気に入りデータ削除 */
  static Future<void> removeFavorite(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteArticles = prefs.getStringList('favorites') ?? [];

    favoriteArticles.removeWhere((favorite) => jsonDecode(favorite)['id'] == article.id);
    await prefs.setStringList('favorites', favoriteArticles);
  }


  /* SharedPreferencesからお気に入りデータを取得する */
  static Future<List<Article>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteArticles = prefs.getStringList('favorites') ?? [];

    return favoriteArticles
        .map((article) {
          final json = jsonDecode(article);
          return Article(
            id: json['id'],
            publishedAt: DateTime.parse(json['publishedAt']),
            title: json['title'],
            user: User.fromJson(json['user'], true),
            url: json['url'],
            isFavorite: json['isFavorite'],
          );
        }).toList();
  }
}