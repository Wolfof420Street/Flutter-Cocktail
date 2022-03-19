import 'package:cocktails/blocs/cocktail-detail/cocktail_detail_bloc.dart';
import 'package:cocktails/models/cocktail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CocktailDetail extends StatefulWidget {
  final Drinks? drinks;

  const CocktailDetail({Key? key, this.drinks}) : super(key: key);

  @override
  State<CocktailDetail> createState() => _CocktailDetailState();
}

class _CocktailDetailState extends State<CocktailDetail> {
  late final CocktailDetailBloc _cocktailsBloc =
      CocktailDetailBloc(widget.drinks!.idDrink);

  var top = 220;

  @override
  void initState() {
    _cocktailsBloc.add(GetCocktailDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  return Expanded(child: _buildCard(context, state.cocktail));
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
    return Scaffold(
      body: NestedScrollView(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          drinks.strDrink,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                              letterSpacing: 5,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lobster'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  _cocktailItem("Glass", drinks.strGlass ?? ''),
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _cocktailItem(
                                  "Category", drinks.strCategory ?? ''),
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _cocktailItem(
                                  "Alcoholic", drinks.strAlcoholic ?? ''),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Ingredients : ',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _ingredientItem(drinks.strIngredient1 ?? ''),
                            _ingredientItem(drinks.strIngredient2 ?? ''),
                            _ingredientItem(drinks.strIngredient3 ?? ''),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Instructions : ',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              drinks.strInstructions ?? '',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _headerSection(drinks.strDrinkThumb, drinks.strDrink)
          ];
        },
      ),
    );
  }

  Widget _cocktailItem(String title, String content) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFF20124D),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(content,
                style: const TextStyle(
                  color: Colors.amber,
                  decoration: TextDecoration.none,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                )),
          )
        ],
      ),
    );
  }

  Widget _ingredientItem(String text) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://thecocktaildb.com/images/ingredients/$text.png')),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    overflow: TextOverflow.clip,
                    decorationStyle: TextDecorationStyle.wavy),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerSection(String? url, String name) {
    return SliverAppBar(
        backgroundColor: const Color(0xFF20124D),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        expandedHeight: 220.0,
        floating: false,
        pinned: true,
        flexibleSpace: LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints) {
          return FlexibleSpaceBar(
              centerTitle: true,
              title: const AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 300),
              ),
              background: top > 200
                  ? Stack(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white)),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.all(15),
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(url ?? ''),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    )
                  : Text(
                      name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ));
        }));
  }
}
