import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/widgets/action_button.dart';
import 'package:notnetflix/ui/widgets/casting_card.dart';
import 'package:notnetflix/ui/widgets/galerie_card.dart';
import 'package:notnetflix/ui/widgets/movie_info.dart';
import 'package:notnetflix/ui/widgets/video_player.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    // récuperation du détail du movie
    Movie _movie = await dataProvider.getMovieDetail(movie: widget.movie);
    setState(() {
      newMovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: newMovie == null
          ? Center(
              child: SpinKitFadingCircle(color: kPrimaryColor, size: 20),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  SizedBox(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      child: newMovie!.videos!.isEmpty
                          ? Center(
                              child: Text(
                                'Pas de vidéo',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            )
                          : MyVideoPlayer(movieId: newMovie!.videos!.first)),
                  MovieInfo(movie: newMovie!),
                  const SizedBox(height: 10),
                  ActionButton(
                      icon: Icons.play_arrow,
                      bgColor: Colors.white,
                      contentColor: kBackgroundColor,
                      label: 'Lecture'),
                  const SizedBox(height: 10),
                  ActionButton(
                      icon: Icons.download,
                      bgColor: Colors.grey.withOpacity(0.3),
                      contentColor: Colors.white,
                      label: 'Télécharger la vidéo'),
                  const SizedBox(height: 20),
                  Text(newMovie!.description,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 13)),
                  const SizedBox(height: 10),
                  Text('Casting',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 360,
                    child: ListView.builder(
                        itemCount: newMovie!.casting!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return newMovie!.casting![index].imageURL == null
                              ? const Center()
                              : CastingCard(person: newMovie!.casting![index]);
                        }),
                  ),
                  const SizedBox(height: 20),
                  Text('Galerie',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 360,
                    child: ListView.builder(
                        itemCount: newMovie!.images!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return GalerieCard(
                              posterPath: newMovie!.images![index]);
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
