part of 'cocktail_bloc.dart';



abstract class CockTailsState extends Equatable {
  const CockTailsState();

  @override
  List<Object?> get props => [];
}

class CocktailInitial extends CockTailsState {}

class CocktailsLoading extends CockTailsState {}

class CockTailsLoaded extends CockTailsState {
  final Cocktail cocktail;
  const CockTailsLoaded(this.cocktail);
}

class CocktailError extends CockTailsState {
  final String? message;
  const CocktailError(this.message);
}