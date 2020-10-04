class Article {
  int _id_article;
  String _libelle_article;
  int _id_emplacement;

  Article(
  this._libelle_article,
 this._id_emplacement,
  );

  Article.WithId(this._id_article, this._libelle_article, this._id_emplacement);

  int get id => _id_article;
   String get libelle_article => _libelle_article;
    int get id_emplacment => _id_emplacement;


  set libelle_article(String newlibelle) {
    _libelle_article = newlibelle;
  }

  set id_emplacement(int newid_emplacement) {
    _id_emplacement = newid_emplacement;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["libelle_article"] = _libelle_article;
    map["id_emplacement"] = _id_emplacement;
    if (_id_article != null) {
      map["id_article"] = _id_article;
    }
    return map;

  }

  Article.fromObject(dynamic o) {
    this._id_article = o["id_article"];
    this.libelle_article = o["libelle_article"];
    this.id_emplacement = o["id_emplacement"];
  }
}
