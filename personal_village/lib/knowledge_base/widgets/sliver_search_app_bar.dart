import 'package:flutter/material.dart';
import 'package:personal_village/knowledge_base/widgets/background_wave.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  const SliverSearchAppBar();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.5;
    double topPadding = MediaQuery.of(context).padding.top + 16;

    return Stack(
      children: [
        // Positioned(
        //   top: topPadding + offset,
        //   child: const SearchBar(),
        //   left: 16,
        //   right: 16,
        // ),

        const BackgroundWave(
          height: 300,
        ),
        Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {},
            )),
        Positioned(
          bottom: topPadding + offset,
          left: topPadding,
          child: Text(
            "All your resources in \nONE Place!!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
