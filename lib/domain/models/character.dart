import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../ui/core/themes/colors.dart';

class Character extends Equatable {
  const Character({
    required this.name,
    required this.status,
    required this.episodesCount,
    required this.id,
    required this.gender,
    required this.species,
    required this.imageUrl,
    required this.originName,
    required this.locationName,
  });

  final String name;
  final Status status;
  final int episodesCount;
  final int id;
  final Gender gender;
  final String species;
  final String imageUrl;
  final String originName;
  final String locationName;

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json.containsKey('name') ? json['name'] : '',
      status: json.containsKey('status')
          ? Status.fromJson(json['status'])
          : Status.unknow,
      episodesCount: json.containsKey('episode')
          ? (json['episode'] as List<dynamic>?)?.length ?? 0
          : 0,
      id: json.containsKey('id') ? json['id'] : 0,
      gender: json.containsKey('gender')
          ? Gender.fromJson(json['gender'])
          : Gender.unknown,
      species: json.containsKey('species') ? json['species'] : '',
      imageUrl: json['image'],
      originName:
          json.containsKey('origin') && json['origin'].containsKey('name')
          ? json['origin']['name']
          : '',
      locationName:
          json.containsKey('location') && json['location'].containsKey('name')
          ? json['location']['name']
          : '',
    );
  }

  @override
  List<Object?> get props => [
    name,
    status,
    episodesCount,
    id,
    gender,
    species,
    imageUrl,
    originName,
    locationName,
  ];
}

enum Status {
  alive,
  dead,
  unknow;

  String get label {
    switch (this) {
      case alive:
        return 'Vivo';
      case dead:
        return 'Morto';
      case unknow:
        return 'Desconhecido';
    }
  }

  Color get color {
    switch (this) {
      case alive:
        return RickAndMortyColors.statusAliveDark;
      case dead:
        return RickAndMortyColors.statusDeadDark;
      case unknow:
        return RickAndMortyColors.statusUnknownDark;
    }
  }

  static Status fromJson(String status) {
    final normalizedStatus = status.toLowerCase();
    switch (normalizedStatus) {
      case 'alive':
        return alive;
      case 'dead':
        return dead;
      default:
        return unknow;
    }
  }

  static String toJson(String status) {
    final normalizedStatus = status.toLowerCase();
    switch (normalizedStatus) {
      case 'vivo':
        return 'alive';
      case 'morto':
        return 'dead';
      case 'desconhecido':
        return 'unknown';
      default:
        return '';
    }
  }
}

enum Gender {
  unknown,
  female,
  male,
  genderless;

  String get label {
    switch (this) {
      case unknown:
        return 'Desconhecido';
      case female:
        return 'Feminino';
      case male:
        return 'Masculino';
      case genderless:
        return 'Sem gênero';
    }
  }

  static Gender fromJson(String gender) {
    final normalizedGender = gender.toLowerCase();
    switch (normalizedGender) {
      case 'female':
        return female;
      case 'male':
        return male;
      case 'genderless':
        return genderless;
      default:
        return unknown;
    }
  }
}
