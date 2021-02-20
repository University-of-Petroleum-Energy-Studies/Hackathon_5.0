import 'dart:ui';

import 'package:WSHCRD/common/category_label.dart';
import 'package:WSHCRD/common/priority.dart';
import 'package:WSHCRD/models/request.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:timeago/timeago.dart' as timeago;

class RequestCard extends StatefulWidget {
  static const MY_WISHES = "MYWISHES";
  static const PREVIEW = "PREVIEW";
  static const NEARBY = "NEARBY";

  Request request;
  int index;
  String type;
  Function onDeleteClicked, onTrackClicked;
  Color priorityButtonFillColor;
  Function onTap;
  int maxPreviewCount;
  bool showFullCard = false;
  LocationData currentLocation;

  RequestCard(this.request, this.index,
      {this.type = PREVIEW,
      this.onDeleteClicked,
      this.onTrackClicked,
      this.priorityButtonFillColor = Colors.white,
      this.maxPreviewCount = 3,
      this.currentLocation,
      this.onTap});

  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    print('_RequestCardState build called');
    DateTime now = DateTime.now().toUtc();
    DateTime creationDate = now.subtract(Duration(
        milliseconds: now
            .difference(DateTime.fromMillisecondsSinceEpoch(
                widget.request.creationDateInEpoc ?? 0,
                isUtc: true))
            .inMilliseconds));
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.showFullCard = !widget.showFullCard;
          print(widget.showFullCard);
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getDistanceIndicator(),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      timeago.format(creationDate),
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'I need help with following things:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            getItems(widget.request),
            SizedBox(
              height: 20,
            ),
            getTags()
          ],
        ),
        decoration: BoxDecoration(
          color: kColorSlabs[widget.index % kColorSlabs.length],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  getItems(Request request) {
    List<Widget> items = [];
    if (request.type == Request.LIST) {
      int count = 1;
      for (String item in request.itemArray) {
        if (!widget.showFullCard &&
            request.itemArray.length >= (widget.maxPreviewCount) &&
            widget.maxPreviewCount == count + 1) {
          items.add(
            Text(
              '${count++}. $item ...',
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else {
          items.add(
            Text(
              '${count++}. $item',
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        if (!widget.showFullCard && widget.maxPreviewCount == count) {
          break;
        }
      }
    } else {
      items.add(
        widget.showFullCard
            ? Text(
                request.itemParagraph,
                overflow: TextOverflow.clip,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(
                request.itemParagraph,
                maxLines: widget.maxPreviewCount - 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  getTags() {
    if (widget.type == RequestCard.PREVIEW) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: PriorityWidget(
              widget.request.priority ?? 0,
              request: widget.request,
              readOnly: true,
              fillColor: widget.priorityButtonFillColor,
            ),
          ),
          Expanded(
            child: CategoryLabel(
              widget.request.category,
            ),
          ),
        ],
      );
    } else if (widget.type == RequestCard.MY_WISHES) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: widget.onDeleteClicked,
            child: CategoryLabel(
              'DELETE THIS',
              fillColor: Color(0xfffe0e70),
              borderWidth: 2,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ],
      );
    } else if (widget.type == RequestCard.NEARBY) {
      return Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: PriorityWidget(
              widget.request.priority ?? 0,
              request: widget.request,
              readOnly: true,
              fillColor: widget.priorityButtonFillColor,
            ),
          ),
          Flexible(
            flex: 1,
            child: CategoryLabel(
              widget.request.category,
            ),
          ),
        ],
      );
    }
  }

  getDistanceIndicator() {
    if (widget.type == RequestCard.NEARBY) {
      double distance = GeoFirePoint.distanceBetween(
              to: widget.request.location.coords,
              from: Coordinates(widget.currentLocation.latitude,
                  widget.currentLocation.longitude)) *
          1000;
      String distanceText;
      if (distance > 1000) {
        int newDistance = distance ~/ 1000;
        distanceText =
            '$newDistance ' + (newDistance > 1 ? 'kms away' : 'km away');
      } else {
        distanceText = '${distance.toInt()} ' +
            (distance > 1 ? 'meters away' : 'meter away');
      }
      return Row(
        children: <Widget>[
          Icon(Icons.location_on),
          SizedBox(
            width: 10,
          ),
          Text(distanceText),
        ],
      );
    } else {
      return Container();
    }
  }
}
