import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/feature/movieDetails/movie_details_adaptive_ui.dart';
import 'package:evntas/presentation/feature/movieDetails/route/movie_details_argument.dart';
import 'package:evntas/presentation/navigation/route_path.dart';

class MovieDetailsRoute extends BaseRoute<MovieDetailsArgument> {
  @override
  RoutePath routePath = RoutePath.movieDetails;

  MovieDetailsRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
        builder: (_) => MovieDetailsAdaptiveUi(argument: arguments));
  }
}
