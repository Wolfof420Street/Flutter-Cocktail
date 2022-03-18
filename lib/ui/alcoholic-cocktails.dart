import 'package:cocktails/blocs/alcoholic-cocktails/cocktail_bloc.dart';
import 'package:cocktails/models/cocktail.dart';
import 'package:cocktails/ui/cocktail-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlcoholicCocktails extends StatefulWidget {

  const AlcoholicCocktails({Key? key}) : super(key: key);
  @override
  _AlcoholicCocktailState createState() => _AlcoholicCocktailState();
}

class _AlcoholicCocktailState extends State<AlcoholicCocktails> {

  final CocktailBloc _cocktailsBloc = CocktailBloc();

  @override
  void initState() {
    _cocktailsBloc.add(GetCocktailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        BlocProvider(
          create: (_) => _cocktailsBloc,
          child: BlocListener<CocktailBloc, CockTailsState>(
            listener: (context, state) {
              if (state is CocktailError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<CocktailBloc, CockTailsState>(
                builder: (context, state) {
                  if (state is CocktailInitial) {
                    return _buildLoading();
                  } else if (state is CocktailsLoading) {
                    return _buildLoading();
                  } else if (state is CockTailsLoaded) {
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
      ],
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildCard(BuildContext context, Cocktail model) {
    return ListView.builder(
        itemCount: model.drinks.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
      return CocktailCard(drinks: model.drinks[index]);
    });
  }

}