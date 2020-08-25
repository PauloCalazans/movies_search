import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';
import 'package:movies_search/modules/search/infra/datasources/search_datasource.dart';
import 'package:movies_search/modules/search/infra/models/movie_details_model.dart';
import 'package:movies_search/modules/search/infra/models/movie_model.dart';
import 'package:movies_search/modules/search/infra/repositories/search_repository_impl.dart';

class SearchDataSouceMock extends Mock implements SearchDataSource {}

main() {
  final datasource = SearchDataSouceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('Deve Retornar uma lista de MovieModel', () async {
    when(datasource.searchTitle(any, any)).thenAnswer((_) async => <MovieModel>[]);

    final result = await repository.searchTitle("avengers", 1);
    expect(result | null, isA<List<MovieModel>>());

  });

  test('Deve Retornar um DataSourceError se o datasource falhar', () async {
    when(datasource.searchTitle(any, any)).thenThrow(Exception());

    final result = await repository.searchTitle("avengers", 1);
    expect(result.fold(id, id), isA<DataSourceError>());
  });

  test('Deve Retornar um MovieDetailModel', () async {
    when(datasource.searchByimdbID(any)).thenAnswer((_) async => MovieDetailsModel());

    final result = await repository.searchDetails("tt451");
    expect(result | null, isA<MovieDetailsModel>());
  });

  test('Deve Retornar um DataSourceError se o datasource falhar', () async {
    when(datasource.searchByimdbID(any)).thenThrow(Exception());

    final result = await repository.searchDetails("tt4581");
    expect(result.fold(id, id), isA<DataSourceError>());
  });

}