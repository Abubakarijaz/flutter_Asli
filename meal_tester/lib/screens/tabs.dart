import 'package:flutter/material.dart';
import 'package:meal_tester/data/dummy_data.dart';
import 'package:meal_tester/screens/categories.dart';
import 'package:meal_tester/screens/filters_screen.dart';
import 'package:meal_tester/screens/meals.dart';
import 'package:meal_tester/widgets/main_drawer.dart';

import '../models/meal.dart';

var kinitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegen: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favouritMeals = [];

  Map<Filters, bool> selectedFilters = kinitialFilters;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void toggleFavMeal(Meal meal) {
    final isExistMeal = _favouritMeals.contains(meal);
    if (isExistMeal) {
      setState(
        () {
          _favouritMeals.remove(meal);
          showSnackBar('Marked as Favourite');
        },
      );
    } else {
      setState(
        () {
          _favouritMeals.add(meal);
          showSnackBar('No Longer Favourite');
        },
      );
    }
  }

  int _selectedPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void setScreen(String identifier) async {
    Navigator.of(context)
        .pop(); //bcz jb filter screen me appbar me back arrow sy wapis ja rhy thy do drawer open mil raha tha ,istrah close mily ga
    /*filterScreen sy jo filter set kiye hen,jb user backbutton press kry ga 10 sec,10 min bad(future value) to data
    yahan transfer hoga ,jo hum ny enum values me store kia tha..isliye is fun ko ab async use krna pary ga
    await Navigator.of(context).push<Map<Filters,bool>> yahan hum bta rahy hen k jo values filterscreen sy return hungi wo Map hoga aur uski keys Filers(enum),and values bool type hn gi
    */
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilter: selectedFilters,),
        ),
      );
      setState(() {
        selectedFilters = result ??
            kinitialFilters; //agr result null ho to kinitialfilter ki values dikaho warna onselectedfilter ki value wo set kro jo humy future mtlb filterscren sy mily hen
        //filters set krny k bad jb hum tabScreen me jaye to unhi filters k mutabiq Categories k andr meals show ho.
      });
    }
    //identifier==meals,to drawer bnd kro bcz hum is wat meals/tab screen p hen
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((e) {
      //e ,dummyMeals ki pory list items me ghoomy ga..
      //selectedFilter[Filters.glutenFree] true or false aye ga (!cant b nul) and !e.isGlutenFree(not operator) ,dummyMeals sy ye meal exclude krdy ga.
      if (selectedFilters[Filters.glutenFree]! && !e.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filters.lactoseFree]! && !e.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filters.vegetarian]! && !e.isVegetarian) {
        return false;
      }
      if (selectedFilters[Filters.vegen]! && !e.isVegan) {
        return false;
      }
      //ab availbleMeals list ko Categories screen ko pass krna ta k us ky mutabiq meals selected show ho
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      availableMeal: availableMeals,
      onToggleFavMeal: toggleFavMeal,
    );
    String activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          onToggleFavMeal: toggleFavMeal,
          meal:
              _favouritMeals); //filhal favourite=MealsScreen ha and favourit screen me
      //double app bar a rhi thi isliye yahan title set ni kia ta k appbar aik bar hi aye
      activePageTitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSetScreen: setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: selectPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          //index 0
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favourites')
          //index 1
        ],
      ),
    );
  }
}
