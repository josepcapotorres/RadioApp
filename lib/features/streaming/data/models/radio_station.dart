import 'dart:convert';

class RadioStations {
  String name;
  String url;
  String urlResolved;
  String homepage;
  String favicon;
  String tags;
  String state;
  String language;
  String languagecodes;
  int votes;
  Codec codec;
  int clickcount;
  int clicktrend;
  bool favorite;

  RadioStations({
    required this.name,
    required this.url,
    required this.urlResolved,
    required this.homepage,
    required this.favicon,
    required this.tags,
    required this.state,
    required this.language,
    required this.languagecodes,
    required this.votes,
    required this.codec,
    required this.clickcount,
    required this.clicktrend,
    required this.hasExtendedInfo,
    this.favorite = false,
  });

  bool hasExtendedInfo;

  factory RadioStations.fromRawJson(String str) =>
      RadioStations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RadioStations.fromJson(Map<String, dynamic> json) => RadioStations(
        name: json["name"],
        url: json["url"],
        urlResolved: json["url_resolved"],
        homepage: json["homepage"],
        favicon: json["favicon"],
        tags: json["tags"],
        state: json["state"],
        language: json["language"],
        languagecodes: json["languagecodes"],
        votes: json["votes"],
        codec: codecValues.map[json["codec"]]!,
        clickcount: json["clickcount"],
        clicktrend: json["clicktrend"],
        hasExtendedInfo: json["has_extended_info"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "url_resolved": urlResolved,
        "homepage": homepage,
        "favicon": favicon,
        "tags": tags,
        "state": state,
        "language": language,
        "languagecodes": languagecodes,
        "votes": votes,
        "codec": codecValues.reverse[codec],
        "clickcount": clickcount,
        "clicktrend": clicktrend,
        "has_extended_info": hasExtendedInfo,
      };
}

enum Codec { AAC, AAC_H_264, CODEC_AAC, EMPTY, MP3, OGG, UNKNOWN }

final codecValues = EnumValues({
  "AAC+": Codec.AAC,
  "AAC,H.264": Codec.AAC_H_264,
  "AAC": Codec.CODEC_AAC,
  "": Codec.EMPTY,
  "MP3": Codec.MP3,
  "OGG": Codec.OGG,
  "UNKNOWN": Codec.UNKNOWN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
