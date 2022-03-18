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
          Navigator.of(context).push(_createRoute());
        },
        leading: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(drinks.strDrinkThumb ?? ''))),
        ),
        title: Column(
          children: [
            Text(drinks.strDrink,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CocktailDetail(
        drinks: drinks,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
