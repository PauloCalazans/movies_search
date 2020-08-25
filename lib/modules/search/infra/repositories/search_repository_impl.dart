import 'package:dartz/dartz.dart';
import 'package:movies_search/modules/search/domain/entities/movie.dart';
import 'package:movies_search/modules/search/domain/entities/movie_detail.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';
import 'package:movies_search/modules/search/domain/repositories/search_repository.dart';
import 'package:movies_search/modules/search/infra/datasources/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;
  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Either<SearchError, MovieDetails>> searchDetails(String imdbID) async {
    try {
      final result = await dataSource.searchByimdbID(imdbID);
      return Right(result);
    } on DataSourceError catch(e) {
      return Left(e);
    }catch(e) {
      return Left(DataSourceError());
    }
  }

  @override
  Future<Either<SearchError, List<Movie>>> searchTitle(String titleSearch, int page) async {
    try {
      final result = await dataSource.searchTitle(titleSearch, page);
      return Right(result);
    } on DataSourceError catch(e) {
      return Left(e);
    }catch(e) {
      return Left(DataSourceError());
    }
  }

}