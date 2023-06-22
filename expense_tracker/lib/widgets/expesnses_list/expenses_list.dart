import 'package:flutter/material.dart';
//light and dark theme settings in video 31 sec 05

import '../../modals/expense.dart';
import 'expenses_items.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses,required this.onRemoveExpense});
  final void Function(Expense expense) onRemoveExpense;

  final List<Expense>
      expenses; //ye list expenses.dart file me bani ha final List<Expense> registerExpesnes but yahan use krny k liye pass ki jarhi ha..noted us file me aur is file me name change hen

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(color: Theme.of(context).colorScheme.error,),//color: Theme.of(context).colorScheme.error hum jo khud color scheeme set ki ha usky mutabiq milta julta color hi aye ga
        key: ValueKey(expenses[index]),
        onDismissed: (DismissDirection){//agr onDismissed na kry to value screen se remove hojaye gi but device me save rahy gi aur error aye ga
          onRemoveExpense((expenses[index]));//expenses[index] btaye ga k kis index sy list me sy data remove krna ha
        },
        child: ExpansesItem(
          expenses[index],
        ),
      ),
    );
  }
}
/*
ListView=agr koi bht lambi list display krni ho ,jiki lenght humy sure na ho to column use na kry
bulky uski jaga Listview use kryn.
ListView.builder=.builder aik constructor ha ,is me hum apni marzi ki bht sy parameter set krskty
hen like itemcount:2 etc
Dismissible(key: ValueKey(expenses[index]), child:ExpansesItem(expenses[index]) )
Dimissible kisi b widget ko swipe krny p delete krta ha,aur usy key me koi value chahye ta k pta chay kunsa widget (data) delete krna ha..
*/
