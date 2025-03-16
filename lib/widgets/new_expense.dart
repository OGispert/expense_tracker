import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.entertainment;

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void saveExpenseData() async {
    final amount = double.tryParse(amountController.text);
    final isInvalidAmount = amount == null || amount <= 0;

    if (nameController.text.trim().isEmpty ||
        isInvalidAmount ||
        selectedDate == null) {
      await showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog.adaptive(
              title: Text('Invalid input'),
              content: Text('Please make sure all fields are complete.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Ok'),
                ),
              ],
            ),
      );
      return;
    }

    final expense = Expense(
      title: nameController.text,
      amount: amount,
      date: selectedDate ?? DateTime.now(),
      category: selectedCategory,
    );
    widget.onAddExpense(expense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Add a new expense',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          TextField(
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            controller: nameController,
            maxLength: 25,
            decoration: InputDecoration(label: Text('Expense name')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    prefixText: '\$',
                    label: Text('Expense amount'),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: presentDatePicker,
                      label: Text(
                        selectedDate == null
                            ? 'Select a date'
                            : formatter.format(selectedDate ?? DateTime.now()),
                      ),
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Text('Select a category:'),
              SizedBox(width: 16),
              DropdownButton(
                value: selectedCategory,
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value ?? Category.entertainment;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: saveExpenseData,
                child: Text('Save expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
