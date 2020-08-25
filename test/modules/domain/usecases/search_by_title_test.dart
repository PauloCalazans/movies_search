import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_search/modules/search/domain/entities/movie.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';
import 'package:movies_search/modules/search/domain/repositories/search_repository.dart';
import 'package:movies_search/modules/search/domain/usecases/search_by_title.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByTitleImpl(repository);

  test('Deve retornar uma lista de Movie', () async {

    when(repository.searchTitle(any, any)).thenAnswer((_) async => Right(<Movie>[]));
    final result = await usecase("avengers", 1);
    expect(result | null, isA<List<Movie>>());
  });

  test('Deve retornar um erro caso o texto seja inválido ou a página igual 0', () async {

    when(repository.searchTitle(any, any)).thenAnswer((_) async => Right(<Movie>[]));
    var result = await usecase(null, 0);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase('', 0);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}