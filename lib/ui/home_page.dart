import 'package:cocktails/ui/alcoholic-cocktails.dart';
import 'package:cocktails/ui/non-alcohlic-cocktails.dart';
import 'package:cocktails/ui/popular-cocktails.dart';
import 'package:flutter/material.dart';

import '../models/cocktail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body :  DefaultTabController(
        length: 3,
        child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.redAccent.withAlpha(0),
                      Colors.black12,
                      Colors.black45
                    ],
                  ),
                ),
                child: const RandomCocktailCard(cocktail: null,
                ),
              ),
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container();
                  }),
              Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      TabBar(tabs: [
                        Tab(text: 'Alcoholic',),
                        Tab(text : 'Non-Alcoholic'),
                        Tab(text : 'Popular'),
                    ],
                  )
                ],
              ),
              const TabBarView(children: [
                AlcoholicCocktails(drinks: []),
                NonAlcoholicCocktails(drinks: []),
                PopularCocktails(drinks: [])
              ])
              ]),
            ],
          ),
      ),
      );
  }

}

class RandomCocktailCard extends StatelessWidget {

  final Cocktail cocktail;

  const RandomCocktailCard({Key? key, required this.cocktail}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Center(child: Text(
                cocktail.drinks[0].strDrink,
                style: const TextStyle(color: Colors.black12, fontSize: 20),
              )),
              Text(
                cocktail.drinks[0].strGlass,
                style: const TextStyle(color: Colors.black12, fontSize: 10),
              )
            ],
          ),
        ),
        Image(image : NetworkImage(cocktail.drinks[0].strDrinkThumb))
      ],
    );
  }

}