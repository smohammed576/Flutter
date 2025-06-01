class Question {
  final String image;
  final List<String> answers;
  final String correct;

  Question({required this.image, required this.answers, required this.correct});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      image: json['foto'],
      answers: List<String>.from(json['antwoorden']),
      correct: json['goed_antwoord'],
    );
  }
}