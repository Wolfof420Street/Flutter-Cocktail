part of 'cocktail_detail_bloc.dart';



abstract class CockTailDetailState extends Equatable {
  const CockTailDetailState();

  @override
  List<Object?> get props => [];
}

class CocktailDetailInitial extends CockTailDetailState {}

class CocktailDetailsLoading extends CockTailDetailState {}

class CockTailDetailsLoaded extends CockTailDetailState {
  final Cocktail cocktail;
  const CockTailDetailsLoaded(this.cocktail);
}

class CocktailDetailsError extends CockTailDetailState {
  final String? message;
  const CocktailDetailsError(this.message);
}