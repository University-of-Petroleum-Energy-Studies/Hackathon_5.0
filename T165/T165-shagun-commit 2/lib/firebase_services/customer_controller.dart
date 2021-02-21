import 'package:WSHCRD/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

class CustomerController {
  static CollectionReference requests = Firestore.instance.collection("requests");

  static Future<dynamic> addRequest(Request request) async {
    DocumentReference documentReference = requests.document();
    request.requestId = documentReference.documentID;
    return documentReference.setData(request.toJson());
  }

  static getAllActiveRequests(String customerId, DateTime dateTime) {
    return requests
        .where('ownerId', isEqualTo: customerId)
        .endAt([dateTime.millisecondsSinceEpoch])
        .orderBy('creationDateInEpoc', descending: true)
        .snapshots();
  }

  static getAllActiveNearByRequestsForRadius(DateTime dateTime, double radius, LocationData myLocation) {
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: myLocation.latitude, longitude: myLocation.longitude);
    Stream<List<DocumentSnapshot>> stream =
        geo.collection(collectionRef: requests).within(center: center, radius: radius, field: 'location');
    return stream;
  }

  static getAllExpiredRequests(String customerId, DateTime dateTime) {
    return requests
        .where('ownerId', isEqualTo: customerId)
        .startAt([dateTime.millisecondsSinceEpoch])
        .orderBy('creationDateInEpoc', descending: true)
        .snapshots();
  }

  static deleteRequest(String requestId) {
    return requests.document(requestId).delete();
  }
}
