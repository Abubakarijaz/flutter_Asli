import 'package:flutter/material.dart';
import 'package:meals/main.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';

import '../widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Meal> _favouriteMeal = [];

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void toggleFavouriteMeal(Meal meal) {
    final isExisting =
        _favouriteMeal.contains(meal); //isExisting will be true or false
    if (isExisting) {
      setState(() {
        _favouriteMeal.remove(meal);
      });
      showInfoMessage('Item is no longer favourite');
    } else {
      setState(() {
        _favouriteMeal.add(meal);
      });
      showInfoMessage('Marked as favourite');
    }
  }

  int selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      selectPageIndex = index;
    });
  }

  void _onSetScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(
      onToggleFavourite: toggleFavouriteMeal,
    );
    var activePageTitle = 'Categories';
    if (selectPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeal,
        onToggleFavourite: toggleFavouriteMeal,
      );
      activePageTitle = 'Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _onSetScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.set_meal,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Add to favourite'),
        ],
      ),
    );
  }
}
