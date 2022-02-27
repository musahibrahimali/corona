import 'package:corona/index.dart';
import 'package:flutter/material.dart';

class CountryStatScreen extends StatefulWidget {
  final Color color;
  final String countryName;
  final String countryCode;
  final String flagPath;
  final bool isIncreasing;
  final int totalCases;

  const CountryStatScreen({
    Key? key,
    required this.color,
    required this.countryName,
    required this.countryCode,
    required this.flagPath,
    required this.isIncreasing,
    required this.totalCases,
  }) : super(key: key);

  @override
  _CountryStatScreenState createState() => _CountryStatScreenState();
}

class _CountryStatScreenState extends State<CountryStatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: CountryStatWidget(
          color: widget.color,
          onBackArrow: () {
            Navigator.of(context).pop();
          },
          countryCode: widget.countryCode,
          countryName: widget.countryName,
          totalCases: widget.totalCases,
          flagPath: widget.flagPath,
          isIncreasing: widget.isIncreasing,
        ),
      ),
    );
  }
}
