import 'package:cocktails/models/cocktail.dart';
import 'package:cocktails/ui/cocktail-detail.dart';
import 'package:flutter/material.dart';

class CocktailCard extends StatelessWidget {

  final Drinks drinks;

  const CocktailCard({Key? key, required this.drinks}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CocktailDetail(
              drinks: drinks,
            )));
          },
          leading: Container(height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image : NetworkImage(drinks.strDrinkThumb ?? ''))
            ),
          ),
          title: Column(
            children: [
              Text(drinks.strDrink, style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
              )),
            ],
          ),
        ),

    );

  }

}