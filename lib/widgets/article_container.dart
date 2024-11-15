import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zenn_app/helper/StorageHelper.dart';
import 'package:zenn_app/models/article.dart';
import 'package:zenn_app/widgets/article_screen.dart';

class ArticleContainer extends StatefulWidget {
  const ArticleContainer({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  State<ArticleContainer> createState() => _ArticleContainerState();
}

class _ArticleContainerState extends State<ArticleContainer> {
  void toggleFavorite(int id) {
    setState(() {
      if (id != -1) {
        // お気に入りした場合、falseが渡される
        widget.article.isFavorite
        ? StorageHelper.removeFavorite(widget.article)
        : StorageHelper.saveFavorites(widget.article);

        widget.article.isFavorite = !widget.article.isFavorite;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => ArticleScreen(article: widget.article)),
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
                  DateFormat('yyyy/MM/dd').format(widget.article.publishedAt),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),

              // タイトル
              Text(
                widget.article.title,
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
                        widget.article.likesCount.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  IconButton(
                    icon: Icon(
                      widget.article.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: widget.article.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => {
                      toggleFavorite(widget.article.id),
                    },
                  ),

                  // 投稿者アイコンとユーザ名
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(widget.article.user.avatarSmallUrl),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.article.user.id,
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
  }
}
