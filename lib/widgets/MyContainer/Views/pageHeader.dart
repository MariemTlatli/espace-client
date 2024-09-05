import 'package:espace_client/utils/BarreRecherche.dart';
import 'package:espace_client/utils/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:espace_client/Constants.dart' as constants;

class PageHeader extends StatelessWidget {
  final Key? key;
  final int index;
  final String titre;
  final String sousTitre;
  final bool visibleIconButton;
  final bool visibleButton;
  final bool visibilityRechercheBarre;
  final String textButton;
  final Function onPressed;
  final bool isMobile;
  PageHeader(
      {this.key,
      required this.index,
      required this.titre,
      required this.sousTitre,
      required this.visibleIconButton,
      required this.textButton,
      required this.visibilityRechercheBarre,
      required this.visibleButton,
      required this.onPressed,
      required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        color: constants.defaultBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: visibilityRechercheBarre,
              child: Expanded(
                flex: 2,
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        titre,
                        style: TextStyle(
                          color: constants.defaultSecondryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.contacts_rounded),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: !visibilityRechercheBarre,
                child: Expanded(flex: 2, child: BarreRecherche())),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      sousTitre,
                      style: TextStyle(
                        color: constants.defaultSecondryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleIconButton,
                    child: Expanded(
                      flex: (isMobile) ? 4 : 2,
                      child: Visibility(
                        visible: visibleButton,
                        child: CustomButton(
                          isButtonEnabled: true,
                          myPadding: 2.0,
                          color: constants.ButtonColor,
                          text: textButton,
                          onPressed: () {},
                        ),
                      ),
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
