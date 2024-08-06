import 'dart:convert';

import 'package:equatable/equatable.dart';

class WebtoonDetailModel extends Equatable {
  final String title;
  final String about;
  final String genre;
  final String age;

  const WebtoonDetailModel({
    required this.title,
    required this.about,
    required this.genre,
    required this.age,
  });

  @override
  List<Object> get props => [title, about, genre, age];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'about': about,
      'genre': genre,
      'age': age,
    };
  }

  factory WebtoonDetailModel.fromMap(Map<String, dynamic> map) {
    return WebtoonDetailModel(
      title: map['title'] ?? '',
      about: map['about'] ?? '',
      genre: map['genre'] ?? '',
      age: map['age'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WebtoonDetailModel.fromJson(String source) =>
      WebtoonDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WebtoonDetailModel(title: $title, about: $about, genre: $genre, age: $age)';
  }

  WebtoonDetailModel copyWith({
    String? title,
    String? about,
    String? genre,
    String? age,
  }) {
    return WebtoonDetailModel(
      title: title ?? this.title,
      about: about ?? this.about,
      genre: genre ?? this.genre,
      age: age ?? this.age,
    );
  }
}
