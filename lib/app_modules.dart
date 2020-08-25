import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_search/app_widgets.dart';
import 'package:movies_search/modules/search/domain/usecases/search_by_imdbid.dart';
import 'package:movies_search/modules/search/domain/usecases/search_by_title.dart';
import 'package:movies_search/modules/search/external/datasource/omdb_datasource.dart';
import 'package:movies_search/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:movies_search/modules/search/presenter/pages/movie_details_page.dart';
import 'package:movies_search/modules/search/presenter/pages/search_page_pageview.dart';
import 'package:movies_search/modules/search/presenter/stores/find_store.dart';
import 'package:movies_search/modules/search/presenter/stores/search_store.dart';

class AppModules extends MainModule {
  @override
  List<Bind> get binds => [
    Bind((i) => Dio()),
    Bind((i) => SearchByTitleImpl(i())),
    Bind((i) => SearchByImdbIDImpl(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => OmdbDatasource(i())),
    Bind((i) => SearchStore(i())),
    Bind((i) => FindStore(i())),
  ];

  @override
  List<Router> get routers => [
    Router('/', child: (_,__) => SearchPagePageView()),
    Router('/details', child: (_, args) => MovieDetailsPage(vo: args.data['vo'],)),
  ];

  @override
  Widget get bootstrap => AppWidgets();

}