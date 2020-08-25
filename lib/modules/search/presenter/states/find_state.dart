import 'package:movies_search/modules/search/domain/entities/movie_detail.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';

abstract class FindState {}

class FindStartState implements FindState {
  const FindStartState();
}

class FindLoadingState implements FindState {
  const FindLoadingState();
}

class FindErrorState implements FindState {
  final SearchError error;
  const FindErrorState(this.error);
}

class FindSuccessStateMovieDetails implements FindState {
  final MovieDetails movieDetails;
  const FindSuccessStateMovieDetails(this.movieDetails);
}