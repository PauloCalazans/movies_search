import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:movies_search/modules/search/domain/usecases/search_by_imdbid.dart';
import 'package:movies_search/modules/search/presenter/states/find_state.dart';

part 'find_store.g.dart';

@Injectable()
class FindStore = _FindStoreBase with _$FindStore;

abstract class _FindStoreBase with Store {
  final SearchByImdbID searchByImdbID;

  _FindStoreBase(this.searchByImdbID);

  Future<FindState> makeSearchByImdbID(String imdbID) async {
    setState(FindLoadingState());
    var result = await searchByImdbID(imdbID);
    var stateResult = result.fold((l) => FindErrorState(l), (r) => FindSuccessStateMovieDetails(r));
    setState(stateResult);
    return stateResult;
  }

  @observable
  FindState state = FindStartState();

  @action
  setState(FindState value) => state = value;
}