import 'package:flutter/material.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/widgets/movie_card.dart';
import 'package:notnetflix/ui/widgets/movie_category.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 500,
              child: MovieCard(movie: dataProvider.popularMovieList.first)),
          // tendances actuelles
          MovieCategory(
            imageHeight: 160,
            imageWidth: 110,
            label: 'Tendances actuelles',
            movieList: dataProvider.popularMovieList,
            callback: dataProvider.getPopularMovies,
          ),
          // Actuellement au cinéma
          MovieCategory(
              imageHeight: 160,
              imageWidth: 110,
              label: 'Actuellement au cinéma',
              movieList: dataProvider.playingNowMovieList,
              callback: dataProvider.getPlayingNow),
          // Ils arrivent bientôt
          MovieCategory(
              imageHeight: 160,
              imageWidth: 110,
              label: 'Ils arrivent bientôt',
              movieList: dataProvider.upcomingMovieList,
              callback: dataProvider.getUpcoming),
          // Animation movies
          MovieCategory(
              imageHeight: 320,
              imageWidth: 220,
              label: 'Animation',
              movieList: dataProvider.animationMovieList,
              callback: dataProvider.getAnimationMovies),
        ],
      ),
    );
  }
}
