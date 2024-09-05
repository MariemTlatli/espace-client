class Priorite {
  String color;
  String icon;
  int id;
  String libelle;

  Priorite({
    required this.color,
    required this.icon,
    required this.id,
    required this.libelle,
  });

  // Factory method to create an Item from a JSON map
  factory Priorite.fromJson(Map<String, dynamic> json) {
    return Priorite(
      color: json['color'],
      icon: json['icon'],
      id: json['id'],
      libelle: json['libelle'],
    );
  }

  // Method to convert an Item instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'icon': icon,
      'id': id,
      'libelle': libelle,
    };
  }
}
