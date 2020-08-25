import 'package:dartz/dartz.dart';
import 'package:movies_search/modules/search/domain/entities/movie.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';
import 'package:movies_search/modules/search/domain/repositories/search_repository.dart';

abstract class SearchByTitle {
  Future<Either<SearchError, List<Movie>>> call(String titleSearch, int page);
}

class SearchByTitleImpl implements SearchByTitle {
  final SearchRepository repository;
  SearchByTitleImpl(this.repository);

  @override
  Future<Either<SearchError, List<Movie>>> call(String titleSearch, int page) async {
    if(titleSearch == null || titleSearch.isEmpty || page == 0) {
      return Left(InvalidTextError());
    }
    return repository.searchTitle(titleSearch, page);
  }

}