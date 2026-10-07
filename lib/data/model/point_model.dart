class PointModel {
  PointModel(this.x, this.y);
  int x;
  int y;

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }

  Map<String, dynamic> toJsonAsStrValue() {
    return {
      'x': '$x',
      'y': '$y',
    };
  }

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      json['x'] as int,
      json['y'] as int,
    );
  }
}