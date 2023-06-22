import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

//=============data class==============
final uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  //This is a map ,key :value pair
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final List<Expense> expenses;
  final Category category;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
/*
//always uniq id k liye uuid flutter pakg use krna ha..
//every time get uniq string id ,.v4 is dart method,uuid is flutter pakg
apni custom types bnany k liye enum use krty he exapmple neechy..
enum Category{food,travel,leisure,work}
============intl====date formatr pakg final formatter=DateFormat.yMd();
=======getter=== get formattedDate{
    return formatter.format(date);
    call=formattedDate
  wo functions hen jinho ny just data ko aik jaga sy dosri jaga format krna hota ha.
  =====agr isi ko function bnaye to void getFormattedDate(){
  return formatter.format(date);
  }call=getFormattedDate();


*/
