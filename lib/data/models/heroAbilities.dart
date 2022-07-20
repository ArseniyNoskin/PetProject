import 'package:new_project/data/models/heroInfoDTO.dart';
import 'package:collection/collection.dart';


class Ability {
  Ability({
    required this.id,
    required this.name,
    required this.nameLoc,
    required this.descLoc,
    required this.loreLoc,
    required this.notesLoc,
    required this.shardLoc,
    required this.scepterLoc,
    required this.type,
    required this.behavior,
    required this.targetTeam,
    required this.targetType,
    required this.flags,
    required this.damage,
    required this.immunity,
    required this.dispellable,
    required this.maxLevel,
    required this.castRanges,
    required this.castPoints,
    required this.channelTimes,
    required this.cooldowns,
    required this.durations,
    required this.damages,
    required this.manaCosts,
    required this.goldCosts,
    required this.specialValues,
    required this.isItem,
    required this.abilityHasScepter,
    required this.abilityHasShard,
    required this.abilityIsGrantedByScepter,
    required this.abilityIsGrantedByShard,
    required this.itemCost,
    required this.itemInitialCharges,
    required this.itemNeutralTier,
    required this.itemStockMax,
    required this.itemStockTime,
    required this.itemQuality,
  });

  int id;
  String name;
  String nameLoc;
  String descLoc;
  String loreLoc;
  List<String> notesLoc;
  String shardLoc;
  String scepterLoc;
  TypeAbility type;
  String behavior;
  int targetTeam;
  int targetType;
  int flags;
  int damage;
  int immunity;
  int dispellable;
  int maxLevel;
  List<int> castRanges;
  List<double> castPoints;
  List<double> channelTimes;
  List<double> cooldowns;
  List<double> durations;
  List<int> damages;
  List<int> manaCosts;
  List<dynamic> goldCosts;
  List<SpecialValue> specialValues;
  bool isItem;
  bool abilityHasScepter;
  bool abilityHasShard;
  bool abilityIsGrantedByScepter;
  bool abilityIsGrantedByShard;
  int itemCost;
  int itemInitialCharges;
  int itemNeutralTier;
  int itemStockMax;
  int itemStockTime;
  int itemQuality;

