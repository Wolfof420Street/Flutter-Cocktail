import 'package:cocktails/blocs/cocktail_bloc.dart';
import 'package:cocktails/blocs/random-cocktail-bloc.dart';
import 'package:cocktails/ui/alcoholic-cocktails.dart';
import 'package:cocktails/ui/cocktail-detail.dart';
import 'package:cocktails/ui/non-alcohlic-cocktails.dart';
import 'package:cocktails/ui/popular-cocktails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cocktail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final RandomCocktailBloc _cocktailsBloc = RandomCocktailBloc();

  @override
  void initState() {
    _cocktailsBloc.add(GetRandomCocktailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;

    int _selectedIndex = 0;

    return Scaffold(
      body:
              Column(
                children: [
                  Expanded(
                    child: BlocProvider(
                        create: (_) => _cocktailsBloc,
                        child: BlocListener<RandomCocktailBloc, RandomCockTailsState>(
                          listener: (context, state) {
                            if (state is RandomCocktailError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message!),
                                ),
                              );
                            }
                          },
                          child: BlocBuilder<RandomCocktailBloc, RandomCockTailsState>(
                              builder: (context, state) {
                                if (state is RandomCocktailInitial) {
                                  return _buildLoading();
                                } else if (state is RandomCocktailsLoading) {
                                  return _buildLoading();
                                } else if (state is RandomCockTailsLoaded) {
                                  return Expanded(
                                      child: _buildCard(context, state.cocktail));
                                } else if (state is CocktailError) {
                                  return Container();
                                } else {
                                  return Container();
                                }
                              }),
                        ),
                      ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                      SizedBox(
                        width: 69,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: NavigationRail(
                        groupAlignment: 0.0,
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: (int index) {
                          setState(() {
                            _selectedIndex = index;
                            if (kDebugMode) {
                              print('selected index : ' + index.toString());
                            }
                          });
                        },
                        labelType: NavigationRailLabelType.all,
                        destinations: const <NavigationRailDestination>[
                          NavigationRailDestination(
                            icon: SizedBox.shrink(),
                            label: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: Text("Alcoholic"),
                              ),
                            ),
                          ),
                          NavigationRailDestination(
                            icon: SizedBox.shrink(),
                            label: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: Text("Non-Alcoholic"),
                              ),
                            ),
                          ),
                          NavigationRailDestination(
                            icon: SizedBox.shrink(),
                            label: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: Text("Popular"),
                              ),
                            ),
                          ),
                          ]),
                      ),
                        const VerticalDivider(thickness: 1, width: 1),
                        _selectedIndex == 0 ? const Expanded(child: AlcoholicCocktails())
                                : _selectedIndex == 1 ? const Expanded(child: NonAlcoholicCocktails()) :
                            const Expanded(child: PopularCocktails()),
                      ],
                    ),
                  ),
                ],
              )
    );
  }
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildCard(BuildContext context, Cocktail model) {
    return RandomCocktailCard(cocktail: model);
  }


}

class RandomCocktailCard extends StatelessWidget {
  final Cocktail cocktail;

  const RandomCocktailCard({Key? key, required this.cocktail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CocktailDetail(
          drinks: cocktail.drinks[0],
        )));
      },
      child: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
              image: DecorationImage(image: NetworkImage(cocktail.drinks[0].strDrinkThumb ?? ''),
                fit: BoxFit.cover
              )
            ),
            alignment: Alignment.center,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
                  cocktail.drinks[0].strDrink,
                  style: const TextStyle(color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold),
                ),
          ),
        ],
      ),
    );
  }
}
