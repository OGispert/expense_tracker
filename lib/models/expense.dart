import "package:flutter/material.dart";
import "package:uuid/uuid.dart";

final uuid = Uuid();

enum Category { travel, leisure, food, work }

const categoryIcon = {
  Category.travel: Icons.flight_takeoff,
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.theater_comedy,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return '';
  }
}
