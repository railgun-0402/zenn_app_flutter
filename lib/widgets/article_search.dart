import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zenn_app/models/article.dart';
import 'package:zenn_app/widgets/article_container.dart';

class ArticleSearch extends StatefulWidget {
  const ArticleSearch({super.key});

  @override
  State<ArticleSearch> createState() => _ArticleSearchState();
}

class _ArticleSearchState extends State<ArticleSearch> {
  // 検索結果を保持する
  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Zenn'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
            children: [
              // 検索ボックス
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 36,
                ),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: '検索したい記事を入力しよう！'
                  ),
                  onSubmitted: (String value) async {
                    final results = await searchArticles(value);
                    setState(() =>
                      articles = results
                    );
                  },
                ),
              ),

              // 検索結果一覧
              Expanded(
                child: ListView(
                  children: articles
                      .map((article) => ArticleContainer(article: article))
                      .toList(),
                ),
              ),
            ],
          ),
      ),
    );
  }

  /* 記事取得APIの実行メソッド */
  Future<List<Article>> searchArticles(String keyword) async {
    final url = Uri.parse('https://zenn.dev/api/articles?username=$keyword&order=latest');
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
