import 'package:flutter/material.dart';
import '../../modals/expense.dart';
class ExpansesItem extends StatelessWidget {
  const ExpansesItem(this.expense,{super.key});
  final Expense expense;//Expense class as a data type use hoi aur uska object expense bnaya

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,style: Theme.of(context).textTheme.titleLarge),//agr texttheme  set ki hoi ha to phir kisi jaga style ko overwrite krna ho to esy kryn gy..
            SizedBox(height: 4,),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                Spacer(),//spacer() used between rows which are inside rows to create fasla between them
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(width: 10,),
                    Text(expense.formattedDate),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
