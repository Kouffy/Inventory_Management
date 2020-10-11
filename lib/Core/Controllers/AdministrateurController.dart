import 'package:inventory_management/Core/Controllers/Api.dart';
import 'package:inventory_management/Core/Models/Administrateur.dart';
import 'dart:convert' as convert;
import 'Api.dart';
import 'package:http/http.dart' as http;

class AdministrateurController {
  static Future getAdministrateur() async {
    return await http.get(Api.urlBase + Api.urlAdministrateur);
  }

  static Future getAdministrateurID(int id) async {
    return await http.get(Api.urlBase + Api.urlAdministrateur + id.toString());
  }
  
  static Future getAdministrateurLogin(String login, String password) async {
    var res = await http.get(Api.urlBase + Api.urlAdministrateur + login + "/" + password);
    return res;
  }

  static Future<bool> postAdministrateur(Administrateur administrateur) async {
    var monAdministrateur = administrateur.toMap();
    var administrateurBody = convert.json.encode(monAdministrateur);
    var res = await http.post(Api.urlBase + Api.urlAdministrateur,
        headers: Api.header, body: administrateurBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> putAdministrateur(Administrateur administrateur) async {
    var monAdministrateur = administrateur.toMap();
    var administrateurBody = convert.json.encode(monAdministrateur);
    var res = await http.put(
        Api.urlBase + Api.urlAdministrateur + administrateur.idAdministrateur.toString(),
        headers: Api.header,
        body: administrateurBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> deleteAdministrateur(int id) async {
    var res = await http.delete(Api.urlBase + Api.urlAdministrateur + id.toString(),
        headers: Api.header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }
}
