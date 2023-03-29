import 'dart:convert';

import 'package:http/http.dart';

import '../model/article_model.dart';

class ApiService {
  final endPointUrl =
      "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=a57d358f6f814336850a3a2c31c823a7";

  Future<List<Article>> getArticle() async {
    //Response res = await get(endPointUrl);
    Uri uri = Uri.parse(endPointUrl);
    Response res = await get(uri);

    //first of all let's check that we got a 200 statu code: this mean that the request was a succes
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      //this line will allow us to get the different articles from the json file and putting them into a list
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
