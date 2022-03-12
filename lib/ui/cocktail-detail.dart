import 'package:cocktails/models/cocktail.dart';
import 'package:flutter/material.dart';

class CocktailDetail extends StatelessWidget {
  final Drinks drinks;

  const CocktailDetail({Key? key, required this.drinks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Center(
                      child: Text(
                    drinks.strDrink,
                    style: const TextStyle(color: Colors.black12, fontSize: 20),
                  )),
                  Text(
                    drinks.strGlass,
                    style: const TextStyle(color: Colors.black12, fontSize: 10),
                  )
                ],
              ),
            ),
            Image(image: NetworkImage(drinks.strDrinkThumb))
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(drinks.strInstructions),
        )
      ],
    );
  }
}
