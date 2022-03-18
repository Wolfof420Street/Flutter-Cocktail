part of  'random-cocktail-bloc.dart';

abstract class RandomCocktailEvent extends Equatable {
  const RandomCocktailEvent();

  @override
  List<Object> get props => [];
}

class GetRandomCocktailEvent extends RandomCocktailEvent {}