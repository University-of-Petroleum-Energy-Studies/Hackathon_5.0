import 'dart:async';

import 'package:WSHCRD/firebase_services/basic_firebase.dart';
import 'package:WSHCRD/models/ledger.dart';
import 'package:WSHCRD/models/owner.dart';
import 'package:WSHCRD/models/payment.dart';
import 'package:WSHCRD/models/request.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../models/customer.dart';

class OwnerController {
  static CollectionReference requests = Firestore.instance.collection("requests");
  static CollectionReference payments = Firestore.instance.collection("payments");
  static CollectionReference customers = Firestore.instance.collection("customers");
  static CollectionReference ledgers = Firestore.instance.collection("ledgers");

  static Future<List<dynamic>> getCustomers() async {
    // Get all Customers
    String uid = SessionController.getUid();
    QuerySnapshot docSnapShot = await db.collection("customers").where("ownerId", isEqualTo: uid).getDocuments();

    List<dynamic> customers = [];
    for (int i = 0; i < docSnapShot.documents.length; i++) {
      customers.add(docSnapShot.documents[i]);
    }

    return customers;
  }

  static Stream<QuerySnapshot> getCustomersStream(String ownerId) {
    return customers.where("ownerIds", arrayContains: ownerId).snapshots();
  }

  static getAllLedgersForOwner(String ownerId) {
    return ledgers.where("ownerId", isEqualTo: ownerId).orderBy('lastUpdateDateInEpoc', descending: true).snapshots();
  }

  static Stream<QuerySnapshot> getCustomerPayments(String ledgerId) {
    return payments.where("ledgerId", isEqualTo: ledgerId).orderBy('dateTimeInEpoc', descending: true).snapshots();
  }

  static Future<Ledger> addCustomer(Customer customer) async {
    try {
      Owner owner = SessionController.getOwnerInfoFromLocal();
      DocumentReference documentReference = db.collection("customers").document();
      bool customerAlreadyExists = false;
      if (customer.phoneNumber != null && customer.phoneNumber.isNotEmpty) {
        QuerySnapshot querySnapshot =
            await customers.where('phoneNumber', isEqualTo: customer.phoneNumber).getDocuments();
        if (querySnapshot.documents.isNotEmpty) {
          customer.customerId = querySnapshot.documents[0].documentID;
          customerAlreadyExists = true;
        } else {
          customer.customerId = documentReference.documentID;
        }
      } else {
        customer.customerId = documentReference.documentID;
      }

      if (!customerAlreadyExists) {
        await documentReference.setData(customer.toJson());
      }

      /*

      This is to create a new ledger entry in firebase so that we can keep track of the users etc
       */

      DocumentReference ledgerDocumentReference = ledgers.document();
      Ledger ledger = Ledger();
      ledger.customerId = customer.customerId;
      ledger.ownerId = owner.ownerId;
      ledger.ledgerId = ledgerDocumentReference.documentID;
      DateTime dateTime = DateTime.now().toUtc();
      ledger.creationDateInEpoc = dateTime.millisecondsSinceEpoch;
      ledger.creationDate = DateFormat(Global.dateTimeFormat).format(dateTime);
      ledger.hasPayments = false;
      ledger.balance = 0;
      await ledgerDocumentReference.setData(ledger.toJson());
      return ledger;
    } catch (e) {
      return null;
    }
  }

  static Future<Customer> getCustomer(String customerId) async {
    DocumentSnapshot doc = await db.collection("customers").document(customerId).get();
    return Customer.fromJson(doc.data);
  }

  static Future<String> deleteCustomer(String customerId, String ledgerId) async {
    await ledgers.document(ledgerId).delete();
    return "success";
  }

  static Future<dynamic> addPayment(Payment payment) async {
    return await payments.document().setData(payment.toJson());
  }

  static Future<void> updateCustomerPhoneNumber(Customer customer) async {
    return db.collection("customers").document(customer.customerId).updateData({"phoneNumber": customer.phoneNumber});
  }

  static Future<Owner> getOwnerInfo(String uid) async {
    print(uid);
    QuerySnapshot querySnapshot = await db.collection("owners").where("uid", isEqualTo: uid).getDocuments();
    if (querySnapshot.documents.length > 0) {
      return Owner.fromJson(querySnapshot.documents[0].data);
    } else {
      return null;
    }
  }

  static getAllActiveNearByRequestsForRadius(double radius, LocationData myLocation) {
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: myLocation.latitude, longitude: myLocation.longitude);
    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: requests)
        .within(center: center, radius: radius, field: 'location', strictMode: true);
    return stream;
  }

  static getLastPayment(String customerId) {
    return payments
        .where('customerId', isEqualTo: customerId)
        .orderBy('dateTimeInEpoc', descending: true)
        .limit(1)
        .snapshots();
  }

  static getTotalBalance(String ownerId) {
    return ledgers.where('ownerId', isEqualTo: ownerId).snapshots();
  }

  static updateCustomerName(Customer customer) {
    return db.collection("customers").document(customer.customerId).updateData({"displayName": customer.displayName});
  }
}
