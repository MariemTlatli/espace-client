import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  List<Contrat> _contrats = []; // number that changes when refreshed

  ScrollController? _scrollController;

  List<Contrat> generateContracts(int count) {
    final random = Random();
    return List.generate(count, (index) {
      return Contrat(
        numeroContrat: 'ID${index + 1}',
        primeContrat: '\$${(index + 1) * 1000.0}',
        datePayementContrat: DateTime.now()
            .subtract(Duration(days: random.nextInt(30)))
            .toLocal()
            .toString()
            .split(' ')[0],
        statueContrat: random.nextBool() ? 'Paid' : 'Unpaid',
        telechargerContrat: 'Download',
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _contrats = generateContracts(20);
  }

  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {
      _contrats = generateContracts(40);
    });
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title!),
      ),
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
            rows: _contrats.map((contrat) {
              return DataRow(cells: [
                DataCell(Text(contrat.numeroContrat ?? '')),
                DataCell(Text(contrat.primeContrat ?? '')),
                DataCell(Text(contrat.datePayementContrat ?? '')),
                DataCell(Text(contrat.statueContrat ?? '')),
                DataCell(Text(contrat.telechargerContrat ?? '')),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Contrat {
  final String? numeroContrat;
  final String? primeContrat;
  final String? datePayementContrat;
  final String? statueContrat;
  final String? telechargerContrat;

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
}
