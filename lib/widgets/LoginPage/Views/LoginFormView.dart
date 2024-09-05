import 'package:email_validator/email_validator.dart';
import 'package:espace_client/utils/CustomButton.dart';
import 'package:espace_client/utils/CustomToast.dart';
import 'package:espace_client/utils/Header.dart';
import 'package:espace_client/widgets/LoginPage/Controller/LoginController.dart';
import 'package:espace_client/widgets/LoginPage/Provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:espace_client/Constants.dart' as constants;

class LoginFormView extends StatefulWidget {
  LoginFormView({super.key});

  @override
  _LoginFormViewState createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final _formKey = GlobalKey<FormState>();
  late LoginController myLoginController;
  @override
  void initState() {
    super.initState();
    myLoginController = LoginController(context: context);
    myLoginController.GetAcessToken(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    myLoginController = LoginController(context: context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: constants.defaultBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: MyHeader(text: constants.headerText),
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      color: constants.defaultBackgroundColor,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Visibility(
                            visible: userProvider.isTextFieldMailVisible,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                fillColor: constants.MyGreyColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: constants.IconEmailColor,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer une adresse e-mail';
                                }
                                if (!EmailValidator.validate(value)) {
                                  return 'Veuillez entrer une adresse e-mail valide';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userProvider.setMail(value);

                                print(userProvider.Getemail);
                              },
                            ),
                          ),
                          Visibility(
                            visible: userProvider.isTextFieldPasswordVisible,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: TextFormField(
                                obscureText: userProvider.obscureTextPass,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    fillColor: constants.MyGreyColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: constants.IconEmailColor,
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(userProvider.obscureTextPass
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        onPressed: () {
                                          userProvider.setobscureTextPass(
                                              !userProvider.obscureTextPass);
                                        })),
                                validator: (value) {
                                  String errMsg =
                                      'Le mot de passe doit contenir au moins : \n 8 caractères';
                                  bool len = false;
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un mot de passe';
                                  }
                                  if (value.length < 8) {
                                    len = true;
                                  }

                                  bool hasUppercase = false;
                                  bool hasDigits = false;
                                  bool hasSpecialCharacters = false;
                                  String specialCharacters = '!@#\$&*~';

                                  for (int i = 0; i < value.length; i++) {
                                    if (value[i]
                                        .contains(new RegExp(r'[A-Z]'))) {
                                      hasUppercase = true;
                                    } else if (value[i]
                                        .contains(new RegExp(r'[0-9]'))) {
                                      hasDigits = true;
                                    } else if (specialCharacters
                                        .contains(value[i])) {
                                      hasSpecialCharacters = true;
                                    }
                                  }

                                  if (!hasUppercase) {
                                    errMsg += ' \n 1 lettre majuscule';
                                  }
                                  if (!hasDigits) {
                                    errMsg += ' \n 1 chiffre';
                                  }
                                  if (!hasSpecialCharacters) {
                                    errMsg += '\n 1 caractère spécial';
                                  }
                                  if (len ||
                                      !hasUppercase ||
                                      !hasDigits ||
                                      !hasSpecialCharacters) {
                                    return errMsg;
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  userProvider.setPassword(value);
                                  print(userProvider.Getpassword);
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                userProvider.isTextFieldConfirmPasswordVisible,
                            child: TextFormField(
                              obscureText: userProvider.obscureTextConfirmPass,
                              decoration: InputDecoration(
                                  labelText: 'Confirm password',
                                  fillColor: constants.MyGreyColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.lock_reset_outlined,
                                    color: constants.IconEmailColor,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                          userProvider.obscureTextConfirmPass
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                      onPressed: () {
                                        userProvider.setobscureTextConfirmPass(
                                            !userProvider
                                                .obscureTextConfirmPass);
                                      })),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez réecrire votre mot de passe';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userProvider.setConfirmPassword(value);
                                print(userProvider.GetConfirmPassword);
                              },
                            ),
                          ),
                          Visibility(
                            visible: userProvider.isTextFieldMailVisible,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('Mot de passe oublié?'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (!userProvider.isLoading)
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: CustomButton(
                                myPadding: 20.0,
                                isButtonEnabled: userProvider.isButtonEnabled,
                                onPressed: () {
                                  _formKey.currentState!.save();
                                  // Valide le formulaire
                                  bool isFormValid =
                                      _formKey.currentState!.validate();

                                  // Récupère les infos
                                  String email = userProvider.Getemail;
                                  String password = userProvider.Getpassword;
                                  String confirmPassword =
                                      userProvider.GetConfirmPassword;

                                  if (isFormValid) {
                                    // Vérifie si le champ email est visible
                                    if (userProvider.isTextFieldMailVisible) {
                                      myLoginController.VerifierMail(
                                          email, context);
                                    } else if (userProvider
                                            .isTextFieldPasswordVisible &&
                                        userProvider
                                            .isTextFieldConfirmPasswordVisible) {
                                      // Vérifie si les mots de passe correspondent
                                      if (password == confirmPassword) {
                                        myLoginController.HandleLoginUserExist(
                                            email,
                                            password,
                                            userProvider.userState);
                                      } else {
                                        CustomFlushbar.showFlushbar(
                                          context,
                                          'Les mots de passe ne correspondent pas. Veuillez réessayer.',
                                          backgroundColor:
                                              constants.ButtonColor,
                                        );
                                      }
                                    } else {
                                      myLoginController.HandleLoginUserExist(
                                          email,
                                          password,
                                          userProvider.userState);
                                    }
                                  }
                                },
                                text: 'Se Connecter',
                                color: constants.ButtonColor,
                              ),
                            )
                          : CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
