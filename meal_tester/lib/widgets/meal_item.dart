import 'package:flutter/material.dart';
import 'package:meal_tester/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal,required this.onSelectMeal});

  final Meal meal;
  final void Function(BuildContext context,Meal meal) onSelectMeal;
  //mealitem p cleck ho to mealdetailscreen ani chahye..yahan onselectMeal as a pointer pass horha
  //ha jahan jahan b mealitem constructor call hoga,jo k mealsScreen me call ho rha ha
  //mealsscreen me ja kr whan function with body bna kr onselectmeal sy connect hoga
  get complexityText{//getters always return values
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
}
  get affordabilyText{//getters always return values
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,//stack k andr image ha to bordrrdius.circular ni kam kry
      //bur clip.hardedge sy kam kry ga..
      elevation: 2,
      child: InkWell(
        // onTap: onSelect,
        onTap: (){
          onSelectMeal(context,meal);//fun value as a pointer pas krni ha yahan tap p functiion ni chalwana
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl,),
              fit: BoxFit.cover,//agr image bht zyada bara bi hoga to just box fit me aye ga
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       MealItemTrait(label:meal.duration.toString(), icon: Icons.more_time),
                       SizedBox(width: 12,),
                       MealItemTrait(label:affordabilyText, icon:Icons.attach_money),
                       SizedBox(width: 12,),
                       MealItemTrait(label: complexityText, icon: Icons.work)

                     ],
                   ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
