import 'package:cocktails/blocs/cocktail_detail_bloc.dart';
import 'package:cocktails/models/cocktail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CocktailDetail extends StatefulWidget {

  final Drinks? drinks;

  const CocktailDetail({Key? key,  this.drinks}) : super(key: key);

  @override
  State<CocktailDetail> createState() => _CocktailDetailState();
}

class _CocktailDetailState extends State<CocktailDetail> {

  late final CocktailDetailBloc _cocktailsBloc = CocktailDetailBloc(widget.drinks!.idDrink);

  @override
  void initState() {
    _cocktailsBloc.add(GetCocktailDetailEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {



    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
            children: [
              BlocProvider(
                create: (_) => _cocktailsBloc,
                child: BlocListener<CocktailDetailBloc, CockTailDetailState>(
                  listener: (context, state) {
                    if (state is CocktailDetailsError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message!),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<CocktailDetailBloc, CockTailDetailState>(
                      builder: (context, state) {
                        if (state is CocktailDetailInitial) {
                          return _buildLoading();
                        } else if (state is CocktailDetailsLoading) {
                          return _buildLoading();
                        } else if (state is CockTailDetailsLoaded) {
                          return Expanded(
                              child: _buildCard(context, state.cocktail));
                        } else if (state is CocktailDetailsError) {
                          return Container();
                        } else {
                          return Container();
                        }
                      }),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildCard(BuildContext context, Cocktail model) {
    return _cocktailDetailPage(model.drinks[0]);
  }

  Widget _cocktailDetailPage(Drinks drinks) {

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top : 10.0),
              child: Center(
                  child: Text(
                    drinks.strDrink,
                    style: const TextStyle(color: Colors.blue, fontSize: 20, fontFamily: 'Gothic', fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(drinks.strDrinkThumb ?? ''),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                   'Glass : ',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Gothic'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    drinks.strGlass ?? '',
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.redAccent, fontSize: 20, fontFamily: 'Gothic'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Ingredients : ',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.blue,
                      fontSize: 20,
                      fontFamily: 'Gothic',
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const MyBullet(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          drinks.strIngredient1 ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Gothic',
                            color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const MyBullet(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          drinks.strIngredient2 ?? '',
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Gothic',
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const MyBullet(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          drinks.strIngredient3 ?? '',
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Gothic',
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Instructions : ',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.blue,
                    fontSize: 20,
                    fontFamily: 'Gothic',
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  drinks.strInstructions ?? '',
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Gothic',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBullet extends StatelessWidget{
  const MyBullet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 15.0,
      width: 15.0,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}



