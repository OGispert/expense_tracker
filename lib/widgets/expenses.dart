import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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
  final List<Expense> recordedExpenses = [];

  void openAddExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: addExpense),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      recordedExpenses.add(expense);
    });
  }

  void deleteExpense(Expense expense) {
    final expenseIndex = recordedExpenses.indexOf(expense);

    setState(() {
      recordedExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text('Expense deleted.'),
        action: SnackBarAction(
          label: "Undo deleting expense",
          onPressed: () {
            setState(() {
              recordedExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainContent = Center(
      child: Text(
        'No expenses added.',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );

    if (recordedExpenses.isNotEmpty) {
      mainContent = Column(
        children: [
          Expanded(
            child: ExpensesList(
              expenses: recordedExpenses,
              onRemoveExpense: deleteExpense,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [IconButton(onPressed: openAddExpense, icon: Icon(Icons.add))],
      ),
      body: mainContent,
    );
  }
}
