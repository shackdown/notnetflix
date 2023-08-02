import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/screens/home_screen.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    // todo : appel API
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    // on initialise nos différentes listes de movies
    await dataProvider.initData();
    // ensuite on va sur HomeScreen (apres une pause forcée de 1sec)
    // await Future.delayed(const Duration(seconds: 1));
    goHomeScreen();
  }

  void goHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/netflix_logo_1.png'),
            SpinKitFadingCircle(color: kPrimaryColor, size: 20)
          ],
        ));
  }
}
