class Commercial {
  int _idCommercial;
  String _nomCommercial;
  String _prenomCommercial;
 String _loginCommercial;
 String _passwordCommercial;

  Commercial(
    this._nomCommercial,
  this._prenomCommercial,
 this._loginCommercial,
this._passwordCommercial,
  );

  Commercial.WithidCommercial(this._nomCommercial, this._prenomCommercial, this._loginCommercial,this._passwordCommercial);

  int get idCommercial => _idCommercial;
   String get nomCommercial => _nomCommercial;
    String get prenomCommercial => _prenomCommercial;
     String get loginCommercial => _loginCommercial;
       String get passwordCommercial => _passwordCommercial;

  set nomCommercial(String newnomCommercial) {
    _nomCommercial = newnomCommercial;
  }

  set prenomCommercial(String newprenomCommercial) {
    _prenomCommercial = newprenomCommercial;
  }
  set loginCommercial(String newloginCommercial) {
    _loginCommercial = newloginCommercial;
  }
    set passwordCommercial(String newpasswordCommercial) {
    _passwordCommercial = newpasswordCommercial;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["nomCommercial"] = _nomCommercial;
    map["prenomCommercial"] = _prenomCommercial;
        map["loginCommercial"] = _loginCommercial;
    map["passwordCommercial"] = _passwordCommercial;
    if (_idCommercial != null) {
      map["idCommercial"] = _idCommercial;
    }
    return map;
  }

  Commercial.fromObject(dynamic o) {
    this._idCommercial = o["idCommercial"];
    this.nomCommercial = o["nomCommercial"];
    this.prenomCommercial = o["prenomCommercial"];
    this.loginCommercial=o["loginCommercial"];
    this.passwordCommercial=o["passwordCommercial"];
  }
}
