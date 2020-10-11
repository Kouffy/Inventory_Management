class Api {
  static String urlBase = 'http://192.168.11.107:9090/api/';
  static String urlAdministrateur = 'Administrateur/';
  static String urlGetSousEmplacements = 'GetSousEmplacments/';
  static String urlCommercial = 'Commercial/';
  static String urlInventaire = 'Inventaire/';
  static String urlArticle = 'Article/';
  static String urlEmplacement = 'Emplacement/';
  static String urlGetArticlesEmplacment ='GetArticlesEmplacment/';
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
}
