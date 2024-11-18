import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenn_app/viewModel/favorites_view_model.dart';
import 'package:zenn_app/widgets/article_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteArticles extends StatelessWidget {
  const FavoriteArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // ViewModelのインスタンス化
      create: (_) => FavoritesViewModel()..loadFavorites(),
      // UIに注入
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.favorite),
          backgroundColor: Colors.blue,
        ),
        // FavoritesViewModelのデータをConsumerで監視
        body: Consumer<FavoritesViewModel>(
            builder: (context, viewModel, child) {
              final favoriteInfos = viewModel.favorites;

              /// 記事がない場合は、記事なし画面を出す
              if (favoriteInfos.isEmpty) {
                return noFavoriteArticle(context);
              }

              return ListView.builder(
                itemCount: favoriteInfos.length,
                itemBuilder: (context, index) {
                  final article = favoriteInfos[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: ArticleContainer(article: article),
                  );
                },
              );
            },
        ),
      ),
    );
  }

  /* お気に入り記事がない場合に表示するWidget */
  Widget noFavoriteArticle(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.notFoundFavoriteArticles,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.screenBack),
          ),
        ],
      ),
    );
  }
}
