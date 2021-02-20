// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Examples can assume:
// enum Department { treasury, state }
// BuildContext context;

/// A material design dialog.
///
/// This dialog widget does not have any opinion about the contents of the
/// dialog. Rather than using this widget directly, consider using [CustomAlertDialog]
/// or [SimpleDialog], which implement specific kinds of material design
/// dialogs.
///
/// See also:
///
///  * [CustomAlertDialog], for dialogs that have a message and some buttons.
///  * [SimpleDialog], for dialogs that offer a variety of options.
///  * [showDialog], which actually displays the dialog and returns its result.
///  * <https://material.io/design/components/dialogs.html>
class Dialog extends StatelessWidget {
  /// Creates a dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  const Dialog({
    Key key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape,
    this.child,
  }) : super(key: key);

  /// {@template flutter.material.dialog.backgroundColor}
  /// The background color of the surface of this [Dialog].
  ///
  /// This sets the [Material.color] on this [Dialog]'s [Material].
  ///
  /// If `null`, [ThemeData.cardColor] is used.
  /// {@endtemplate}
  final Color backgroundColor;


  final double elevation;


  final Duration insetAnimationDuration;


  final Curve insetAnimationCurve;


  final ShapeBorder shape;


  final Widget child;


  static const double _defaultElevation = 24.0;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return MediaQuery.removeViewInsets(
      context: context,
      removeTop: true,
      child: Stack(
        children: <Widget>[
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Fetching Data",
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets +
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
            duration: insetAnimationDuration,
            curve: insetAnimationCurve,
            child: MediaQuery.removeViewInsets(
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 280.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: backgroundColor ??
                        dialogTheme.backgroundColor ??
                        Theme.of(context).dialogBackgroundColor,
                    elevation:
                        elevation ?? dialogTheme.elevation ?? _defaultElevation,
                    type: MaterialType.card,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {

  const CustomAlertDialog({
    Key key,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.contentTextStyle,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.shape,
  })  : assert(contentPadding != null),
        super(key: key);

  final Widget title;

  final EdgeInsetsGeometry titlePadding;


  final TextStyle titleTextStyle;


  final Widget content;


  final EdgeInsetsGeometry contentPadding;

  final TextStyle contentTextStyle;

  final List<Widget> actions;

  final Color backgroundColor;
  final double elevation;

  final String semanticLabel;

  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final List<Widget> children = <Widget>[];
    String label = semanticLabel;

    if (title != null) {
      children.add(Padding(
        padding: titlePadding ??
            EdgeInsets.fromLTRB(24.0, 24.0, 24.0, content == null ? 20.0 : 0.0),
        child: DefaultTextStyle(
          style: titleTextStyle ??
              dialogTheme.titleTextStyle ??
              theme.textTheme.headline1,
          child: Semantics(
            namesRoute: true,
            container: true,
            child: title,
          ),
        ),
      ));
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          label = semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.windows:
        case TargetPlatform.linux:
          label = semanticLabel ??
              MaterialLocalizations.of(context)?.alertDialogLabel;
      }
    }

    if (content != null) {
      if (content is Text) {}
      children.add(Flexible(
        child: Padding(
          padding: contentPadding,
          child: DefaultTextStyle(
            style: contentTextStyle ??
                dialogTheme.contentTextStyle ??
                theme.textTheme.subtitle1,
            child: content,
          ),
        ),
      ));
    }

    if (actions != null) {
      // children.add(ButtonTheme.bar(
      //   child: ButtonBar(
      //     children: actions,
      //   ),
      // ));
      // UNCOMMENT IF THE BELOW STATEMENT CAUSES PROBLEM
      children.add(ButtonBar(
        children: actions,
      ));
    }

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );

    if (label != null) {
      dialogChild = Semantics(
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    }

    return Dialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      child: dialogChild,
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String title;
  final String error;
  final VoidCallback onPressed;
  final String buttonTitle;

  const ErrorDialog({
    Key key,
    @required this.title,
    @required this.error,
    @required this.onPressed,
    @required this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: Text('$title'),
      content: Text(
        '$error',
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: onPressed,
          child: Text('$buttonTitle'),
        )
      ],
    );
  }
}
