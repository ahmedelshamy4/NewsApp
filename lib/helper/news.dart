import 'dart:convert';

import 'package:flutter_new_app/models/artical_model.dart';
import 'package:http/http.dart' as http;

import '../secert.dart';

class News {
  List<ArticalModel> news = [];
  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=eg&apiKey=$apiKey";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticalModel article = ArticalModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element['content'],
            articleUrl: element['url'],
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsForCategorie {
  List<ArticalModel> news = [];
  Future<void> getCategoryNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?category=$category&country=eg&apiKey=$apiKey";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach(
        (element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticalModel article = ArticalModel(
              title: element['title'],
              description: element['description'],
              author: element['author'],
              urlToImage: element['urlToImage'],
              publshedAt: DateTime.parse(element['publishedAt']),
              content: element['content'],
              articleUrl: element['url'],
            );
            news.add(article);
          }
        },
      );
    }
  }
}
