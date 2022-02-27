import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaseBars extends StatefulWidget {
  final Color color;
  final int totalActive, totalDeaths, totalRecovered, totalCases;

  const CaseBars({
    Key? key,
    required this.color,
    required this.totalActive,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.totalCases,
  }) : super(key: key);

  @override
  _CaseBarsState createState() => _CaseBarsState();
}

class _CaseBarsState extends State<CaseBars> {
  final Duration _progressDuration = const Duration(milliseconds: 300);
  final formatter = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AutoSizeText(
          "Overall Statistics",
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
          maxFontSize: 22,
        ),

        const SizedBox(height: 20),

        //Total active progress
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(2),
                ),
                width: 8,
                height: 8,
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: AutoSizeText(
                  "Total Active",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424242),
                  ),
                  maxFontSize: 14,
                ),
              ),
              AutoSizeText(
                formatter.format(widget.totalActive),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Montserrat",
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
                maxFontSize: 14,
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        //Slider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                height: 5,
              ),
              AnimatedContainer(
                duration: _progressDuration,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: widget.totalActive / widget.totalCases * MediaQuery.of(context).size.width,
                height: 5,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        //Total Recovered Progress
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(2),
                ),
                width: 8,
                height: 8,
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: AutoSizeText(
                  "Total Recovered",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424242),
                  ),
                  maxFontSize: 14,
                ),
              ),
              AutoSizeText(
                formatter.format(widget.totalRecovered),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Montserrat",
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
                maxFontSize: 14,
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        //Slider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                height: 5,
              ),
              AnimatedContainer(
                duration: _progressDuration,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: widget.totalRecovered / widget.totalCases * MediaQuery.of(context).size.width,
                height: 5,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        //Total Death Progress
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(2),
                ),
                width: 8,
                height: 8,
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: AutoSizeText(
                  "Total Deaths",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424242),
                  ),
                  maxFontSize: 14,
                ),
              ),
              AutoSizeText(
                formatter.format(widget.totalDeaths),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Montserrat",
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
                maxFontSize: 14,
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        //Slider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                height: 5,
              ),
              AnimatedContainer(
                duration: _progressDuration,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: widget.totalDeaths / widget.totalCases * MediaQuery.of(context).size.width + 30,
                height: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
