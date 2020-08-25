import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:movies_search/modules/search/domain/entities/movie.dart';
import 'package:movies_search/modules/search/domain/usecases/search_by_title.dart';
import 'package:movies_search/modules/search/presenter/states/search_state.dart';

part 'search_store.g.dart';

@Injectable()
class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  final SearchByTitle searchByTitle;

  CancelableOperation cancellableOperation;

  _SearchStoreBase(this.searchByTitle) {
    reaction((_) => titleSearch, (text) async {
      stateReaction(text, page, cancellableOperation);
    }, delay: 500);
  }

  Future stateReaction(String text, int page, [CancelableOperation cancellableOperation]) async {
    await cancellableOperation?.cancel();
    cancellableOperation = CancelableOperation<SearchState>.fromFuture(makeSearchByTitle(text, page));
    if (text.isEmpty) {
      setState(StartState());
      return;
    }

    setState(LoadingState());

    setState(await cancellableOperation.valueOrCancellation(LoadingState()));
  }

  Future<SearchState> makeSearchByTitle(String titleSearch, int page) async {
    var result = await searchByTitle(titleSearch, page);
    return result.fold((l) => ErrorState(l),
          (r) {
            addListMovie(r);
            return SuccessStateListMovies(r);
          });
  }

  makeMorePages() async {
//    setState(LoadingState());
    var result = await searchByTitle(titleSearch, page);
    result.fold((l) {
          setState(SuccessStateListMovies(listMovies));
        }, (r) {
          listMovies.addAll(r);
          setState(SuccessStateListMovies(listMovies));
        });
  }

  @observable
  String titleSearch = "";

  @observable
  ScrollController scrollController = ScrollController();

  @observable
  int page = 0;

  @observable
  int currentIndex = 1;

  @observable
  List<Movie> listMovies;

  @observable
  SearchState state = StartState();

  @computed
  int get totalMovies => state is SuccessStateListMovies ? listMovies.length : 0;

  @action
  setTitleSearch(String value) => titleSearch = value;

  @action
  addListMovie(List<Movie> value) => listMovies = value;

  @action
  setPage(int value) => page = value;

  @action
  setCurrentIndex(int value) => currentIndex = value;

  @action
  setState(SearchState value) => state = value;
}