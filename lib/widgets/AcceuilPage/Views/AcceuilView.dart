import 'package:espace_client/utils/CustomToast.dart';
import 'package:espace_client/widgets/AcceuilPage/Controller/AcceuilController.dart';
import 'package:espace_client/widgets/AcceuilPage/Provider/AcceuilProvider.dart';
import 'package:flutter/material.dart';
import 'package:espace_client/Constants.dart' as constants;
import 'package:espace_client/utils/MyDropDownButton.dart';
import 'package:provider/provider.dart';

class AcceuilView extends StatefulWidget {
  @override
  State<AcceuilView> createState() => _AcceuilViewState();
}

class _AcceuilViewState extends State<AcceuilView> {
  int nbTacheJour = 0;
  late AcceuilController myAcceuilController;
  @override
  void initState() {
    super.initState();
    myAcceuilController = AcceuilController(context: context);
    myAcceuilController.GetListPriorites(context);
  }

  @override
  Widget build(BuildContext context) {
    final acceuilProvider = Provider.of<AcceuilProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: constants.defaultBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.access_time_rounded),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 4.0),
                  child: Text(
                    'Liste de vos taches à faire',
                    style: TextStyle(
                      color: constants.defaultSecondryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              MyDropDownButton(
                onChanged: (String? newValue) {},
                myItems: acceuilProvider.listePriorites
                    .map((priorite) => priorite.libelle)
                    .toList(),
                myHint: constants.myHint,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Taches du jour',
                  style: TextStyle(
                    color: constants.defaultSecondryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: (nbTacheJour == 0)
                    ? Text('Pas de taches à faire aujourd\'hui')
                    : Text('Vos Taches : '),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Autres Taches',
                  style: TextStyle(
                    color: constants.defaultSecondryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: (nbTacheJour == 0)
                    ? Text('Pas de taches')
                    : Text('Vos Taches : '),
              ),
              TextButton(
                  onPressed: () {
                    CustomFlushbar.showFlushbar(context, "Bonjour",
                        backgroundColor: Color.fromARGB(255, 149, 215, 248));

                    myAcceuilController = AcceuilController(context: context);
                    myAcceuilController.GetMaListTaches(context);
                  },
                  child: Text("test"))
            ],
          )),
    );
  }
}
