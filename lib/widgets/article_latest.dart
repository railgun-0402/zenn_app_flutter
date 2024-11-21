import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zenn_app/helper/storage_helper.dart';
import 'package:zenn_app/models/article.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zenn_app/repository/http_api_articles.dart';
import 'package:zenn_app/widgets/article_container.dart';

class ArticleLatest extends StatefulWidget {
  const ArticleLatest({super.key});

  @override
  State<ArticleLatest> createState() => _ArticleLatestState();
}

class _ArticleLatestState extends State<ArticleLatest> {
  // 検索結果を保持する
  List<Article> latestArticles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  // 記事を取得して状態を更新する非同期メソッド
  Future<void> fetchArticles() async {
    final articles = await HttpApiArticles.searchArticles(false, ''); // ユーザー名を指定

    // お気に入りデータ
    // final prefs = await SharedPreferences.getInstance();
    final favoriteArticles = await StorageHelper.getFavorites();

    setState(() {
      latestArticles = articles.map((article) {
        final isFavorite = StorageHelper.isArticleFavorite(
            favoriteArticles.map((a) => jsonEncode(a.toJson())).toList(),
            article.id,
        );

        return Article(
          id: article.id,
          publishedAt: article.publishedAt,
          title: article.title,
          user: article.user,
          likesCount: article.likesCount,
          url: article.url,
          isFavorite: isFavorite,
        );
      }).toList();
      isLoading = false; // 読み込み完了後にフラグを更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.latestArticles),
          backgroundColor: Colors.blue,
        ),
        body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
          children:
            latestArticles.map((article) => ArticleContainer(article: article))
            .toList(),
        ),
      ),
    );
  }
}
