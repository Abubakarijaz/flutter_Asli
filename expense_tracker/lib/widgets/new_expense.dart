import 'package:flutter/material.dart';

import '../modals/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      //showDatePicker Future type sy date dy ga isliye usy pickedDate me save kr k use kia bad me
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmout = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmout == null || enteredAmout <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Plese check You have entered all the fields'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('okay'),
            ),
          ],
        ),
      );
       return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmout,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);//expense add krny k bad jb save p click kry gy to overlay khudhi close ho jae gi
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$  ',
                    label: Text("Amount"),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: Icon(Icons.calendar_month))
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  //video 20 mod 4
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/*
whenever use textediting controller also dispose them otherwise it will always remain in memory
Row k andr row ,colm k andr colm aur agr wesy hi kisi row ,col kisi b widget ka data
gaib hojaye to us widget ko Expanded me wrap kro...
    double.tryParse(_amountController.text) ,text ko double data me convert kry ga agr ho sky ga like ('1.12') hojaye ga aur ('hello') ni hoga,jo convert ni hoga to null return kry ga
    enteredAmount bilkl equal ho null k ya 0 ya smaller than 0 ho to ,amoutIsInvalid=true or false;
    .text String me convert kry ga,.trim title k start aur end sy khali space remove kry ga ,phir .isNotEmpty check kry ga k title empty to ni
        // onAddExpense widget class me ha aur ye jaga state class ki ha ,yahan p widget class ki propert access krny k liye widget keyword use hoga..

*/
