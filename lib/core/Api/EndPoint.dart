class EndPoint {
  static String baseUrl = "https://ws.recette.berilish.cloud.geoprod.com";
  static String loginEndPoint = "/login";
  static String register_or_checkEndPoint = "/register_or_check_password";
  static String list_priorite = "/list_priorite";

  static String list_status_affaires = "/list_status_affaires";

  static String list_taches_prospects = "/list_taches_prospects/";
  static String getList_type_contrat() {
    return ("/list_type_contrat/514232");
    //return (list_taches_prospects + id);
  }

  static String getList(String id) {
    print(list_taches_prospects + id);
    return (list_taches_prospects + id);
  }

  static String getQuittances(String id) {
    return ("/echeancier/get_echeances_by_prospect/" + id);
  }

  static String getAttestations(String id) {
    return ("/v1/list_affaires/" + id);
  }
}

class ApiKey {
  static String apiKey = 'Authorization';
  static String apiValue = 'Basic 5885deea-f4c3-c5a-b8c-7e1148a33a10';

  static String email = "email";
  static String password = "password";
  static String token = "Acces_Token";
  static String idSession = "idSession";
  static String adresse_mail = "adresse_mail";
  static String userName = "name";

  static String error = "error";
  static String message = "message";

  static String key = "key";
  static String id = "id";

  static String limit = "limit";
  static String page = "page";
  static String annee = "annee";
  static String num_contrat = "num_contrat";
  static String status = "status";
}
