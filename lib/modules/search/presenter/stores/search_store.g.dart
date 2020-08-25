// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStoreBase, Store {
  Computed<int> _$totalMoviesComputed;

  @override
  int get totalMovies =>
      (_$totalMoviesComputed ??= Computed<int>(() => super.totalMovies,
              name: '_SearchStoreBase.totalMovies'))
          .value;

  final _$titleSearchAtom = Atom(name: '_SearchStoreBase.titleSearch');

  @override
  String get titleSearch {
    _$titleSearchAtom.reportRead();
    return super.titleSearch;
  }

  @override
  set titleSearch(String value) {
    _$titleSearchAtom.reportWrite(value, super.titleSearch, () {
      super.titleSearch = value;
    });
  }

  final _$scrollControllerAtom =
      Atom(name: '_SearchStoreBase.scrollController');

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  final _$pageAtom = Atom(name: '_SearchStoreBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$currentIndexAtom = Atom(name: '_SearchStoreBase.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$listMoviesAtom = Atom(name: '_SearchStoreBase.listMovies');

  @override
  List<Movie> get listMovies {
    _$listMoviesAtom.reportRead();
    return super.listMovies;
  }

  @override
  set listMovies(List<Movie> value) {
    _$listMoviesAtom.reportWrite(value, super.listMovies, () {
      super.listMovies = value;
    });
  }

  final _$stateAtom = Atom(name: '_SearchStoreBase.state');

  @override
  SearchState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SearchState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_SearchStoreBaseActionController =
      ActionController(name: '_SearchStoreBase');

  @override
  dynamic setTitleSearch(String value) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction(
        name: '_SearchStoreBase.setTitleSearch');
    try {
      return super.setTitleSearch(value);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addListMovie(List<Movie> value) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction(
        name: '_SearchStoreBase.addListMovie');
    try {
      return super.addListMovie(value);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPage(int value) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction(
        name: '_SearchStoreBase.setPage');
    try {
      return super.setPage(value);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentIndex(int value) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction(
        name: '_SearchStoreBase.setCurrentIndex');
    try {
      return super.setCurrentIndex(value);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setState(SearchState value) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction(
        name: '_SearchStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
titleSearch: ${titleSearch},
scrollController: ${scrollController},
page: ${page},
currentIndex: ${currentIndex},
listMovies: ${listMovies},
state: ${state},
totalMovies: ${totalMovies}
    ''';
  }
}
