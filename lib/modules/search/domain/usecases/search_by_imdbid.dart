import 'package:dartz/dartz.dart';
import 'package:movies_search/modules/search/domain/entities/movie_detail.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';
import 'package:movies_search/modules/search/domain/repositories/search_repository.dart';

abstract class SearchByImdbID {
  Future<Either<SearchError, MovieDetails>> call(String imdbID);
}

class SearchByImdbIDImpl implements SearchByImdbID {
  final SearchRepository repository;
  SearchByImdbIDImpl(this.repository);

  @override
  Future<Either<SearchError, MovieDetails>> call(String imdbID) async {
    if(imdbID == null || imdbID.isEmpty) {
      return Left(InvalidTextError());
    }
    return repository.searchDetails(imdbID);
  }

}