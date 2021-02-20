import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class Request extends ChangeNotifier {
  static const PARAGRAPH = "Paragraph";
  static const LIST = "List";
  static const REQ_VISIBILITY_STORES_ONLY = 0;
  static const REQ_VISIBILITY_NEARBY_ONLY = 1;
  static const REQ_VISIBILITY_BOTH = 2;
  String requestId;
  String address;
  int priority;
  String category;
  String type;
  List<String> itemArray;
  String itemParagraph;
  GeoFirePoint location;
  bool paymentRequired;
  int requestVisibility;
  int creationDateInEpoc;
  String creationDate;
  String ownerId;

  setPriority(priority) {
    this.priority = priority;
    notifyListeners();
  }

  setRequestVisibility(requestVisibility) {
    this.requestVisibility = requestVisibility;
    notifyListeners();
  }

  Request(
      {this.address,
      this.requestId,
      this.priority,
      this.category,
      this.type,
      this.itemArray,
      this.itemParagraph,
      this.paymentRequired,
      this.requestVisibility,
      this.creationDateInEpoc,
      this.creationDate,
      this.location,
      this.ownerId});

  Request.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    address = json['address'];
    priority = json['priority'];
    category = json['category'];
    type = json['type'];
    itemArray = json['itemArray']?.cast<String>();
    itemParagraph = json['itemParagraph'];
    paymentRequired = json['paymentRequired'];
    requestVisibility = json['requestVisibility'];
    creationDateInEpoc = json['creationDateInEpoc'];
    creationDate = json['creationDate'];
    ownerId = json['ownerId'];
    GeoPoint geoPoint = json['location']['geopoint'];
    location = GeoFirePoint(geoPoint.latitude, geoPoint.longitude);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['requestId'] = this.requestId;
    data['priority'] = this.priority;
    data['category'] = this.category;
    data['type'] = this.type;
    data['itemArray'] = this.itemArray;
    data['itemParagraph'] = this.itemParagraph;
    data['paymentRequired'] = this.paymentRequired;
    data['requestVisibility'] = this.requestVisibility;
    data['creationDateInEpoc'] = this.creationDateInEpoc;
    data['creationDate'] = this.creationDate;
    data['ownerId'] = this.ownerId;
    if (this.location != null) {
      data['location'] = this.location.data;
    }
    return data;
  }
}

class Location {
  GeoFirePoint geoFirePoint;

  Location({this.geoFirePoint});

  Location.fromJson(Map<String, dynamic> json) {
    geoFirePoint = new GeoFirePoint(json['latitude'], json['longitude']);
  }

  static Map<String, dynamic> toJson(GeoFirePoint geoFirePoint) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = geoFirePoint.latitude;
    data['longitude'] = geoFirePoint.longitude;
    return data;
  }
}
