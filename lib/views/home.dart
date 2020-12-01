import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:latestNews/helper/data.dart';
import 'package:latestNews/helper/news.dart';
// import 'package:latestNews/helper/widgets.dart';
import 'package:latestNews/models/article_model.dart';
import 'package:latestNews/models/category_model.dart';
import 'package:latestNews/views/article_view.dart';

import 'category_news.dart';
// import './category_news.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  
   

  @override
  void initState() {
    _loading = true;
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Row(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Latest"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
            child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[

              // Categories
              Container(
                  // padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 70,
                  child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          CategoryName: categories[index].categoryName,
                        );

                    }),   
                      ),


                    //  BLogs
                    Container(
                      padding: EdgeInsets.only(top:16) ,
                      child: ListView.builder(
                        itemCount: articles.length,
                        physics:ClampingScrollPhysics() ,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return BlogTile(imageUrl: articles[index].urlToImage, 
                          title: articles[index].title, 
                          desc: articles[index].description,
                          url: articles[index].url
                          );
                        }
                       ),
                    )


            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, CategoryName;

  CategoryTile({this.imageUrl, this.CategoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(
          category: CategoryName.toLowerCase())));
      },
      child: Container(
        // padding: EdgeInsets.symmetric(15),
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl:imageUrl,
                    width: 120, height: 60, fit: BoxFit.cover)),
            Container(
                alignment: Alignment.center,
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26,
                ),
                child: Text(CategoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ))),
                    
          ],
          // blogs
         
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc,url;

  BlogTile(
      {@required this.imageUrl, @required this.title, @required this.desc, @required this.url});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
          ArticleView(
            blogUrl: url,
          )
        ));
      },
          child: Container(
        margin: EdgeInsets.only(bottom:16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)
              ),
            SizedBox(height:8),
            Text(title, style: TextStyle(
              fontSize: 18 ,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),),
            SizedBox(height:8),
            Text(desc, style:TextStyle(
              color: Colors.black54
            ),),
          ],
        ),
      ),
    );
  }
}
