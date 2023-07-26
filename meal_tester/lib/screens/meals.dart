import 'package:flutter/material.dart';
import 'package:meal_tester/widgets/meal_item.dart';

import '../models/meal.dart';
import 'meal_details_screen.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meal,
      required this.onToggleFavMeal});

  final String? title;

  //favourite screen me double app bar ko khatm krny k liye title ko optional kia ha String? title
  final List<Meal> meal;
  final void Function(Meal meal) onToggleFavMeal;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealDetailsScreen(meal: meal, onToggleFavMeal: onToggleFavMeal),
      ),
    );
  }

  //jahan p b hum MealsScreen constructor call kry gy to wahan humy title aur meal ki value deni pary gi

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meal.length,
      //jb MealsScreen(req this.meal:meal) bnaye gy to jo list meal ko mily gi uski lengh meal.length hogi
      // itemBuilder: (ctx, index) => Text(meal[index].title),
      itemBuilder: (ctx, index) =>
          MealItem(meal: meal[index], onSelectMeal: selectMeal),
    );
    if (meal.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh....No meals',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            SizedBox(height: 10),
            Text(
              'Try adding some meals',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }
    if (title == null) {
      return content; //agr title set hi na hoa ho title use hi na kia ho to just
      //center=uh oh ..no meals retun ho
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
