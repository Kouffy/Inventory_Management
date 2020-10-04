class Inventaire {
  int _id_inventaire;
  int _id_emplacement;
 String _date_inventaire;

  Inventaire(
  this._id_emplacement,
 this._date_inventaire,
  );

  Inventaire.WithId(this._id_inventaire, this._id_emplacement, this._date_inventaire);

  int get id_inventaire => _id_inventaire;
   int get id_emplacement => _id_emplacement;
    String get date_inventaire => _date_inventaire;

  set id_inventaire(int newid_inventaire) {
    _id_inventaire = newid_inventaire;
  }

  set id_emplacement(int newid_emplacement) {
    _id_emplacement = newid_emplacement;
  }
  set date_inventaire(String newdate_inventaire) {
    _date_inventaire = newdate_inventaire;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id_emplacement"] = _id_emplacement;
    map["date_inventaire"] = _date_inventaire;
    if (_id_inventaire != null) {
      map["id_inventaire"] = _id_inventaire;
    }
    return map;
  }

  Inventaire.fromObject(dynamic o) {
    this._id_emplacement = o["id_emplacement"];
    this.id_emplacement = o["id_emplacement"];
    this.date_inventaire = o["date_inventaire"];
  }
}
