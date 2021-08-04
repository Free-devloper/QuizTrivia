import 'dart:convert';

QuizHelper quizHelperFromJson(String str) =>
    QuizHelper.fromJson(json.decode(str));

String quizHelperToJson(QuizHelper data) => json.encode(data.toJson());

class QuizHelper {
  QuizHelper({
    this.responseCode,
    this.results,
  });

  int? responseCode;
  List<Result>? results;

  factory QuizHelper.fromJson(Map<String, dynamic> json) => QuizHelper(
        responseCode: json["response_code"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  Category? category;
  Type? type;
  Difficulty? difficulty;
  var question;
  var correctAnswer;
  List<String>? incorrectAnswers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: categoryValues.map[json["category"]],
        type: typeValues.map[json["type"]],
        difficulty: difficultyValues.map[json["difficulty"]],
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers:
            List<String>.from(json["incorrect_answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": categoryValues.reverse[category],
        "type": typeValues.reverse[type],
        "difficulty": difficultyValues.reverse[difficulty],
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers":
            List<dynamic>.from(incorrectAnswers!.map((x) => x)),
      };
}

enum Category { SCIENCE_COMPUTERS }

final categoryValues =
    EnumValues({"Science: Computers": Category.SCIENCE_COMPUTERS});

enum Difficulty { MEDIUM, EASY, HARD }

final difficultyValues = EnumValues({
  "easy": Difficulty.EASY,
  "hard": Difficulty.HARD,
  "medium": Difficulty.MEDIUM
});

enum Type { MULTIPLE }

final typeValues = EnumValues({"multiple": Type.MULTIPLE});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
