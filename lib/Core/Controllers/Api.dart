class Api {
  static String urlBase = 'http://192.168.x.x:5000/api/';
  static String urlAdministrateur = 'Administrateur/';
  static String urlCommercial = 'Commercial/';
  static String urlInventaire = 'Inventaire/';
  static String urlArticle = 'Article/';
  static String urlEmplacement = 'Emplacement/';
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
}
