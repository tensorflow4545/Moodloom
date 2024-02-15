class Thought {
  final String text;
  final String author;

  Thought({
    required this.text,
    required this.author,
  });

  factory Thought.fromJson(Map<String, dynamic> json) {
    return Thought(
      text: json['text'] ?? '',
      author: json['author'] ?? '',
    );
  }
}

class Thoughts {
  final List<Thought>? thoughts;

  Thoughts({
    this.thoughts,
  });

  factory Thoughts.fromJson(List<dynamic> json) {
    List<Thought> thoughts = json.map((thought) {
      return Thought.fromJson(thought);
    }).toList();

    return Thoughts(
      thoughts: thoughts,
    );
  }
}
