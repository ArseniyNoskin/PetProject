class DotaHero {
  final int id;
  final String name;
  final String localizedName;
  final String primaryAttr;
  final String attackType;
  //final String roles;
  final int legs;

  DotaHero({
      required this.id,
      required this.name,
      required this.localizedName,
      required this.primaryAttr,
      required this.attackType,
      //required this.roles,
      required this.legs
  });

  factory DotaHero.fromJson(Map<String, dynamic> json) {
    return DotaHero(
      id: json['id'],
      name: json['name'],
      localizedName: json['localized_name'],
      primaryAttr: json['primary_attr'],
      attackType: json['attack_type'],
      //roles: json['roles'],
      legs: json['legs'],
    );
  }
}
