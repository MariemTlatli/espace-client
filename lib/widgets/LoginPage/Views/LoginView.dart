import 'package:espace_client/Constants.dart' as constants;
import 'package:espace_client/widgets/LoginPage/Models/UserModel.dart';
import 'package:espace_client/widgets/LoginPage/Provider/UserProvider.dart';
import 'package:espace_client/widgets/LoginPage/Views/LoginFormView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = (screenWidth <= 600 && screenHeight <= 700);

    return Scaffold(
      body: Column(
        children: [
          if (isMobile)
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: constants.defaultSecondryColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset('/assets/img/BYSUR.jpg'),
                            // child: Image.network(constants.MonLogo),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Center(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(child: Expanded(child: LoginFormView())),
                ],
              ),
            )
          else
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: constants.defaultSecondryColor,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: constants.defaultSecondryColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          //child: SizedBox(),
                                          child: Image.asset(
                                              '/assets/img/BYSUR.jpg')),
                                      const Expanded(
                                        flex: 1,
                                        child: SizedBox(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: constants.defaultTransparentColor,
                                  ),
                                  child: Text(
                                    constants.sousTextLogo,
                                    style: TextStyle(
                                      color: constants.defaultBackgroundColor,
                                      fontSize: constants.fontSizeTitre,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: LoginFormView(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
