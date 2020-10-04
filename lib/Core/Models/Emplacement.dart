class Emplacement {
  int _id_emplacment;
  String _libelle_emplacement;
  int _id_emplacment_parent;
 int _contient_article;

  Emplacement(
    this._libelle_emplacement,
  this._id_emplacment_parent,
 this._contient_article,
  );

  Emplacement.WithId(this._id_emplacment, this._libelle_emplacement, this._id_emplacment_parent,this._contient_article);

  int get id_emplacement => _id_emplacment;
   String get libelle_emplacement => _libelle_emplacement;
    int get id_emplacment_parent => _id_emplacment_parent;
     int get contient_article => _contient_article;


  set libelle_emplacement(String newlibelle_emplacement) {
    _libelle_emplacement = newlibelle_emplacement;
  }

  set id_emplacment_parent(int newid_emplacment_parent) {
    _id_emplacment_parent = newid_emplacment_parent;
  }
  set contient_article(int newcontient_article) {
    _contient_article = newcontient_article;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["libelle_emplacement"] = _libelle_emplacement;
    map["id_emplacment_parent"] = _id_emplacment_parent;
        map["contient_article"] = _contient_article;
    if (_id_emplacment != null) {
      map["id_emplacment"] = _id_emplacment;
    }
    return map;
  }

  Emplacement.fromObject(dynamic o) {
    this._id_emplacment = o["id_emplacment"];
    this.libelle_emplacement = o["libelle_emplacement"];
    this.id_emplacment_parent = o["id_emplacment_parent"];
    this.contient_article=o["contient_article"];
  }
}
