import 'dart:convert';

class SuggestionsResponse {
  List<Suggestion> suggestions;

  SuggestionsResponse({required this.suggestions});

  factory SuggestionsResponse.fromJson(Map<String, dynamic> json) {
    return SuggestionsResponse(
      suggestions: (json['suggestions'] as List<dynamic>)
          .map((item) => Suggestion.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'suggestions': suggestions.map((item) => item.toJson()).toList(),
    };
  }
}

class Suggestion {
  PlacePrediction placePrediction;

  Suggestion({required this.placePrediction});

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      placePrediction: PlacePrediction.fromJson(json['placePrediction']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placePrediction': placePrediction.toJson(),
    };
  }
}

class PlacePrediction {
  String place;
  String placeId;
  TextInfo text;
 // StructuredFormat structuredFormat;
 // List<String> types;

  PlacePrediction({
    required this.place,
    required this.placeId,
    required this.text,
    // required this.structuredFormat,
    // required this.types,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    return PlacePrediction(
      place: json['place'],
      placeId: json['placeId'],
      text: TextInfo.fromJson(json['text']),
      // structuredFormat: StructuredFormat.fromJson(json['structuredFormat']),
      // types: List<String>.from(json['types']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place': place,
      'placeId': placeId,
      'text': text.toJson(),
      // 'structuredFormat': structuredFormat.toJson(),
      // 'types': types,
    };
  }
}

class TextInfo {
  String text;
  List<Match> matches;

  TextInfo({required this.text, required this.matches});

  factory TextInfo.fromJson(Map<String, dynamic> json) {
    return TextInfo(
      text: json['text'],
      matches: (json['matches'] as List<dynamic>)
          .map((item) => Match.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'matches': matches.map((item) => item.toJson()).toList(),
    };
  }
}

class Match {
  int endOffset;

  Match({required this.endOffset});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      endOffset: json['endOffset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'endOffset': endOffset,
    };
  }
}

class StructuredFormat {
  MainText mainText;
  SecondaryText secondaryText;

  StructuredFormat({required this.mainText, required this.secondaryText});

  factory StructuredFormat.fromJson(Map<String, dynamic> json) {
    return StructuredFormat(
      mainText: MainText.fromJson(json['mainText']),
      secondaryText: SecondaryText.fromJson(json['secondaryText']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mainText': mainText.toJson(),
      'secondaryText': secondaryText.toJson(),
    };
  }
}

class MainText {
  String text;
  List<Match> matches;

  MainText({required this.text, required this.matches});

  factory MainText.fromJson(Map<String, dynamic> json) {
    return MainText(
      text: json['text'],
      matches: (json['matches'] as List<dynamic>)
          .map((item) => Match.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'matches': matches.map((item) => item.toJson()).toList(),
    };
  }
}

class SecondaryText {
  String text;

  SecondaryText({required this.text});

  factory SecondaryText.fromJson(Map<String, dynamic> json) {
    return SecondaryText(
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
