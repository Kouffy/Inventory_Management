class Administrateur {
  int _idAdministrateur;
  String _nomAdministrateur;
  String _prenomAdministrateur;
 String _loginAdministrateur;
 String _passwordAdministrateur;

  Administrateur(
    this._nomAdministrateur,
  this._prenomAdministrateur,
 this._loginAdministrateur,
this._passwordAdministrateur,
  );

  Administrateur.WithidAdministrateur(this._nomAdministrateur, this._prenomAdministrateur, this._loginAdministrateur,this._passwordAdministrateur);

  int get idAdministrateur => _idAdministrateur;
   String get nomAdministrateur => _nomAdministrateur;
    String get prenomAdministrateur => _prenomAdministrateur;
     String get loginAdministrateur => _loginAdministrateur;
       String get passwordAdministrateur => _passwordAdministrateur;

  set nomAdministrateur(String newnomAdministrateur) {
    _nomAdministrateur = newnomAdministrateur;
  }

  set prenomAdministrateur(String newprenomAdministrateur) {
    _prenomAdministrateur = newprenomAdministrateur;
  }
  set loginAdministrateur(String newloginAdministrateur) {
    _loginAdministrateur = newloginAdministrateur;
  }
    set passwordAdministrateur(String newpasswordAdministrateur) {
    _passwordAdministrateur = newpasswordAdministrateur;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["nomAdministrateur"] = _nomAdministrateur;
    map["prenomAdministrateur"] = _prenomAdministrateur;
        map["loginAdministrateur"] = _loginAdministrateur;
    map["passwordAdministrateur"] = _passwordAdministrateur;
    if (_idAdministrateur != null) {
      map["idAdministrateur"] = _idAdministrateur;
    }
    return map;
  }

  Administrateur.fromObject(dynamic o) {
    this._idAdministrateur = o["idAdministrateur"];
    this.nomAdministrateur = o["nomAdministrateur"];
    this.prenomAdministrateur = o["prenomAdministrateur"];
    this.loginAdministrateur=o["loginAdministrateur"];
    this.passwordAdministrateur=o["passwordAdministrateur"];
  }
}
