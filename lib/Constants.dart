import 'package:espace_client/utils/Drawer.dart';
import 'package:espace_client/widgets/LoginPage/Provider/UserProvider.dart';
import 'package:espace_client/widgets/QuittancePage/Models/Contrat.dart';
import 'package:flutter/material.dart';

//---------------- mes couleurs ------------------
var defaultTransparentColor = Color.fromARGB(0, 31, 29, 161);
var defaultBackgroundColor = Colors.white;
var defaultPrimaryColor = Colors.blueAccent;
var IconEmailColor = Colors.lightBlue;
var ButtonColor = Colors.red;
var greenColor = const Color.fromARGB(255, 42, 158, 102);
Color MyGreyColor = const Color.fromRGBO(246, 246, 246, 1.0);
Color MyGreyColor2 = Color.fromARGB(255, 152, 151, 151);

Color MyDarkGreyColor = Color.fromARGB(255, 125, 124, 124);
Color defaultSecondryColor = Color.fromRGBO(13, 11, 35, 1.0);

// ------------------ logo de l'entreprise  ------------
String MonLogo =
    "https://scontent.ftun16-1.fna.fbcdn.net/v/t39.30808-6/271712710_111378994760534_6728790707634796097_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_ohc=JezJ7KB3R24Q7kNvgHCUEa_&_nc_ht=scontent.ftun16-1.fna&oh=00_AYB4ZCsIC06s6Ircznl0lBDlKF31aV1Pi-Eq168rMJpT0A&oe=66A6E954";
// ------------------ Text sous le logo dans login
String sousTextLogo = "Mon Espace Client";
double fontSizeTitre = 28;
// COLOR  defaultBackgroundColor
// ----------------------- Header login
String NetworkImageHeader = "https://placehold.co/600x400";

String headerText =
    "Connectez-vous à votre espace pour gagner du temps. \n Gérez tous vos contrats et souscrivez de nouveau en quelques clics!";
// ----------------------- container
var appBarColor = defaultSecondryColor;
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  iconTheme: IconThemeData(color: Colors.white),
  surfaceTintColor: Colors.white,
  title: Text(' '),
  /*actions: [
    Expanded(
      flex: 1,
      child: Image.network(MonLogo),
    ),
  ],*/
  centerTitle: false,
);
// -------------------------------- PageHeader titre et boutton Text
/*
List<String> maListeTitres = [
  'Bonjour',
  'mes contrats',
  'mes quittances',
  'mes attestations d\'assucrances',
  'Mes documents',
  'Mes devis',
  'Mes sinistres',
  'Mes résiliations',
  'Déconnexion',
];*/
List<String> maListeButtonsText = [
  'Souscrire un contrat',
  'Déclarer une sinistre',
];
// ----- barre de recherche fonction en paramètres

// ----------------- Acceuil view
List<String> maListePriorite = [
  'faible',
  'moyenne',
  'important',
];
// ------------------ Quittance page
String myHint = 'Priorité';
String myHintStatus = 'Statut';
String myHintAnnesQuittances = 'Années de quittances';
String myHintAnnesQuittances2 = "Années";
List<String> maListeStatus = [
  'Planifiée',
  'En cours',
  'Terminée',
];
Map<String, Color> someMap = {
  'Terminée': Color.fromARGB(205, 228, 82, 72),
  'En cours': const Color.fromARGB(255, 90, 178, 250),
  'PLANIFIE': const Color.fromARGB(255, 109, 206, 113),
};
Map<String, Color> someMapText = {
  'Terminée': Color.fromARGB(255, 179, 59, 50),
  'En cours': Color.fromARGB(255, 0, 104, 189),
  'PLANIFIE': Color.fromARGB(255, 50, 135, 53),
};
Map<String, String> someMapTextConvert = {
  'TERMINE': 'Terminée',
  'EN COURS': 'En cours',
  'PLANIFIE': 'Planifiée',
};

List<String> maListeAnneesQuittances = [
  '2020',
  '2021',
  '2022',
  '2023',
  '2024',
];

final contrat0 = Contrat(
  numeroContrat: 'numero Contrat',
  primeContrat: 'prime Contrat',
  datePayementContrat: 'date Payement ',
  statueContrat: 'statue Contrat',
  telechargerContrat: 'telecharger Contrat',
);

final contrat1 = Contrat(
  numeroContrat: 'HCC000032',
  primeContrat: '1138€',
  datePayementContrat: '29/06/2024',
  statueContrat: 'Planifiée',
  telechargerContrat: 'Lien de téléchargement',
);

final contrat2 = Contrat(
  numeroContrat: 'HCC000033',
  primeContrat: '1200€',
  datePayementContrat: '15/07/2024',
  statueContrat: 'En cours',
  telechargerContrat: 'Lien de téléchargement',
);

final listeContrats = [contrat2, contrat1];
final listeContratsMobile = [contrat0, contrat2, contrat1, contrat2];
