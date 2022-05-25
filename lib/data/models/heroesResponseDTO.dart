class HeroesResponse {
  Result? result;

  HeroesResponse({this.result});

  HeroesResponse.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  Data? data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Heroes>? heroes;

  Data({this.heroes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['heroes'] != null) {
      heroes = <Heroes>[];
      json['heroes'].forEach((v) {
        heroes!.add(Heroes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (heroes != null) {
      data['heroes'] = heroes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Heroes {
  int? id;
  String? name;
  String? nameLoc;
  String? nameEnglishLoc;
  int? primaryAttr;
  int? complexity;

  Heroes(
      {this.id,
        this.name,
        this.nameLoc,
        this.nameEnglishLoc,
        this.primaryAttr,
        this.complexity});

  Heroes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameLoc = json['name_loc'];
    nameEnglishLoc = json['name_english_loc'];
    primaryAttr = json['primary_attr'];
    complexity = json['complexity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_loc'] = nameLoc;
    data['name_english_loc'] = nameEnglishLoc;
    data['primary_attr'] = primaryAttr;
    data['complexity'] = complexity;
    return data;
  }
}