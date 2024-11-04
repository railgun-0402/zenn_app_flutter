import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zenn_app/models/article.dart';
import 'package:http/http.dart' as http;
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
    final articles = await searchArticles(); // ユーザー名を指定
    setState(() {
      latestArticles = articles;
      isLoading = false; // 読み込み完了後にフラグを更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Zenn'),
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

  /* 記事取得APIの実行メソッド */
  Future<List<Article>> searchArticles() async {
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
