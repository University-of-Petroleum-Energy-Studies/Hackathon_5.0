import 'package:flutter/material.dart';
import 'package:covid19/data/network/constants/endpoints.dart';
import 'package:covid19/constants/colors.dart';
import 'package:covid19/ui/statistics/statistics_screen.dart';
import 'package:covid19/ui/prevention/prevention_screen.dart';
import 'package:covid19/ui/symptoms/symptoms_screen.dart';


import 'package:covid19/ui/information/information_screen.dart';


class HomeDesktopScreen extends StatefulWidget {
  @override
  _HomeDesktopScreenState createState() => _HomeDesktopScreenState();
}

class _HomeDesktopScreenState extends State<HomeDesktopScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Row(
          children: <Widget>[
            Container(
              width: 125,
              child: NavigationRail(
                backgroundColor: AppColors.primaryColor,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                selectedLabelTextStyle: const TextStyle(
                  color: AppColors.mythColor,
                  fontSize: 15,
                ),
                labelType: NavigationRailLabelType.selected,
                groupAlignment: 0.0,
                destinations: [
                  navigationRaiilItem(
                    imagePath: '${Endpoints.baseUrlGraphics}/statistics.png',
                    title: 'Statistics',
                  ),
                  navigationRaiilItem(
                    imagePath: '${Endpoints.baseUrlGraphics}/prevention.png',
                    title: 'Prevention',
                  ),
                  navigationRaiilItem(
                    imagePath: '${Endpoints.baseUrlGraphics}/symptoms.png',
                    title: 'Symptoms',
                  ),
                  navigationRaiilItem(
                    imagePath: '${Endpoints.baseUrlGraphics}/myth-busters.png',
                    title: 'Myth\nBusters',
                  ),
                  navigationRaiilItem(
                    imagePath: '${Endpoints.baseUrlGraphics}/faq-data.png',
                    title: 'FAQ',
                  ),

                  navigationRaiilItem(
                    imagePath: '${Endpoints.baseUrlGraphics}/map.png',
                    title: 'Live Heat Map',
                  ),
                  navigationRaiilItem(
                    imagePath: '${Endpoints.baseUrlGraphics}/hospital.png',
                    title: 'Nearby Centers',
                  ),
                  navigationRaiilItem(
                    imagePath: '${Endpoints.baseUrlGraphics}/news.png',
                    title: 'COVID News',
                  ),
                  navigationRaiilItem(
                    imagePath: '${Endpoints.baseUrlGraphics}/notes.png',
                    title: 'Incubation Notes',
                  ),
                ],
              ),
            ),

            // This is the main content.
            if (_selectedIndex == 0)
              Expanded(
                child: StatisticsScreen(),
              )
            else if (_selectedIndex == 1)
              Expanded(
                child: PreventionScreen(),
              )
            else if (_selectedIndex == 2)
              Expanded(
                child: SymptomsScreen(),
              )

          ],
        ),
      ),
    );
  }
}


NavigationRailDestination navigationRaiilItem(
    {String title, String imagePath}) {
  return NavigationRailDestination(
    icon: Image.network(
      imagePath,
      color: AppColors.homeCardLoadingColor,
      height: 36,
      alignment: Alignment.center,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 36,
          decoration: const BoxDecoration(
            color: AppColors.homeCardLoadingColor,
            shape: BoxShape.circle,
          ),
        );
      },
    ),
    selectedIcon: Image.network(
      imagePath,
      height: 36,
      alignment: Alignment.center,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        );
      },
    ),
    label: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
