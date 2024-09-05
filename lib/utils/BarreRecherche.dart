import 'package:flutter/material.dart';
import 'package:espace_client/Constants.dart' as constants;

class BarreRecherche extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: constants.MyGreyColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: constants.IconEmailColor,
                ),
              ),
              onTap: () {},
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.contacts_rounded),
            onPressed: () {
              // Action lorsque l'IconButton est pressé
            },
          ),
        ),
      ],
    );
  }
}
