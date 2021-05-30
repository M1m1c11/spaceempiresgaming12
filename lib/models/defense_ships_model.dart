import 'package:flutter/material.dart';

enum DefenseShipType {
  Artillery,
  Battleship,
  Rover,
}

class DefenseShip {
  final DefenseShipType type;
  final String description;
  final int cost;
  final int maintainance;
  final int damage;
  final int health;

  const DefenseShip(
      {@required this.cost,
      @required this.description,
      @required this.type,
      @required this.maintainance,
      @required this.damage,
      @required this.health});
}

const Map<DefenseShipType, DefenseShip> kDefenseShipsData = const {
  DefenseShipType.Artillery: const DefenseShip(
      cost: 3000,
      description: 'Boom Boom everything',
      type: DefenseShipType.Artillery,
      maintainance: 40,
      health: 1200,
      damage: 200),
  DefenseShipType.Battleship: const DefenseShip(
      cost: 2500,
      description: 'The workhorse',
      type: DefenseShipType.Battleship,
      maintainance: 30,
      health: 2500,
      damage: 120),
  DefenseShipType.Rover: const DefenseShip(
      cost: 1000,
      description: 'It aint much..but its good',
      type: DefenseShipType.Rover,
      maintainance: 10,
      health: 500,
      damage: 100),
};