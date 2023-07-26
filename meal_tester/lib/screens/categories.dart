import 'package:flutter/material.dart';
import 'package:meal_tester/data/dummy_data.dart';
import 'package:meal_tester/screens/meals.dart';
import 'package:meal_tester/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.onToggleFavMeal,required this.availableMeal});
  final void Function(Meal meal) onToggleFavMeal;
  final List<Meal> availableMeal;


  void _onSelectCategory(BuildContext context,Category category) {
    final filteredList=availableMeal.where((e) =>e.categories.contains(category.id)).toList();
   // dummyMeals.where((e) phly oper wali linee esy thi but end me akr change ki
    //e matlb pory dummyMeals list me ghoomna ha//
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(onToggleFavMeal: onToggleFavMeal,
          title: category.title,
          meal: filteredList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 3 / 2),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelect: () {
                _onSelectCategory(context,category);
              },
            ),
        ],
      );
  }
}
