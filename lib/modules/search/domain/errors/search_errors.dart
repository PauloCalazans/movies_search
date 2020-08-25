abstract class SearchError implements Exception {}

class InvalidTextError implements SearchError {}

class DataSourceError implements SearchError {
  final String message;

  DataSourceError({this.message});
}