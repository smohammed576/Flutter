class Position {
  double? top;
  double? left;
  double? right;
  double? bottom;

  Position({
    this.top,
    this.left,
    this.right,
    this.bottom
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    top: json['top'], 
    left: json['left'],
    right: json['right'],
    bottom: json['bottom']
  );
}