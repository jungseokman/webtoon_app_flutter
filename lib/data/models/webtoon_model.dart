import 'dart:convert';

import 'package:equatable/equatable.dart';

class WebtoonModel extends Equatable {
  final String id;
  final String title;
  final String thumb;

  const WebtoonModel({
    required this.id,
    required this.title,
    required this.thumb,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumb': thumb,
    };
  }

  WebtoonModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        title = map['title'] ?? '',
        thumb = map['thumb'] ?? '';

  String toJson() => json.encode(toMap());

  factory WebtoonModel.fromJson(String source) =>
      WebtoonModel.fromMap(json.decode(source));

  @override
  String toString() => 'WentoonModel(id: $id, title: $title, thumb: $thumb)';

  WebtoonModel copyWith({
    String? id,
    String? title,
    String? thumb,
  }) {
    return WebtoonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      thumb: thumb ?? this.thumb,
    );
  }

  @override
  List<Object> get props => [id, title, thumb];
}
