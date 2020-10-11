import 'package:inventory_management/Core/Controllers/Api.dart';
import 'package:inventory_management/Core/Models/Emplacement.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class EmplacementController {
  static Future getEmplacement() async {
    return await http.get(Api.urlBase + Api.urlEmplacement);
  }

  static Future getEmplacementID(int id) async {
    return await http.get(Api.urlBase + Api.urlEmplacement + id.toString());
  }
  static Future getSousEmplacemens(int id) async {
    return await http.get(Api.urlBase + Api.urlEmplacement + Api.urlGetSousEmplacements + id.toString());
  }

  static Future<bool> postEmplacement(Emplacement emplacement) async {
    var monEmplacement = emplacement.toMap();
    var emplacementBody = convert.json.encode(monEmplacement);
    var res = await http.post(Api.urlBase + Api.urlEmplacement,
        headers: Api.header, body: emplacementBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> putEmplacement(Emplacement emplacement) async {
    var monEmplacement = emplacement.toMap();
    var emplacementBody = convert.json.encode(monEmplacement);
    var res = await http.put(
        Api.urlBase + Api.urlEmplacement + emplacement.id_emplacement.toString(),
        headers: Api.header,
        body: emplacementBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> deleteEmplacement(int id) async {
    var res = await http.delete(Api.urlBase + Api.urlEmplacement + id.toString(),
        headers: Api.header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }
}
