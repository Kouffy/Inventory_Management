import 'package:inventory_management/Core/Controllers/Api.dart';
import 'package:inventory_management/Core/Models/Article.dart';
import 'dart:convert' as convert;
import 'Api.dart';
import 'package:http/http.dart' as http;

class ArticleController {
  static Future getArticle() async {
    return await http.get(Api.urlBase + Api.urlArticle);
  }

  static Future getArticleID(int id) async {
    return await http.get(Api.urlBase + Api.urlArticle + id.toString());
  }
   static Future getArticlesEmplacment(int id) async {
    return await http.get(Api.urlBase + Api.urlArticle + Api.urlGetArticlesEmplacment + id.toString());
  }
  

  static Future<bool> postArticle(Article article) async {
    var monArticle = article.toMap();
    var articleBody = convert.json.encode(monArticle);
    var res = await http.post(Api.urlBase + Api.urlArticle,
        headers: Api.header, body: articleBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> putArticle(Article article) async {
    var monArticle = article.toMap();
    var articleBody = convert.json.encode(monArticle);
    var res = await http.put(
        Api.urlBase + Api.urlArticle + article.id.toString(),
        headers: Api.header,
        body: articleBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> deleteArticle(int id) async {
    var res = await http.delete(Api.urlBase + Api.urlArticle + id.toString(),
        headers: Api.header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }
}
