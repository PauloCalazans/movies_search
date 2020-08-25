import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_search/modules/search/domain/entities/movie.dart';
import 'package:movies_search/modules/search/presenter/states/find_state.dart';
import 'package:movies_search/modules/search/presenter/states/search_state.dart';
import 'package:movies_search/modules/search/presenter/stores/find_store.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie vo;
  const MovieDetailsPage({Key key, this.vo}) : super(key: key);

  @override
  MovieDetailsPageState createState() => MovieDetailsPageState();
}

class MovieDetailsPageState extends ModularState<MovieDetailsPage, FindStore> {

  @override
  void initState() {
    controller.makeSearchByImdbID(widget.vo.imdbID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget> [
            SliverAppBar(
              elevation: 2.0,
              expandedHeight: MediaQuery.of(context).size.height * .65,
              pinned: true,
              flexibleSpace: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                    tag: 'img${widget.vo.imdbID}',
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height * .55,
                      fit: BoxFit.fitWidth,
                      imageUrl: widget.vo.poster,
                      placeholder: (context, url) => Center(child: const CircularProgressIndicator(backgroundColor: Colors.blueAccent, strokeWidth: 5,)),
                      errorWidget: (context, url, error) => Image.asset("assets/images/semposter.png", fit: BoxFit.cover,),
                    ),
                  ),

                  Positioned(
                    bottom: 8,
                    left: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.8),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, top: 4.0, bottom: 4.0, right: 12),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.event),
                            SizedBox(width: 8),
                            Text('${widget.vo.year}')
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 8,
                    right: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.8),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, top: 4.0, bottom: 4.0, right: 12),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.access_time),
                            SizedBox(width: 8),
                            Observer(
                              builder: (_) {
                                final state = controller.state;
                                if(state is FindSuccessStateMovieDetails) {
                                  final movieDetails = state.movieDetails;

                                  return Text('${movieDetails.runtime}');
                                } else {
                                  return Text('');
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),

          ];
        },
        body: ListView(
          children: <Widget>[
            Observer(
              builder: (_) {
                final state = controller.state;

                if(state is FindErrorState) {
                  return Center(child: Row(
                    children: <Widget>[
                      Icon(Icons.error_outline),
                      SizedBox(width: 8),
                      Text('Houve um erro'),
                    ],
                  ));
                }

                else if(state is StartState) {
                  return Container();
                }

                else if(state is FindLoadingState) {
                  return Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent[100]));
                }

                else if (state is FindSuccessStateMovieDetails) {
                  var movieDetails = state.movieDetails;
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Título: ${movieDetails.title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        SizedBox(height: 4.0,),
                        SizedBox(height: 4.0,),
                        Text('Tipo: ${movieDetails.type}'),
                        SizedBox(height: 4.0,),
                        Text('Ators: ${movieDetails.actors}'),
                        SizedBox(height: 4.0,),
                        Text('Diretor: ${movieDetails.director}'),
                        SizedBox(height: 4.0,),
                        Text('País: ${movieDetails.country}'),
                        SizedBox(height: 4.0,),
                        Text('Produtora: ${movieDetails.production}'),
                        SizedBox(height: 4.0,),
                        Text('Gênero: ${movieDetails.genre}'),
                        SizedBox(height: 4.0,),
                        Text('Sinopse: ${movieDetails.plot}', textAlign: TextAlign.justify,),
                      ],
                    ),
                  );
                }

                else {
                  return Container();
                }
              },
            ),
          ],
        )
      ),
    );


    /*Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Observer(
          builder: (_) {
            final state = controller.state;

            if(state is FindErrorState) {
              return Center(child: Row(
                children: <Widget>[
                  Icon(Icons.error_outline),
                  SizedBox(width: 8),
                  Text('Houve um erro'),
                ],
              ));
            }

            else if(state is StartState) {
              return Container();
            }

            else if(state is FindLoadingState) {
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent[100]));
            }

            else if (state is FindSuccessStateMovieDetails) {
              var movieDetails = state.movieDetails;
              return ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.height * .45,
                          fit: BoxFit.fitHeight,
                          imageUrl: movieDetails.poster,
                          placeholder: (context, url) => const CircularProgressIndicator(backgroundColor: Colors.blueAccent,),
                          errorWidget: (context, url, error) => Center(child: Icon(Icons.movie_filter, size: 120,)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Título: ${movieDetails.title}'),
                            SizedBox(height: 4.0,),
                            Text('Ano: ${movieDetails.year}'),
                            SizedBox(height: 4.0,),
                            Text('Tipo: ${movieDetails.type}'),
                            SizedBox(height: 4.0,),
                            Text('Ators: ${movieDetails.actors}'),
                            SizedBox(height: 4.0,),
                            Text('Diretor: ${movieDetails.director}'),
                            SizedBox(height: 4.0,),
                            Text('País: ${movieDetails.country}'),
                            SizedBox(height: 4.0,),
                            Text('Produtora: ${movieDetails.production}'),
                            SizedBox(height: 4.0,),
                            Text('Gênero: ${movieDetails.genre}'),
                            SizedBox(height: 4.0,),
                            Text('Sinopse: ${movieDetails.plot}', textAlign: TextAlign.justify,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            else {
              return Container();
            }
          },
        )
    );*/
  }
}
