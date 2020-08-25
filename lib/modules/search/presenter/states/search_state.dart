import 'package:movies_search/modules/search/domain/entities/movie.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';

abstract class SearchState {}

class StartState implements SearchState {
  const StartState();
}

class LoadingState implements SearchState {
  const LoadingState();
}

class ErrorState implements SearchState {
  final SearchError error;
  const ErrorState(this.error);
}

class SuccessStateListMovies implements SearchState {
  final List<Movie> list;
  const SuccessStateListMovies(this.list);
}