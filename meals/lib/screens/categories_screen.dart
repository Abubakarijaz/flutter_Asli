import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meals.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key,required this.onToggleFavourite});
  final void Function(Meal meal) onToggleFavourite;


  void _selectCategory(BuildContext context,Category category) {
    final filteredMeals=dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals,
        onToggleFavourite: onToggleFavourite,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          /*
          for (final category in availableCategories)
            CategoryGridItem(category: category,),is ki jaga esy b kr skty hen
            availableCategories.map((category)=>CategoryGridItem(category:category)).tolist()

          */
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onselectCategory: (){
                _selectCategory(context,category);
              },
            ),
        ],
      );
  }
}
/*
Navigator.push & Navigator.of(context).push are same..
agr statless widget me navigator.push use krna ha to wahan context avlb ni hota isliye
(buildContext context) use krna parta ha.
.................
kyu k fun def me void _selectedCategory (BuildContext context){} context ha isliye fun calling me b context aye ga
_selectCategory(context);
*/
