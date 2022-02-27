import 'package:auto_size_text/auto_size_text.dart';
import 'package:corona/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountryStatWidget extends StatefulWidget {
  final Color color;
  final String countryName;
  final String countryCode;
  final String flagPath;
  final bool isIncreasing;
  final int totalCases;
  final void Function() onBackArrow;

  const CountryStatWidget({
    Key? key,
    required this.color,
    required this.onBackArrow,
    required this.countryName,
    required this.countryCode,
    required this.flagPath,
    required this.isIncreasing,
    required this.totalCases,
  }) : super(key: key);

  @override
  _CountryStatWidgetState createState() => _CountryStatWidgetState();
}

class _CountryStatWidgetState extends State<CountryStatWidget> with TickerProviderStateMixin {
  late AnimationController _controller1, _controller2;
  late Duration textScaleDuration;
  final formatter = NumberFormat("#,###");
  late int selectedIndex;
  late Map<String, dynamic> todayJson, yestJson;
  late Future<bool> _countryFuture;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    textScaleDuration = const Duration(milliseconds: 200);
    _controller1 = AnimationController(vsync: this, duration: textScaleDuration, lowerBound: 0.7, upperBound: 1);
    _controller2 = AnimationController(vsync: this, duration: textScaleDuration, lowerBound: 0.7, upperBound: 1);
    _controller1.forward();
    _countryFuture = getCountryData();
  }

  Future<bool> getCountryData() async {
    ApiClient _apiClient = ApiClient();

    todayJson = await _apiClient.getStatsResponse(StateLocation.SPECIFIC, code: widget.countryCode);
    yestJson = await _apiClient.getStatsResponse(StateLocation.SPECIFIC, code: widget.countryCode, yesterday: true);
    return true;
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Stack(
        children: <Widget>[
          //Country Details
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Flag and Name and More
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Back Button
                      InkWell(
                        onTap: () {
                          widget.onBackArrow();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0x99FFFFFF),
                              width: 1.8,
                            ),
                          ),
                          margin: const EdgeInsets.only(left: 20),
                          padding: const EdgeInsets.all(7),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Color(0x99FFFFFF),
                            size: 21,
                          ),
                        ),
                      ),

                      //Name and flag
                      Flexible(
                        fit: FlexFit.loose,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Flag
                            Flexible(
                              fit: FlexFit.loose,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6, left: 4),
                                child: Image.asset(
                                  widget.flagPath,
                                  width: 32,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            //Country Name
                            Flexible(
                              flex: 2,
                              fit: FlexFit.loose,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6, left: 4),
                                child: AutoSizeText(
                                  widget.countryName,
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxFontSize: 22,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //More Icon
                      Padding(
                        padding: const EdgeInsets.only(right: 13, top: 3),
                        child: InkWell(
                          child: const Icon(
                            Icons.more_horiz,
                            color: Colors.white60,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //Number of Cases
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Number
                        FutureBuilder<bool>(
                          future: _countryFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const AutoSizeText(
                                "Unavailable",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.white,
                                  fontSize: 37,
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxFontSize: 37,
                              );
                            }
                            if (snapshot.hasData) {
                              if (todayJson is FetchDataException) {
                                return AutoSizeText(
                                  snapshot.data.toString(),
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 37,
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxFontSize: 37,
                                );
                              }
                              return AutoSizeText(
                                formatter.format(todayJson["cases"]),
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.white,
                                  fontSize: 37,
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxFontSize: 37,
                              );
                            }
                            return AutoSizeText(
                              formatter.format(widget.totalCases),
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                fontSize: 37,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w600,
                              ),
                              maxFontSize: 37,
                            );
                          },
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        //Arrow
                        Icon(
                          widget.isIncreasing ? Icons.arrow_upward : Icons.arrow_downward,
                          color: Colors.white,
                          size: 28,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //White Details Card
          Positioned(
            top: 150,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: FutureBuilder<bool>(
                future: _countryFuture,
                builder: (context, snapshot) {
                  //If error
                  if (snapshot.hasError) {
                    //error container
                    return Container(
                      margin: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: const Color(0xfff3cfff),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          snapshot.error.toString(),
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    if (todayJson is FetchDataException || yestJson is FetchDataException) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xfff3cfff),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            snapshot.data.toString(),
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    } else {
                      //Main Body
                      return CountryCardDetails(
                        countryCode: widget.countryCode,
                        countryName: widget.countryName,
                        isIncreasing: widget.isIncreasing,
                        flagPath: widget.flagPath,
                        color: widget.color,
                        totalCases: widget.totalCases,
                        todayJson: todayJson,
                        yestJson: yestJson,
                      );
                    }
                  } else {
                    return CountryStatLoader(
                      color: widget.color,
                      isDefault: defaultCountry.countryName == widget.countryName,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
