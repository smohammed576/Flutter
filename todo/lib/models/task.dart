class Task{
  String text;
  bool checked;

  Task({required this.text, required this.checked});

  Map<String, dynamic> toJson() => {
    'text': text,
    'checked': checked
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    text: json['text'],
    checked: json['checked']
  );
}