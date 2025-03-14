import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> recordedExpenses = [
    Expense(
      title: 'first expense',
      amount: 22.00,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'second expense',
      amount: 15.00,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  @override
  Widget build(context) {
    return Scaffold(
      body: Column(
        children: [
          Text('chart'),
          Expanded(child: ExpensesList(expenses: recordedExpenses)),
        ],
      ),
    );
  }
}
