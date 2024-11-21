import 'package:flutter/material.dart';
import 'package:zenn_app/models/article.dart';
import 'package:zenn_app/repository/http_api_articles.dart';
import 'package:zenn_app/widgets/article_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: Text(AppLocalizations.of(context)!.searchArticlesPage),
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
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchHintText
                  ),
                  onSubmitted: (String value) async {
                    /* 記事取得APIの実行 */
                    final results = await HttpApiArticles.searchArticles(true, value);
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
}
