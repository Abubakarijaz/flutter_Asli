import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import '../modals/expense.dart';
import 'expesnses_list/expenses_list.dart';

//=======================ui class======================
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registerExpesnes = [
    Expense(
        title: "school fee",
        amount: 200.2343,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Grocery",
        amount: 350.939,
        date: DateTime.now(),
        category: Category.food),
  ];

  void openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true, //keyboard input fields k ooper ni aye ga
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      registerExpesnes.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    //video 26 module 4
    final expenseIndex= registerExpesnes.indexOf(expense);
    setState(() {
      registerExpesnes.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted.'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: (){
            setState(() {
              registerExpesnes.insert(expenseIndex,expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //=========dont create too much logic in build ========use seperate files instead
    Widget mainContent = Center(
      child: Text('No Content here, try adding some'),
    );
    if (registerExpesnes.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: registerExpesnes, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: openAddExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses:registerExpesnes ),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
/*
column k andr list ho to output ni show hoti ,list ko Expanded me wrap kr
to issue solve hojaye ga..example Expanded(child: ExpensesList(expenses: registerExpesnes))
ctx=information object of class
builder=function pass krna ha.
arrow function => use kry to return keyword ki zrorat ni
*/
