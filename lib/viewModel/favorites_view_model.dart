import 'package:flutter/material.dart';
import 'package:zenn_app/helper/storage_helper.dart';
import 'package:zenn_app/models/article.dart';

/* Viewに表示するお気に入り記事の変更 */
class FavoritesViewModel extends ChangeNotifier {
  List<Article> _favorites = [];

  List<Article> get favorites => _favorites;

  Future<void> loadFavorites() async {
    // SharedPreferencesからお気に入りを取得
    final favorites = await StorageHelper.getFavorites();
    _favorites = favorites;
    notifyListeners();
  }
}
