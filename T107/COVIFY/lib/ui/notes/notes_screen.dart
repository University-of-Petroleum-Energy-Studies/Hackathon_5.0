
import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:covid19/ui/notes/notes_screen_mobile.dart';
import 'package:covid19/ui/notes/notes_screen_desktop.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => NotesScreenMobile(),
        desktop: (BuildContext context) => NotesScreenDesktop(),
      ),
    );
  }
}
