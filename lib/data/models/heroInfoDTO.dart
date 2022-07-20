import 'dart:convert';

import 'package:new_project/data/models/heroAbilities.dart';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.result,
  });

  Result result;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class Result {
  Result({
    required this.data,
    required this.status,
  });

  Data data;
  int status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: Data.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
      };
}

class Data {
  Data({
    required this.heroes,
  });

  List<DotaHero> heroes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        heroes: List<DotaHero>.from(json["heroes"].map((x) => DotaHero.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "heroes": List<dynamic>.from(heroes.map((x) => x.toJson())),
      };
}

class DotaHero {
  DotaHero({
    required this.id,
    required this.name,
    required this.orderId,
    required this.nameLoc,
    required this.bioLoc,
    required this.hypeLoc,
    required this.npeDescLoc,
    required this.strBase,
    required this.strGain,
    required this.agiBase,
    required this.agiGain,
    required this.intBase,
    required this.intGain,
    required this.primaryAttr,
    required this.complexity,
    required this.attackCapability,
    required this.roleLevels,
    required this.damageMin,
    required this.damageMax,
    required this.attackRate,
    required this.attackRange,
    required this.projectileSpeed,
    required this.armor,
    required this.magicResistance,
    required this.movementSpeed,
    required this.turnRate,
    required this.sightRangeDay,
    required this.sightRangeNight,
    required this.maxHealth,
    required this.healthRegen,
    required this.maxMana,
    required this.manaRegen,
    required this.abilities,
    required this.talents,
  });

  int id;
  String name;
  int orderId;
  String nameLoc;
  String bioLoc;
  String hypeLoc;
  String npeDescLoc;
  int strBase;
  double strGain;
  int agiBase;
  double agiGain;
  int intBase;
  double intGain;
  int primaryAttr;
  int complexity;
  int attackCapability;
  List<int> roleLevels;
  int damageMin;
  int damageMax;
  double attackRate;
  int attackRange;
  int projectileSpeed;
  double armor;
  int magicResistance;
  int movementSpeed;
  double turnRate;
  int sightRangeDay;
  int sightRangeNight;
  int maxHealth;
  double healthRegen;
  int maxMana;
  double manaRegen;
  List<Ability> abilities;
  List<Ability> talents;

  factory DotaHero.fromJson(Map<String, dynamic> json) {
    var abilit = List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x, null, false)));
    var listAllSpecialValues = <SpecialValue>[];
    for (var element in abilit) {
      listAllSpecialValues.addAll(element.specialValues);
    }
    var listAllBonuses = <Bonus>[];

    for (var element in listAllSpecialValues) {
      if (element.bonuses != null) {
        listAllBonuses.addAll(element.bonuses!);
      }
    }

    return DotaHero(
      id: json["id"],
      name: json["name"],
      orderId: json["order_id"],
      nameLoc: json["name_loc"],
      bioLoc: json["bio_loc"],
      hypeLoc: json["hype_loc"],
      npeDescLoc: json["npe_desc_loc"],
      strBase: json["str_base"],
      strGain: json["str_gain"].toDouble(),
      agiBase: json["agi_base"],
      agiGain: json["agi_gain"].toDouble(),
      intBase: json["int_base"],
      intGain: json["int_gain"].toDouble(),
      primaryAttr: json["primary_attr"],
      complexity: json["complexity"],
      attackCapability: json["attack_capability"],
      roleLevels: List<int>.from(json["role_levels"].map((x) => x)),
      damageMin: json["damage_min"],
      damageMax: json["damage_max"],
      attackRate: json["attack_rate"].toDouble(),
      attackRange: json["attack_range"],
      projectileSpeed: json["projectile_speed"],
      armor: json["armor"].toDouble(),
      magicResistance: json["magic_resistance"],
      movementSpeed: json["movement_speed"],
      turnRate: json["turn_rate"].toDouble(),
      sightRangeDay: json["sight_range_day"],
      sightRangeNight: json["sight_range_night"],
      maxHealth: json["max_health"],
      healthRegen: json["health_regen"].toDouble(),
      maxMana: json["max_mana"],
      manaRegen: json["mana_regen"].toDouble(),
      abilities: abilit,
      talents: List<Ability>.from(json["talents"].map((x) => Ability.fromJson(x, listAllBonuses,true))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order_id": orderId,
        "name_loc": nameLoc,
        "bio_loc": bioLoc,
        "hype_loc": hypeLoc,
        "npe_desc_loc": npeDescLoc,
        "str_base": strBase,
        "str_gain": strGain,
        "agi_base": agiBase,
        "agi_gain": agiGain,
        "int_base": intBase,
        "int_gain": intGain,
        "primary_attr": primaryAttr,
        "complexity": complexity,
        "attack_capability": attackCapability,
        "role_levels": List<dynamic>.from(roleLevels.map((x) => x)),
        "damage_min": damageMin,
        "damage_max": damageMax,
        "attack_rate": attackRate,
        "attack_range": attackRange,
        "projectile_speed": projectileSpeed,
        "armor": armor,
        "magic_resistance": magicResistance,
        "movement_speed": movementSpeed,
        "turn_rate": turnRate,
        "sight_range_day": sightRangeDay,
        "sight_range_night": sightRangeNight,
        "max_health": maxHealth,
        "health_regen": healthRegen,
        "max_mana": maxMana,
        "mana_regen": manaRegen,
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "talents": List<dynamic>.from(talents.map((x) => x.toJson())),
      };
}

class SpecialValue {
  SpecialValue({
    required this.name,
    required this.valuesFloat,
    required this.isPercentage,
    required this.headingLoc,
    required this.bonuses,
  });

  String name;
  List<double> valuesFloat;
  bool isPercentage;
  String headingLoc;
  List<Bonus>? bonuses;

  factory SpecialValue.fromJson(Map<String, dynamic> json) => SpecialValue(
        name: json["name"],
        valuesFloat: List<double>.from(json["values_float"].map((x) => x.toDouble())),
        isPercentage: json["is_percentage"],
        headingLoc: json["heading_loc"],
        bonuses: List<Bonus>.from(json["bonuses"].map((x) => Bonus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "values_float": List<dynamic>.from(valuesFloat.map((x) => x)),
        "is_percentage": isPercentage,
        "heading_loc": headingLoc,
        "bonuses": List.empty(), //List<dynamic>.from(bonuses?.map((x) => x.toJson()) ),
      };
}

class Bonus {
  Bonus({
    required this.name,
    required this.value,
    required this.operation,
  });

  String name;
  double value;
  int operation;

  factory Bonus.fromJson(Map<String, dynamic> json) => Bonus(
        name: json["name"],
        value: json["value"].toDouble(),
        operation: json["operation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "operation": operation,
      };
}
