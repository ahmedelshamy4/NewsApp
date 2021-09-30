import 'package:flutter/material.dart';
import 'package:flutter_new_app/helper/news.dart';
import 'package:flutter_new_app/helper/widgets.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  CategoryNews({required this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newsList;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getCategoryNews(widget.newsCategory);
    newsList = news.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.share,
                )),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlogTile(
                      imageUrl: newsList[index].urlToImage ?? "",
                      desc: newsList[index].description ?? "",
                      title: newsList[index].title ?? "",
                      content: newsList[index].content ?? "",
                      posturl: newsList[index].articleUrl ?? "",
                    );
                  },
                ),
              ),
            ),
    );
  }
}
