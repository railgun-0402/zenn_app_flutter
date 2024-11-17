import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zenn_app/viewModel/favorites_view_model.dart';
import 'package:zenn_app/widgets/article_screen.dart';

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
          title: const Text('お気に入り'),
          backgroundColor: Colors.blue,
        ),
        // FavoritesViewModelのデータをConsumerで監視
        body: Consumer<FavoritesViewModel>(
            builder: (context, viewModel, child) {
              final favoriteInfos = viewModel.favorites;

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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => ArticleScreen(article: article)),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFF55C500),
                          borderRadius: BorderRadius.all(
                            Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 公開日
                            Text(
                              DateFormat('yyyy/MM/dd').format(article.publishedAt),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),

                            // タイトル
                            Text(
                              article.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            // いいね数
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      article.likesCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),

                                IconButton(
                                  icon: Icon(
                                    article.isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: article.isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () => {

                                  },
                                ),

                                // 投稿者アイコンとユーザ名
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundImage: NetworkImage(article.user.avatarSmallUrl),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      article.user.id,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
        )


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
          const Text(
            'お気に入り記事がありません',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('前の画面に戻る'),
          ),
        ],
      ),
    );
  }
}
