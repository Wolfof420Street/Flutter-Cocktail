part of 'random-cocktail-bloc.dart';



abstract class RandomCockTailsState extends Equatable {
  const RandomCockTailsState();

  @override
  List<Object?> get props => [];
}

class RandomCocktailInitial extends RandomCockTailsState {}

class RandomCocktailsLoading extends RandomCockTailsState {}

class RandomCockTailsLoaded extends RandomCockTailsState {
  final Cocktail cocktail;
  const RandomCockTailsLoaded(this.cocktail);
}

class RandomCocktailError extends RandomCockTailsState {
  final String? message;
  const RandomCocktailError(this.message);
}