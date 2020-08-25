import 'package:movies_search/modules/search/infra/models/movie_details_model.dart';
import 'package:movies_search/modules/search/infra/models/movie_model.dart';

abstract class SearchDataSource {
  Future<List<MovieModel>> searchTitle(String titleSearch, int page);

  Future<MovieDetailsModel> searchByimdbID(String imdbID);
}