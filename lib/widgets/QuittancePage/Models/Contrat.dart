class Contrat {
  final String? numeroContrat,
      primeContrat,
      datePayementContrat,
      statueContrat,
      telechargerContrat;

  Contrat({
    this.numeroContrat,
    this.primeContrat,
    this.datePayementContrat,
    this.statueContrat,
    this.telechargerContrat,
  });
  @override
  String toString() {
    return 'Contrat{numeroContrat: $numeroContrat, primeContrat: $primeContrat, datePayementContrat: $datePayementContrat, statueContrat: $statueContrat, telechargerContrat: $telechargerContrat}';
  }

// Function to parse the JSON response and extract required information
  static List<Contrat> parseContrats(List<dynamic> data) {
    List<Contrat> maList = [];
    print("bonjour");
    print(data.length);
    for (int i = 0; i < data.length; i++) {
      print(i);
      Contrat c = Contrat(
          numeroContrat: data[i]["num_contrat"],
          statueContrat: data[i]["echeances"][0]["status"],
          primeContrat: data[i]["echeances"][0]["montant"].toString() + " €",
          datePayementContrat: data[i]["echeances"][0]["date_prelevement"],
          telechargerContrat: "DSDS");
      maList.add(c);
    }
    print("object");
    return maList;
  }
}