  factory Ability.fromJson(Map<String, dynamic> json, List<Bonus>? listAllBonus, bool isTalant) {
    var typeAbility = TypeAbility.unNamed;
    var dtoType = json["type"];
    switch (dtoType) {
      case 1:
        typeAbility = TypeAbility.PAsive;
        break;
      case 2:
        typeAbility = TypeAbility.Phisic;
        break;
      case 3:
        typeAbility = TypeAbility.Magic;
        break;
      case 4:
        typeAbility = TypeAbility.Type4;
        break;

      case 5:
        typeAbility = TypeAbility.Type5;
        break;

      case 6:
        typeAbility = TypeAbility.Type6;
        break;
    }

    //Map real Name Loc
    var gsonNameLoc = json["name_loc"];
    var fotmatedNameLoc = gsonNameLoc;

    if(isTalant){
      var specialValues = List<SpecialValue>.from(json["special_values"].map((x) => SpecialValue.fromJson(x)));
      var valueParam = specialValues.firstWhereOrNull((element) => element.name == "value");
      var nameLoc = json["name"];
      var fBonus = listAllBonus?.firstWhereOrNull((element) => element.name == nameLoc);

      fotmatedNameLoc = getNameLoc(gsonNameLoc, valueParam, fBonus);
    }

    return Ability(
      id: json["id"],
      name: json["name"],
      nameLoc: fotmatedNameLoc,
      //json["name_loc"],
      descLoc: json["desc_loc"],
      loreLoc: json["lore_loc"],
      notesLoc: List<String>.from(json["notes_loc"].map((x) => x)),
      shardLoc: json["shard_loc"],
      scepterLoc: json["scepter_loc"],
      type: typeAbility,
      behavior: json["behavior"],
      targetTeam: json["target_team"],
      targetType: json["target_type"],
      flags: json["flags"],
      damage: json["damage"],
      immunity: json["immunity"],
      dispellable: json["dispellable"],
      maxLevel: json["max_level"],
      castRanges: List<int>.from(json["cast_ranges"].map((x) => x)),
      castPoints: List<double>.from(json["cast_points"].map((x) => x.toDouble())),
      channelTimes: List<double>.from(json["channel_times"].map((x) => x.toDouble())),
      cooldowns: List<double>.from(json["cooldowns"].map((x) => x.toDouble())),
      durations: List<double>.from(json["durations"].map((x) => x.toDouble())),
      damages: List<int>.from(json["damages"].map((x) => x)),
      manaCosts: List<int>.from(json["mana_costs"].map((x) => x)),
      goldCosts: List<dynamic>.from(json["gold_costs"].map((x) => x)),
      specialValues: List<SpecialValue>.from(json["special_values"].map((x) => SpecialValue.fromJson(x))),
      isItem: json["is_item"],
      abilityHasScepter: json["ability_has_scepter"],
      abilityHasShard: json["ability_has_shard"],
      abilityIsGrantedByScepter: json["ability_is_granted_by_scepter"],
      abilityIsGrantedByShard: json["ability_is_granted_by_shard"],
      itemCost: json["item_cost"],
      itemInitialCharges: json["item_initial_charges"],
      itemNeutralTier: json["item_neutral_tier"],
      itemStockMax: json["item_stock_max"],
      itemStockTime: json["item_stock_time"],
      itemQuality: json["item_quality"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_loc": nameLoc,
        "desc_loc": descLoc,
        "lore_loc": loreLoc,
        "notes_loc": List<dynamic>.from(notesLoc.map((x) => x)),
        "shard_loc": shardLoc,
        "scepter_loc": scepterLoc,
        "type": type,
        "behavior": behavior,
        "target_team": targetTeam,
        "target_type": targetType,
        "flags": flags,
        "damage": damage,
        "immunity": immunity,
        "dispellable": dispellable,
        "max_level": maxLevel,
        "cast_ranges": List<dynamic>.from(castRanges.map((x) => x)),
        "cast_points": List<dynamic>.from(castPoints.map((x) => x)),
        "channel_times": List<dynamic>.from(channelTimes.map((x) => x)),
        "cooldowns": List<dynamic>.from(cooldowns.map((x) => x)),
        "durations": List<dynamic>.from(durations.map((x) => x)),
        "damages": List<dynamic>.from(damages.map((x) => x)),
        "mana_costs": List<dynamic>.from(manaCosts.map((x) => x)),
        "gold_costs": List<dynamic>.from(goldCosts.map((x) => x)),
        "special_values": List<dynamic>.from(specialValues.map((x) => x.toJson())),
        "is_item": isItem,
        "ability_has_scepter": abilityHasScepter,
        "ability_has_shard": abilityHasShard,
        "ability_is_granted_by_scepter": abilityIsGrantedByScepter,
        "ability_is_granted_by_shard": abilityIsGrantedByShard,
        "item_cost": itemCost,
        "item_initial_charges": itemInitialCharges,
        "item_neutral_tier": itemNeutralTier,
        "item_stock_max": itemStockMax,
        "item_stock_time": itemStockTime,
        "item_quality": itemQuality,
      };
}

/// Generate loc name from dif param
String getNameLoc(String gsonNameLoc, SpecialValue? valueParam, Bonus? foundBonus) {
  var posStart = gsonNameLoc.indexOf('{');
  var posEnd = gsonNameLoc.indexOf('}');
  var posSecondStart = gsonNameLoc.lastIndexOf('{');
  var posSecondEnd = gsonNameLoc.lastIndexOf('}');
  var neededText = 'Not found';
  var neededSecondText = 'Not found';
  if (posStart == -1) {return gsonNameLoc;}

  if (valueParam?.valuesFloat.isNotEmpty ?? false) {
    neededText = valueParam!.valuesFloat[0].toString();
  } else {
    if (foundBonus?.value != null) {
      neededText = foundBonus!.value.toString();
    }
  }
  var d = double.parse(neededText).toStringAsFixed(2);
  var dd = double.parse(d);
  var myText = doubleWithoutDecimalToInt(dd);
  //myText = doubleWithoutDecimalToInt(myText);
  neededText = myText.toString();
  return gsonNameLoc.replaceRange(posStart, posEnd+1, neededText);
}

enum TypeAbility { unNamed, PAsive, Phisic, Magic, Type4, Type5, Type6 }


num doubleWithoutDecimalToInt(double val) {
  return val % 1 == 0 ? val.toInt() : val;
}