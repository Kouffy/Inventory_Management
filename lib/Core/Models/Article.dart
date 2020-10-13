class Article {
  int _idArticle;
  String _libelleArticle;
  int _idEmplacement;

  Article(
  this._libelleArticle,
 this._idEmplacement,
  );

  Article.WithId(this._idArticle, this._libelleArticle, this._idEmplacement);

  int get id => _idArticle;
   String get libelleArticle => _libelleArticle;
    int get idEmplacement => _idEmplacement;


  set libelleArticle(String newlibelle) {
    _libelleArticle = newlibelle;
  }

  set idEmplacement(int newidEmplacement) {
    _idEmplacement = newidEmplacement;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["libelleArticle"] = _libelleArticle;
    map["idEmplacement"] = _idEmplacement;
    if (_idArticle != null) {
      map["idArticle"] = _idArticle;
    }
    return map;

  }

  Article.fromObject(dynamic o) {
    this._idArticle = o["idArticle"];
    this.libelleArticle = o["libelleArticle"];
    this.idEmplacement = o["idEmplacement"];
  }
}
