import 'package:cinephile/common/extensions/size_extensions.dart';
import 'package:cinephile/domain/entities/movie_detail_entity.dart';
import 'package:cinephile/domain/entities/movie_entity.dart';
import 'package:cinephile/presentation/blocs/favorite/favotite_bloc.dart';
import 'package:cinephile/presentation/blocs/favorite/favotite_state.dart';
import 'package:cinephile/presentation/blocs/favorite/favotitr.event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/size_constants.dart';

class MovieDetailedAppBar extends StatelessWidget {
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailedAppBar({
    super.key,
    required this.movieDetailEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: Sizes.dimen_12.h,
            color: Colors.white,
          ),
        ),
        BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is IsFavoriteMovie) {
              return GestureDetector(
                onTap: () => BlocProvider.of<FavoriteBloc>(context).add(
                  ToggleFavoriteMovieEvent(
                    MovieEntity.fromMovieDetailEntity(movieDetailEntity),
                    state.isMovieFavorite,
                  ),
                ),
                child: Icon(
                  state.isMovieFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: Sizes.dimen_12.h,
                  color: Colors.white,
                ),
              );
            } else {
              return Icon(
                Icons.favorite_border,
                size: Sizes.dimen_12.h,
                color: Colors.white,
              );
            }
          },
        ),
      ],
    );
  }
}
