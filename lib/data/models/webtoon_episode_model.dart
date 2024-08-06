import 'dart:convert';

import 'package:equatable/equatable.dart';

class WebtoonEpisodeModel extends Equatable {
  final String id;
  final String title;
  final String rating;
  final String date;

  const WebtoonEpisodeModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.date,
  });

  @override
  List<Object> get props => [id, title, rating, date];

  WebtoonEpisodeModel copyWith({
    String? id,
    String? title,
    String? rating,
    String? date,
  }) {
    return WebtoonEpisodeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'rating': rating,
      'date': date,
    };
  }

  factory WebtoonEpisodeModel.fromMap(Map<String, dynamic> map) {
    return WebtoonEpisodeModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      rating: map['rating'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WebtoonEpisodeModel.fromJson(String source) =>
      WebtoonEpisodeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WebtoonEpisodeModel(id: $id, title: $title, rating: $rating, date: $date)';
  }
}
