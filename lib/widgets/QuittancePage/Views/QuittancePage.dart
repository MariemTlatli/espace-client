import 'dart:async';
import 'package:espace_client/MySharedPrefrences/MySharedPrefrences.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/utils/MyDropDownButton.dart';
import 'package:espace_client/widgets/QuittancePage/Controller/QuittanceController.dart';
import 'package:espace_client/widgets/QuittancePage/Models/Contrat.dart';
import 'package:espace_client/widgets/QuittancePage/Provider/QuittanceProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:espace_client/Constants.dart' as constants;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class QuittancePage extends StatefulWidget {
  QuittancePage({super.key, required this.x});
  final int x;

  @override
  State<QuittancePage> createState() => _QuittancePageState();
}

class _QuittancePageState extends State<QuittancePage> {
  late QuittanceController myQuittanceController;
  late Future<void> _futureQuittances;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  ScrollController? _scrollController;
  List<Contrat> mesContrats = [];
  List<Contrat> mesContratsMobile = [];
  int nbCon = 0;
  void setListForMobile() {
    Contrat contrat0 = Contrat(
      numeroContrat: 'N° Contrat',
      primeContrat: 'Prime\n mensuelle TTC',
      datePayementContrat: 'Date de \n paiement ',
      statueContrat: 'Statut',
      telechargerContrat: 'Télécharger',
    );
    mesContratsMobile = [contrat0];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mesContratsMobile.addAll(
          Provider.of<QuittanceProvider>(context, listen: false).mesContrats);
    });
  }

  Future<void> _fetchQuittances() async {
    setListForMobile();
    return await myQuittanceController.GetAllQuittances(
      context,
      MySharedPrefrences.sharedPreferences.getString(ApiKey.id)!,
    );
  }

  Future<void> _handleRefresh() async {
    await _fetchQuittances();
    // setState(() {}); // Refresh the UI after fetching data
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    myQuittanceController = QuittanceController(context: context);
    _futureQuittances = _fetchQuittances();
  }

  @override
  Widget build(BuildContext context) {
    final quittanceProvider =
        Provider.of<QuittanceProvider>(context, listen: true);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = (screenWidth <= 600 && screenHeight <= 700);
    nbCon = quittanceProvider.nbContrats;

    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: FutureBuilder<void>(
        future: _futureQuittances,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return (nbCon > 0)
                ? Column(
                    children: [
                      Expanded(
                        flex: (!isMobile) ? 4 : 2,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: MyDropDownButton(
                                  onChanged: (String? newValue) {
                                    quittanceProvider.setStatut(newValue);
                                  },
                                  myItems: constants.maListeStatus,
                                  myHint: constants.myHintStatus,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: MyDropDownButton(
                                  myItems: constants.maListeAnneesQuittances,
                                  myHint: (!isMobile)
                                      ? constants.myHintAnnesQuittances
                                      : constants.myHintAnnesQuittances2,
                                  onChanged: (String? newValue) {
                                    quittanceProvider.setAnnee(newValue);
                                  },
                                ),
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: constants
                                      .defaultBackgroundColor, // Couleur de fond du bouton déroulant
                                  border: Border.all(
                                      color: constants.MyGreyColor,
                                      width: 1), // Bordure du bouton déroulant
                                  borderRadius: BorderRadius.circular(70),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: constants
                                          .MyGreyColor, // Couleur de l'ombre
                                      blurRadius: 5, // Rayon de flou de l'ombre
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    myQuittanceController
                                        .GetAllQuittancesFiltrer(
                                            context,
                                            MySharedPrefrences.sharedPreferences
                                                .getString(ApiKey.id)!,
                                            quittanceProvider.annee,
                                            "PLANIFIE");
                                  },
                                  icon: Icon(Icons.refresh_rounded),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Scaffold(
                          key: _scaffoldKey,
                          body: LiquidPullToRefresh(
                            key: _refreshIndicatorKey,
                            onRefresh: _handleRefresh,
                            backgroundColor: constants.defaultPrimaryColor,
                            color: constants.defaultSecondryColor,
                            showChildOpacityTransition: false,
                            child: SingleChildScrollView(
                              scrollDirection:
                                  (!isMobile) ? Axis.vertical : Axis.horizontal,
                              child: Center(
                                child: DataTable(
                                  columnSpacing: 10.0,
                                  columns: (!isMobile)
                                      ? const [
                                          DataColumn(
                                            label: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text("Numéro de contrat"),
                                            ),
                                          ),
                                          DataColumn(
                                            label: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child:
                                                  Text("Prime mensuelle TTC"),
                                            ),
                                          ),
                                          DataColumn(
                                            label: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text("Date paiement"),
                                            ),
                                          ),
                                          DataColumn(
                                            label: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text("Statut"),
                                            ),
                                          ),
                                          DataColumn(
                                            label: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child:
                                                  Text("Télécharger quittance"),
                                            ),
                                          ),
                                        ]
                                      : _buildInvertedDataColumns(
                                          quittanceProvider),
                                  rows: (!isMobile)
                                      ? List.generate(
                                          quittanceProvider.mesContrats.length,
                                          (index) => ContratDataRow(
                                              quittanceProvider
                                                  .mesContrats[index]),
                                        )
                                      : _buildInvertedDataRows(
                                          quittanceProvider),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.network(
                            'https://www.rainbow-integration.fr/wp-content/uploads/2022/01/ecm-768x512.jpg'),
                      ),
                      Expanded(
                        child: Text(
                          "Aucune quittance",
                          style: TextStyle(
                            color: constants.defaultSecondryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
          }
        },
      ),
    );
  }

  DataRow ContratDataRow(Contrat contrat) {
    return DataRow(cells: [
      DataCell(
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(contrat.numeroContrat!),
        ),
      ),
      DataCell(
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(contrat.primeContrat!),
        ),
      ),
      DataCell(
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(contrat.datePayementContrat!),
        ),
      ),
      DataCell(
        FittedBox(
          fit: BoxFit.fitWidth,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: constants.someMap[contrat.statueContrat],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                contrat.statueContrat!,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: constants.someMapText[contrat.statueContrat],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      DataCell(
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.download),
              onPressed: () {},
            ),
          ),
        ),
      ),
    ]);
  }

  List<DataColumn> _buildInvertedDataColumns(quittanceProvider) {
    return List.generate(
      mesContratsMobile.length,
      (index) => DataColumn(
        label: (mesContratsMobile[index].numeroContrat == 'numero Contrat' ||
                mesContratsMobile[index].numeroContrat == 'N° Contrat')
            ? Text('')
            : Text("Contrat ${index}"),
      ),
    );
  }

  List<DataRow> _buildInvertedDataRows(quittanceProvider) {
    return List.generate(5, (rowIndex) {
      return DataRow(
        cells: List.generate(mesContratsMobile.length, (colIndex) {
          Contrat contrat = mesContratsMobile[colIndex];
          String cellValue = "";

          switch (rowIndex) {
            case 0:
              cellValue = contrat.numeroContrat!;
              break;
            case 1:
              cellValue = contrat.primeContrat!;
              break;
            case 2:
              cellValue = contrat.datePayementContrat!;
              break;
            case 3:
              return (contrat.numeroContrat == 'numero Contrat')
                  ? DataCell(
                      Text(mesContratsMobile[0].statueContrat.toString()))
                  : DataCell(DecoratedBox(
                      decoration: BoxDecoration(
                        color: constants.someMap[contrat.statueContrat],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(contrat.statueContrat!),
                      ),
                    ));

            case 4:
              return (contrat.numeroContrat == 'numero Contrat')
                  ? DataCell(
                      Text(mesContratsMobile[0].telechargerContrat.toString()))
                  : DataCell(
                      Center(
                        child: IconButton(
                          icon: Icon(Icons.download),
                          onPressed: () {},
                        ),
                      ),
                    );
          }

          return DataCell(Text(cellValue));
        }),
      );
    });
  }
}
