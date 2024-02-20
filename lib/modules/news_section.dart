import 'package:flutter/material.dart';
import 'package:news_app/shared/components/components.dart';

class NewsSection extends StatelessWidget {
  List<dynamic> articleList;
  NewsSection({super.key, required this.articleList});

  @override
  Widget build(BuildContext context) {
    return newsList(articleList);
  }
}
