import 'package:espace_client/AppProvider/mainProvider.dart';
import 'package:espace_client/MySharedPrefrences/MySharedPrefrences.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/utils/Drawer.dart';
import 'package:espace_client/utils/ErrorPage.dart';
import 'package:espace_client/widgets/AcceuilPage/Views/AcceuilView.dart';
import 'package:espace_client/widgets/AttestationPage/Views/AttestationPage.dart';
import 'package:espace_client/widgets/LoginPage/Provider/UserProvider.dart';
import 'package:espace_client/widgets/MyContainer/Views/pageHeader.dart';
import 'package:espace_client/widgets/MyContainer/provider/DrawerProvider.dart';
import 'package:espace_client/widgets/QuittancePage/Controller/QuittanceController.dart';
import 'package:espace_client/widgets/QuittancePage/Provider/QuittanceProvider.dart';
import 'package:espace_client/widgets/QuittancePage/Views/quittancePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:espace_client/Constants.dart' as constants;

class MyConatinerView extends StatefulWidget {
  const MyConatinerView({super.key});

  @override
  State<MyConatinerView> createState() => _MyContainerViewState();
}

class _MyContainerViewState extends State<MyConatinerView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      QuittanceController myQuittanceController =
          QuittanceController(context: context);

      myQuittanceController.GetAllQuittances(
          context,
          MySharedPrefrences.sharedPreferences.getString(
            ApiKey.id,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = (screenWidth <= 600 && screenHeight <= 700);
    String userName =
        Provider.of<UserProvider>(context, listen: true).user.userName;
    List<String> maListeTitres = [
      'Bonjour ' + userName,
      'mes contrats',
      'mes quittances',
      'mes attestations d\'assurances',
      'Mes documents',
      'Mes devis',
      'Mes sinistres',
      'Mes résiliations',
      'Déconnexion',
    ];
    /*int x =
        Provider.of<QuittanceProvider>(context, listen: false).GetNbContrats();
    print(x);*/
    final drawerProvider = Provider.of<DrawerProvider>(context, listen: true);
    return Scaffold(
      appBar: isMobile ? constants.myAppBar : null,
      drawer: isMobile ? MyDrawer(isMobile: isMobile) : null,
      backgroundColor: constants.defaultBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: constants.IconEmailColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.message,
          color: constants.defaultBackgroundColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            if (!isMobile)
              Expanded(
                flex: 2,
                child: MyDrawer(isMobile: isMobile),
              ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: PageHeader(
                      isMobile: isMobile,
                      visibilityRechercheBarre:
                          drawerProvider.GetSelectedItemIndex == 0,
                      index: drawerProvider.GetSelectedItemIndex,
                      titre: "Acceuil",
                      sousTitre:
                          maListeTitres[drawerProvider.GetSelectedItemIndex],
                      visibleIconButton: true,
                      visibleButton:
                          false /*drawerProvider.GetSelectedItemIndex ==
                          1 ||
                          drawerProvider.GetSelectedItemIndex == 6*/
                      ,
                      textButton: drawerProvider.GetSelectedItemIndex == 1
                          ? constants.maListeButtonsText[0]
                          : constants.maListeButtonsText[1],
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Builder(
                      builder: (context) {
                        switch (drawerProvider.GetSelectedItemIndex) {
                          case 0:
                            return AcceuilView();
                          case 1:
                            return const Center(
                              child: ErrorPage(
                                titre: "Quelque chose s'est mal passé",
                                sousTitre: 'Veuillez réessayer plus tard',
                              ),
                            );
                          case 2:
                            return QuittancePage(x: 1);
                          case 3:
                            return AttestationPage();
                          /*const Center(
                              child: ErrorPage(
                                titre: "Quelque chose s'est mal passé",
                                sousTitre: 'Veuillez réessayer plus tard',
                              ),
                            );*/
                          case 4:
                            return const Center(
                              child: ErrorPage(
                                titre: "Quelque chose s'est mal passé",
                                sousTitre: 'Veuillez réessayer plus tard',
                              ),
                            );
                          case 6:
                            return const Center(
                              child: Text('Mes sinistres'),
                            );
                          default:
                            return AcceuilView();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
