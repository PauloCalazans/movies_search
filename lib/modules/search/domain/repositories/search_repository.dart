import 'package:dartz/dartz.dart';
import 'package:movies_search/modules/search/domain/entities/movie.dart';
import 'package:movies_search/modules/search/domain/entities/movie_detail.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';

abstract class SearchRepository {
  Future<Either<SearchError, List<Movie>>> searchTitle(String titleSearch, int page);

  Future<Either<SearchError, MovieDetails>> searchDetails(String imdbID);
}