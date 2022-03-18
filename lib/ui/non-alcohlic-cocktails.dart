import 'package:cocktails/blocs/get-categories/get-categories-bloc.dart';
import 'package:cocktails/blocs/non-alhcoholic-cocktails/non-alcoholic-cocktail-bloc.dart';
import 'package:cocktails/models/cocktail.dart';
import 'package:cocktails/ui/cocktail-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NonAlcoholicCocktails extends StatefulWidget {

  const NonAlcoholicCocktails({Key? key}) : super(key: key);
  @override
  _NonAlcoholicCocktailState createState() => _NonAlcoholicCocktailState();
}

class _NonAlcoholicCocktailState extends State<NonAlcoholicCocktails> {

  final NonAlcoholicCocktailBloc _cocktailsBloc = NonAlcoholicCocktailBloc();

  @override
  void initState() {
    _cocktailsBloc.add(GetNonAlcoholicCocktailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        BlocProvider(
          create: (_) => _cocktailsBloc,
          child: BlocListener<NonAlcoholicCocktailBloc, NonAlcoholicCockTailsState>(
            listener: (context, state) {
              if (state is CocktailError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<NonAlcoholicCocktailBloc, NonAlcoholicCockTailsState>(
                builder: (context, state) {
                  if (state is NonAlcoholicCocktailInitial) {
                    return _buildLoading();
                  } else if (state is NonAlcoholicCocktailsLoading) {
                    return _buildLoading();
                  } else if (state is NonAlcoholicCockTailsLoaded) {
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