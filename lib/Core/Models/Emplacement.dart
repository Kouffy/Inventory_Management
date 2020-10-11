class Emplacement {
  int _idEmplacement;
  String _libelleEmplacement;
  int _idEmplacementParent;
 int _contientArticle;

  Emplacement(
    this._libelleEmplacement,
  this._idEmplacementParent,
 this._contientArticle,
  );

  Emplacement.WithId(this._idEmplacement, this._libelleEmplacement, this._idEmplacementParent,this._contientArticle);

  int get id_emplacement => _idEmplacement;
   String get libelleEmplacement => _libelleEmplacement;
    int get idEmplacementParent => _idEmplacementParent;
     int get contientArticle => _contientArticle;


  set libelleEmplacement(String newlibelleEmplacement) {
    _libelleEmplacement = newlibelleEmplacement;
  }

  set idEmplacementParent(int newidEmplacementParent) {
    _idEmplacementParent = newidEmplacementParent;
  }
  set contientArticle(int newcontientArticle) {
    _contientArticle = newcontientArticle;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["libelleEmplacement"] = _libelleEmplacement;
    map["idEmplacementParent"] = _idEmplacementParent;
        map["contientArticle"] = _contientArticle;
    if (_idEmplacement != null) {
      map["idEmplacement"] = _idEmplacement;
    }
    return map;
  }

  Emplacement.fromObject(dynamic o) {
    this._idEmplacement = o["idEmplacement"];
    this.libelleEmplacement = o["libelleEmplacement"];
    this.idEmplacementParent = o["idEmplacementParent"];
    this.contientArticle=o["contientArticle"];
  }
}
