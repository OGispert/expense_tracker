import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      elevation: 5.0,
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Text(expense.title),
                Spacer(),
                Icon(Icons.alarm),
                //Text(expense.category.name),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Amount: \$${expense.amount.toStringAsFixed(2)}'),
                Spacer(),
                Text(
                  'Date: ${expense.date.month}/${expense.date.day}/${expense.date.year}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
