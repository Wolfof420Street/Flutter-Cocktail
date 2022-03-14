part of 'cocktail_detail_bloc.dart';

abstract class CocktailDetailEvent extends Equatable {
  const CocktailDetailEvent();

  @override
  List<Object> get props => [];
}

class GetCocktailDetailEvent extends CocktailDetailEvent {}