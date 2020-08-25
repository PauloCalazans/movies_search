import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movies_search/modules/search/presenter/pages/movie_details_page.dart';
import 'package:movies_search/modules/search/presenter/states/search_state.dart';
import 'package:movies_search/modules/search/presenter/stores/search_store.dart';

class SearchPagePageView extends StatefulWidget {
  @override
  _SearchPagePageViewState createState() => _SearchPagePageViewState();
}

class _SearchPagePageViewState extends ModularState<SearchPagePageView, SearchStore> {

  final PageStorageKey _pageStorageKey = PageStorageKey('positionListPageView');
  PageController _pageController = PageController();

  _findMorePages() {
    final request = controller.state is LoadingState || controller.state is ErrorState;
    if(!request) {
      int i = ++controller.page;
      controller.setPage(i);
      controller.makeMorePages();
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).removePadding(removeTop: true);
    final String title = 'Movies';

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.movie_filter, size: 24),
        title: Text(title, style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search), color: Colors.white,
                  ),
                  hintText: "Buscar"
              ),
              onChanged: (value) {
                controller.setCurrentIndex(1);
                controller.setPage(1);
                controller.setTitleSearch(value);
              },
            ),
          ),

          Expanded(
            child: Observer(
                builder: (context) {
                  if(controller.listMovies != null && controller.currentIndex+1 == controller.listMovies.length) {
                    _findMorePages();
                  }

                  final state = controller.state;

                  if(state is ErrorState) {
                    return Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Icon(Icons.error_outline),
                        SizedBox(width: 8),
                        Text('Houve um erro'),
                      ],
                    ));
                  }

                  else if(state is StartState) {
                    return Center(child: Text('Digite o nome de um filme...'));
                  }

                  else if(state is LoadingState) {
                    return Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent[100]));
                  }

                  else if(state is SuccessStateListMovies) {
                    final list = state.list;
                    return Stack(
                      children: <Widget>[
                        PageView.builder(
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            allowImplicitScrolling: true,
                            itemCount: list.length,
                            onPageChanged: (index) {
                              var position = index + 1;
                              controller.setCurrentIndex(position);
                              if(position == controller.listMovies.length) {
                                _findMorePages();
                              }
                            },
                            itemBuilder: (context, index) {

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(context, PageRouteBuilder(
                                          transitionDuration: Duration(seconds: 1),
                                          fullscreenDialog: true,
                                          pageBuilder: (_, __, ___) => MovieDetailsPage(vo: list[index])))
                                          .then((value) => FocusScope.of(context).requestFocus(new FocusNode())),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          Hero(
                                            tag: 'img${list[index].imdbID}',
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              imageUrl: list[index].poster,
                                              placeholder: (context, url) => Center(child: const CircularProgressIndicator(backgroundColor: Colors.blueAccent, strokeWidth: 5,)),
                                              errorWidget: (context, url, error) => Image.asset("assets/images/semposter.png"),
                                            ),
                                          ),

                                          Positioned(
                                            left: 6,
                                            top: 8,
                                            width: MediaQuery.of(context).size.width * .9,
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              color: Colors.white.withOpacity(0.8),
                                              child: Text(list[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),

                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Container(
                              height: 60,
                              width: 60,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent[400].withOpacity(.7),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(35),
                                      topLeft: Radius.circular(35),
                                      bottomLeft: Radius.circular(35)
                                  )
                              ),
                              child: Center(child: Text('${controller.listMovies != null ? controller.listMovies.length : 0}', style: TextStyle(color: Colors.white, fontSize: 24),))
                          ),
                        ),

                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Container(
                              height: 60,
                              width: 60,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent[400].withOpacity(.7),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(35),
                                      topLeft: Radius.circular(35),
                                      bottomRight: Radius.circular(35)
                                  )
                              ),
                              child: Center(child: Text('${controller.currentIndex}', style: TextStyle(color: Colors.white, fontSize: 24),))
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }
            ),
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,// evitar que o teclado aperte o conteúdo
    );
  }
}
