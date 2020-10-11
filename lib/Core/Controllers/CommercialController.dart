import 'package:inventory_management/Core/Controllers/Api.dart';
import 'package:inventory_management/Core/Models/Commercial.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CommercialController {
  static Future getCommercial() async {
    return await http.get(Api.urlBase + Api.urlCommercial);
  }

  static Future getCommercialID(int id) async {
    return await http.get(Api.urlBase + Api.urlCommercial + id.toString());
  }
    static Future getCommercialLogin(String login, String password) async {
    var res = await http.get(Api.urlBase + Api.urlCommercial + login + "/" + password);
    return res;
  }
  
  static Future<bool> postCommercial(Commercial commercial) async {
    var monCommercial = commercial.toMap();
    var commercialBody = convert.json.encode(monCommercial);
    var res = await http.post(Api.urlBase + Api.urlCommercial,
        headers: Api.header, body: commercialBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> putCommercial(Commercial commercial) async {
    var monCommercial = commercial.toMap();
    var commercialBody = convert.json.encode(monCommercial);
    var res = await http.put(
        Api.urlBase + Api.urlCommercial + commercial.id.toString(),
        headers: Api.header,
        body: commercialBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> deleteCommercial(int id) async {
    var res = await http.delete(Api.urlBase + Api.urlCommercial + id.toString(),
        headers: Api.header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }
}
