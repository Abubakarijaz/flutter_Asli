import 'package:flutter/material.dart';
import 'package:meal_tester/screens/tabs.dart';
import 'package:meal_tester/widgets/main_drawer.dart';
enum Filters{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegen,

}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key,required this.currentFilter});
  final Map<Filters,bool> currentFilter;
//jo filers select kiye hen agr hum screen change kr k wapis b aye unko save rakhny k liye
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilteSet=false;
  bool _vegetarianFilterSet=false;
  bool _vegenFilterSet=false;
  @override
  void initState() {
    super.initState();
    //jo filers select kiye hen agr hum screen change kr k wapis b aye unko save rakhny k liye
    //widget. sy state class me widget class ki property access krskty hen

    _glutenFreeFilterSet=widget.currentFilter[Filters.glutenFree]!;
    _lactoseFreeFilteSet=widget.currentFilter[Filters.lactoseFree]!;
    _vegetarianFilterSet=widget.currentFilter[Filters.vegetarian]!;
    _vegenFilterSet=widget.currentFilter[Filters.vegen]!;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSetScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (ctx) => TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      //onSetScreen ko fun chahyee tha lakin hum ny idhr hi fun call krdia ,is file me fun bnanye ki bjaye
      body: WillPopScope(
        onWillPop: ()async{//async bcz onwillscope wants a future fun
          Navigator.of(context).pop({
            Filters.glutenFree:_glutenFreeFilterSet,
            Filters.lactoseFree:_lactoseFreeFilteSet,
            Filters.vegetarian:_vegenFilterSet,
            Filters.vegen:_vegenFilterSet,
            //jintny b filters set ho gy hum uski value pass krna chahty hen ta k unhy use kr k user ko meal show hun
            //willpopscope sy jb hum screen sy pop kry gy to .pop k map ky andr ki sari value us screen p jaye
            //gi jahan hum ny pop kia ...is waqt hum pop kr k tabScreen p jaye gy jahan filterScreen call horha

          });
          return false;//false mtlb leave screen ni krni,bcz ooper navigator.pop me hum phly hi leave kr chuky,isliye double leave ni krni
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                  //switch ko on/off kry gy to uski value true or false hogi isChecked k
                  //zarye fun ko pass hogi,flutter btay ga fun ko
                });
              },
              title: Text(
                'Gluten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only includes gluten free meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeFilteSet,
              onChanged: (isChecked) {
                setState(() {
                 _lactoseFreeFilteSet = isChecked;
                  //switch ko on/off kry gy to uski value true or false hogi isChecked k
                  //zarye fun ko pass hogi,flutter btay ga fun ko
                });
              },
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only includes Lactose free meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet= isChecked;
                  //switch ko on/off kry gy to uski value true or false hogi isChecked k
                  //zarye fun ko pass hogi,flutter btay ga fun ko
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only includes Vegetarian meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegenFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegenFilterSet = isChecked;
                  //switch ko on/off kry gy to uski value true or false hogi isChecked k
                  //zarye fun ko pass hogi,flutter btay ga fun ko
                });
              },
              title: Text(
                'Vegen',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only includes Vegen meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
