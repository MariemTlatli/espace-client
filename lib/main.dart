import 'package:espace_client/AppProvider/mainProvider.dart';
import 'package:espace_client/widgets/AcceuilPage/Provider/AcceuilProvider.dart';
import 'package:espace_client/widgets/AttestationPage/Provider/AttestationProvider.dart';
import 'package:espace_client/widgets/LoginPage/Provider/UserProvider.dart';
import 'package:espace_client/widgets/LoginPage/Service/LoginService.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/MySharedPrefrences/MySharedPrefrences.dart';
import 'package:espace_client/widgets/LoginPage/Views/LoginFormView.dart';
import 'package:espace_client/widgets/MyContainer/Views/MyContainerView.dart';
import 'package:espace_client/widgets/LoginPage/Views/LoginView.dart';
import 'package:espace_client/widgets/MyContainer/provider/DrawerProvider.dart';
import 'package:espace_client/widgets/QuittancePage/Provider/QuittanceProvider.dart';
import 'package:espace_client/widgets/CorbeilleTest/TestRefresh.dart';
import 'package:espace_client/widgets/CorbeilleTest/quittancePageWithRefresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Flutter initialized 9abal.
  await MySharedPrefrences().init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? id = MySharedPrefrences.sharedPreferences.getString(
      ApiKey.id,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DrawerProvider>(
          create: (_) => DrawerProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<AcceuilProvider>(
          create: (_) => AcceuilProvider(),
        ),
        ChangeNotifierProvider<QuittanceProvider>(
          create: (_) => QuittanceProvider(),
        ),
        ChangeNotifierProvider<AttestationProvider>(
          create: (_) => AttestationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: MyConatinerView(),
        // home: MyHomePage(title: 'Liquid Pull To Refresh'),
        home: (id == null) ? LoginView() : MyConatinerView(),
        //home: const MyHomePage(title: 'Liquid Pull To Refresh'),
      ),
    );
  }
}
