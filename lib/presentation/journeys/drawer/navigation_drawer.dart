import 'package:cinephile/common/constants/size_constants.dart';
import 'package:cinephile/common/extensions/size_extensions.dart';
import 'package:cinephile/presentation/journeys/drawer/navigation_expanded_list_item.dart';
import 'package:cinephile/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:flutter/material.dart';

class NavigationDrawerH extends StatelessWidget {
  const NavigationDrawerH({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      width: Sizes.dimen_300.w,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_14.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.w,
              ),
              child: const Center(
                child: Text(
                  'Cinephile',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
            NavigationListItem(title: 'Favourite Movies', onPressed: () {}),
            NavigationExpandedListItem(
              title: 'Languages',
              onPressed: () {},
              children: const [
                'English',
                'Hindi',
              ],
            ),
            NavigationListItem(title: 'Feedback', onPressed: () {}),
            NavigationListItem(title: 'About', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
