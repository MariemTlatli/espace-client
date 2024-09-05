import 'package:espace_client/Constants.dart';
import 'package:espace_client/MySharedPrefrences/MySharedPrefrences.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/widgets/AcceuilPage/Provider/AcceuilProvider.dart';
import 'package:espace_client/widgets/LoginPage/Provider/UserProvider.dart';
import 'package:espace_client/widgets/LoginPage/Views/LoginView.dart';
import 'package:espace_client/widgets/MyContainer/provider/DrawerProvider.dart';
import 'package:espace_client/widgets/QuittancePage/Provider/QuittanceProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:espace_client/Constants.dart' as constants;

class MyDrawer extends StatefulWidget {
  final bool isMobile;
  const MyDrawer({super.key, required this.isMobile});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final bool isMobile = (screenWidth <= 600 && screenHeight <= 700);

    return Drawer(
      backgroundColor: constants.defaultSecondryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Image.asset('assets/img/BYSUR.jpg'),
            /* child: Image.network(
                "https://scontent.ftun16-1.fna.fbcdn.net/v/t39.30808-6/271712710_111378994760534_6728790707634796097_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_ohc=JezJ7KB3R24Q7kNvgHCUEa_&_nc_ht=scontent.ftun16-1.fna&oh=00_AYB4ZCsIC06s6Ircznl0lBDlKF31aV1Pi-Eq168rMJpT0A&oe=66A6E954"),
            */
            decoration: BoxDecoration(
              color: constants.defaultSecondryColor,
            ),
          ),
          drawerItem(context, 'Accueil', Icons.home, 0),
          drawerItem(context, 'Contrats', Icons.file_copy, 1),
          drawerItem(context, 'Quittances', Icons.receipt, 2),
          drawerItem(context, 'Attestations', Icons.check_circle, 3),
          drawerItem(context, 'Documents', Icons.folder, 4),
          drawerItem(context, 'Devis', Icons.edit, 5),
          drawerItem(context, 'Sinistres', Icons.warning, 6),
          drawerItem(context, 'Résiliations', Icons.cancel, 7),
          drawerItem(context, 'Déconnexion', Icons.exit_to_app, 8),
        ],
      ),
    );
  }
}

//------------------------------------------------------------------
Widget drawerItem(
    BuildContext context, String title, IconData icon, int index) {
  final drawerProvider = Provider.of<DrawerProvider>(context, listen: true);
  bool isSelected = drawerProvider.GetSelectedItemIndex == index;
  return TweenAnimationBuilder(
    tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
    duration: Duration(milliseconds: 300),
    child:
        buildListTile(icon, isSelected, title, drawerProvider, index, context),
    builder: (context, scale, child) {
      return Transform.scale(
        scale: scale,
        child: child,
      );
    },
  );
}

Widget buildListTile(icon, isSelected, title, drawerProvider, index, context) {
  return ListTile(
    selectedTileColor: defaultBackgroundColor,
    tileColor: defaultSecondryColor,
    leading: Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Icon(icon,
          color: isSelected ? defaultSecondryColor : defaultBackgroundColor),
    ),
    title: Text(title,
        style: TextStyle(
            color: isSelected ? defaultSecondryColor : defaultBackgroundColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4)),
    selected: isSelected,
    onTap: () {
      drawerProvider.setSelectedItemIndex(index);
      if (index == 8) {
        signOut(context);
        Provider.of<UserProvider>(context, listen: false).setVisibleMail(true);
        Provider.of<UserProvider>(context, listen: false).setVisiblePass(false);
        Provider.of<UserProvider>(context, listen: false)
            .setVisibleConfirmPass(false);
      }
    },
  );
}

//-----------------------------------------------------------------
void signOut(BuildContext context) async {
  final navigator = Navigator.of(context);
  await MySharedPrefrences().removeData(key: ApiKey.token);
  String? token = MySharedPrefrences().getDataString(key: ApiKey.token);
  print("my token = $token");
  // vider pro
  /* Provider.of<AcceuilProvider>(context, listen: false).clearAcceuilProvider();
  Provider.of<UserProvider>(context, listen: false).resetUserData();
  Provider.of<DrawerProvider>(context, listen: false).resetDrawerProvider();
  Provider.of<QuittanceProvider>(context, listen: false).resetQuittanceData();
*/
  MySharedPrefrences().logSharedPreferences();
  navigator.pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const LoginView(),
    ),
    (route) => false,
  );
}
