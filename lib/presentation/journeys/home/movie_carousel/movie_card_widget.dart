import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinephile/common/constants/route_constants.dart';
import 'package:cinephile/common/constants/size_constants.dart';
import 'package:cinephile/common/extensions/size_extensions.dart';
import 'package:cinephile/data/core/api_constants.dart';
import 'package:cinephile/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:flutter/material.dart';

class MovieCardWidget extends StatelessWidget {
  final int movieId;
  final String posterPath;

  const MovieCardWidget({
    super.key,
    required this.movieId,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            RouteList.movieDetail,
            arguments: MovieDetailArguments(movieId),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
