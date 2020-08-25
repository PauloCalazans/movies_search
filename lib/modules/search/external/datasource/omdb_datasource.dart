import 'package:dio/dio.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';
import 'package:movies_search/modules/search/infra/datasources/search_datasource.dart';
import 'package:movies_search/modules/search/infra/models/movie_details_model.dart';
import 'package:movies_search/modules/search/infra/models/movie_model.dart';

class OmdbDatasource implements SearchDataSource {
  final Dio dio;
  OmdbDatasource(this.dio);

  @override
  Future<MovieDetailsModel> searchByimdbID(String imdbID) async {
    final response = await dio.get('http://www.omdbapi.com/?apikey=27b47c25&i=$imdbID&plot=full');

    if(response.statusCode == 200) {
      return MovieDetailsModel.fromMap(response.data);
    } else {
      throw DataSourceError();
    }
  }

  @override
  Future<List<MovieModel>> searchTitle(String titleSearch, int page) async {
    final response = await dio.get('http://www.omdbapi.com/?apikey=27b47c25&s=$titleSearch&page=$page');

    if(response.statusCode == 200) {

      final jsonList = response.data['Search'] as List;
      final list = jsonList.map((e) => MovieModel.fromMap(e)).toList();

      return list;
    } else {
      throw DataSourceError();
    }
  }

}