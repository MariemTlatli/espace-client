import 'package:flutter/material.dart';
import 'package:espace_client/Constants.dart' as constants;

class MyDropDownButton extends StatefulWidget {
  final List<String> myItems;
  final String myHint;
  final ValueChanged<String?> onChanged;
  MyDropDownButton({
    super.key,
    required this.myItems,
    required this.myHint,
    required this.onChanged,
  });

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  String? selectedValue;
  void setValues(String? newValue) {
    setState(() {
      selectedValue = newValue;
    });
    widget.onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: constants
            .defaultBackgroundColor, // Couleur de fond du bouton déroulant
        border: Border.all(
            color: constants.MyGreyColor,
            width: 1), // Bordure du bouton déroulant
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          // Ombre portée sur le bouton déroulant
          BoxShadow(
            color: constants.MyGreyColor, // Couleur de l'ombre
            blurRadius: 5, // Rayon de flou de l'ombre
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: setValues,
        underline: Container(), // Supprime soulignement
        icon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: constants.defaultPrimaryColor,
          ),
        ),
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.myHint),
        ),
        items: widget.myItems.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(valueItem),
            ),
          );
        }).toList(),
      ),
    );
  }
}
