import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/movieDetails/binding/movie_details_binding.dart';
import 'package:evntas/presentation/feature/movieDetails/movie_details_view_model.dart';
import 'package:evntas/presentation/feature/movieDetails/route/movie_details_argument.dart';
import 'package:evntas/presentation/feature/movieDetails/route/movie_details_route.dart';
import 'package:evntas/presentation/feature/movieDetails/screen/movie_details_mobile_landscape.dart';
import 'package:evntas/presentation/feature/movieDetails/screen/movie_details_mobile_portrait.dart';

class MovieDetailsAdaptiveUi
    extends BaseAdaptiveUi<MovieDetailsArgument, MovieDetailsRoute> {
  const MovieDetailsAdaptiveUi({
    super.argument,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => MovieDetailsAdaptiveUiState();
}

class MovieDetailsAdaptiveUiState extends BaseAdaptiveUiState<
    MovieDetailsArgument,
    MovieDetailsRoute,
    MovieDetailsAdaptiveUi,
    MovieDetailsViewModel,
    MovieDetailsBinding> {
  @override
  MovieDetailsBinding binding = MovieDetailsBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return MovieDetailsUiMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return MovieDetailsUiMobileLandscape(viewModel: viewModel);
  }
}
