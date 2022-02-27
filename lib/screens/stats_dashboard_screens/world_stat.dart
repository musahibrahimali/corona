import 'dart:convert';

import 'package:corona/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
enum CaseType { ACTIVE, DEATHS, RECOVERED }

class WorldStatScreen extends StatefulWidget {
  const WorldStatScreen({Key? key}) : super(key: key);

  @override
  _WorldStatScreenState createState() => _WorldStatScreenState();
}

class _WorldStatScreenState extends State<WorldStatScreen> {
  late PageController _controller;
  int selectedBottomBarIndex = 0;
  late List<Widget> pages;
  late List<BarItem> barItems;
  late Future<bool> future;

  Future<bool> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonString = prefs.getString('defaultCountry');
    if (jsonString != null) {
      defaultCountry = DefaultCountry().fromJson(json.decode(jsonString));
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    future = loadPreferences();
    _controller = PageController(initialPage: selectedBottomBarIndex);
    pages = [
      GlobalStatScreen(
        controller: _controller,
      ),
      const CountriesScreen(),
      DefaultCountryScreen(controller: _controller),
      CreditsScreen(
        controller: _controller,
      ),
    ];
    barItems = [
      BarItem(
        icon: Icons.insert_chart,
        iconSize: 24,
        text: "Global",
        textSize: 18,
        color: Colors.purpleAccent[700],
      ),
      BarItem(
        icon: Icons.search,
        iconSize: 24,
        text: "Search",
        textSize: 18,
        color: const Color(0xff6078ff),
      ),
      BarItem(
        icon: Icons.flag,
        iconSize: 24,
        text: "Default",
        textSize: 18,
        color: Colors.red,
      ),
      BarItem(
        icon: Icons.info_outline,
        iconSize: 24,
        text: "Credits",
        textSize: 18,
        color: const Color(0xff009a88),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getScaffoldColor() {
    if (selectedBottomBarIndex == 0) {
      return Colors.grey.shade100;
    } else if (selectedBottomBarIndex == 1 || selectedBottomBarIndex == 3) {
      return Colors.white;
    }
    return defaultCountry.countryName == null ? Colors.white : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: getScaffoldColor(),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                itemCount: 4,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  selectedBottomBarIndex = index;
                  setState(() {
                    selectedBottomBarIndex = index;
                  });
                },
                controller: _controller,
                itemBuilder: (context, index) => pages[index],
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                semanticsLabel: "Loading preferences",
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: AnimatedBottomBar(
        onItemTap: (index) {
          _controller.animateToPage(index, duration: const Duration(milliseconds: 150), curve: Curves.easeInOut);
        },
        barItems: barItems,
        currBarItem: selectedBottomBarIndex,
        animationDuration: const Duration(milliseconds: 150),
        elevation: 15,
      ),
    );
  }
}
