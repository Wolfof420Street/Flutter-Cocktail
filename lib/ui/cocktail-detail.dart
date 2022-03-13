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
      color: Colors.blue,
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
            child: Text(
              drinks.strDrink,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )),
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(drinks.strDrinkThumb ?? ''),
                  fit: BoxFit.cover
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            drinks.strGlass ?? '',
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            drinks.strInstructions ?? '',
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}


