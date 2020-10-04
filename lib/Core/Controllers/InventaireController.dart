import 'package:inventory_management/Core/Controllers/Api.dart';
import 'package:inventory_management/Core/Models/Inventaire.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class InventaireController {
  static Future getInventaire() async {
    return await http.get(Api.urlBase + Api.urlInventaire);
  }

  static Future getInventaireID(int id) async {
    return await http.get(Api.urlBase + Api.urlInventaire + id.toString());
  }

  static Future<bool> postInventaire(Inventaire inventaire) async {
    var monInventaire = inventaire.toMap();
    var inventaireBody = convert.json.encode(monInventaire);
    var res = await http.post(Api.urlBase + Api.urlInventaire,
        headers: Api.header, body: inventaireBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> putInventaire(Inventaire inventaire) async {
    var monInventaire = inventaire.toMap();
    var inventaireBody = convert.json.encode(monInventaire);
    var res = await http.put(
        Api.urlBase + Api.urlInventaire + inventaire.id_inventaire.toString(),
        headers: Api.header,
        body: inventaireBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> deleteInventaire(int id) async {
    var res = await http.delete(Api.urlBase + Api.urlInventaire + id.toString(),
        headers: Api.header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }
}
