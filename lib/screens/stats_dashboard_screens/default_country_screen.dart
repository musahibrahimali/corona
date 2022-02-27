import 'package:auto_size_text/auto_size_text.dart';
import 'package:corona/index.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultCountryScreen extends StatefulWidget {
  final PageController controller;

  const DefaultCountryScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _DefaultCountryScreenState createState() => _DefaultCountryScreenState();
}

class _DefaultCountryScreenState extends State<DefaultCountryScreen> {
  @override
  Widget build(BuildContext context) {
    if (defaultCountry.countryName == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 350, 15, 0),
        child: Column(
          children: <Widget>[
            const AutoSizeText(
              "No default country selected yet",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              maxFontSize: 18,
            ),
            const SizedBox(height: 20),

            //Choose default country
            InkWell(
              onTap: () {
                widget.controller.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Center(
                  child: AutoSizeText(
                    "Choose a default",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxFontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return CountryStatWidget(
      onBackArrow: () {
        widget.controller.animateToPage(
          0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
        );
      },
      countryName: defaultCountry.countryName!,
      countryCode: defaultCountry.countryCode!,
      color: Color(defaultCountry.color!),
      totalCases: defaultCountry.totalCases!,
      flagPath: defaultCountry.flagPath!,
      isIncreasing: defaultCountry.isIncreasing!,
    );
  }
}
