import 'package:cinephile/common/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/size_constants.dart';

class MovieDetailedAppBar extends StatelessWidget {
  const MovieDetailedAppBar({super.key});

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
        Icon(
          Icons.favorite_border,
          size: Sizes.dimen_12.h,
          color: Colors.white,
        ),
      ],
    );
  }
}
