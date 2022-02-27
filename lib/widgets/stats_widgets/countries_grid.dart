import 'package:corona/index.dart';
import 'package:flutter/material.dart';

class CountriesGrid extends StatefulWidget {
  final List<SummaryEachCountry> list;

  const CountriesGrid({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  _CountriesGridState createState() => _CountriesGridState();
}

class _CountriesGridState extends State<CountriesGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        childAspectRatio: 2 / 2.9,
      ),
      itemCount: widget.list.length,
      itemBuilder: (ctx, i) {
        return CountryListItem(
          height: 180,
          countryName: widget.list[i].country!,
          countryCode: widget.list[i].code!,
          value: widget.list[i].totalCases!,
          flagPath: widget.list[i].flagPath!,
          isIncreasing: widget.list[i].isIncreasing!,
          itemColorData: colordata[i % colordata.length],
        );
      },
    );
  }
}
