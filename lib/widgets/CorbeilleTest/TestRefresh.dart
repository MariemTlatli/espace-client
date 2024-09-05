import 'dart:async';

import 'package:espace_client/widgets/QuittancePage/Controller/QuittanceController.dart';
import 'package:espace_client/widgets/QuittancePage/Models/Contrat.dart';
import 'package:espace_client/widgets/QuittancePage/Provider/QuittanceProvider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:espace_client/Constants.dart' as constants;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  late QuittanceController myQuittanceController;

  // number that changes when refreshed

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    myQuittanceController = QuittanceController(context: context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myQuittanceController.GenerateAllQuittances(20);
    });
  }

  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    myQuittanceController.GenerateAllQuittances(30);

    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              _refreshIndicatorKey.currentState!.show();
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final quittanceProvider =
        Provider.of<QuittanceProvider>(context, listen: true);

    return Scaffold(
      key: _scaffoldKey,
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: DataTable(
              columns: const [
                DataColumn(label: Text('Numero Contrat')),
                DataColumn(label: Text('Prime Contrat')),
                DataColumn(label: Text('Date Payement')),
                DataColumn(label: Text('Statut')),
                DataColumn(label: Text('Telecharger')),
              ],
              rows: List.generate(
                quittanceProvider.mesContrats.length,
                (index) => ContratDataRow(quittanceProvider.mesContrats[index]),
              )),
        ),
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
                  color: constants.someMap[contrat
                      .statueContrat], // Couleur de fond du bouton déroulant
                  border: Border.all(
                      color: constants.MyGreyColor,
                      width: 1), // Bordure du bouton déroulant
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(contrat.statueContrat!),
                ))),
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
}
