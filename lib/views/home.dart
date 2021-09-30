import 'package:flutter/material.dart';
import 'package:flutter_new_app/helper/data.dart';
import 'package:flutter_new_app/helper/news.dart';
import 'package:flutter_new_app/helper/widgets.dart';
import 'package:flutter_new_app/models/category_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _isLoading;
  List<CategorieModel> categories = [];
  var newsList;

  getNews() async {
    News newModel = News();
    await newModel.getNews();
    newsList = newModel.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _isLoading = true;
    super.initState();
    categories = getCategories();
    getNews();
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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      ///Categories
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              imageUrl: categories[index].imageAssetUrl,
                              categoryName: categories[index].categorieName,
                            );
                          },
                        ),
                      ),

                      ///Blogs
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: newsList.length,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: newsList[index].urlToImage ?? "",
                              title: newsList[index].title ?? "",
                              desc: newsList[index].description ?? "",
                              content: newsList[index].content ?? "",
                              posturl: newsList[index].articleUrl ?? "",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
