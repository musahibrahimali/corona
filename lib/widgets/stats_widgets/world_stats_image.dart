import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WorldStatsImage extends StatelessWidget {
  const WorldStatsImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(color: Colors.purple[900], borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
          child: Image(
            width: MediaQuery.of(context).size.width > 360.0 ? 350 : 300,
            fit: BoxFit.fitWidth,
            image: const AssetImage("assets/stats/global_stats.png"),
          ),
        ),
      ),
    );
  }
}
