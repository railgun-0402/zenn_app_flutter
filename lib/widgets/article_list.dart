import 'package:flutter/material.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        decoration: const BoxDecoration(
            color: Color(0xFF55C500),
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            )
        ),
      ),
    );
  }
}
