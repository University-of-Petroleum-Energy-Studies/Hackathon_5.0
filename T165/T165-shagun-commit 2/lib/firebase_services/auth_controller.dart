import 'package:WSHCRD/firebase_services/basic_firebase.dart';
import 'package:WSHCRD/models/customer.dart';
import 'package:WSHCRD/models/owner.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static Function onPhoneAuthSuccess;
  static Function onPhoneAuthFailure;
  static String verificationId;

  // Functions that relates with Phone Authentication
  static final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
    verificationId = verId;
    print(verificationId);
  };

  static final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
    onPhoneAuthSuccess(verId);
  };

  static final PhoneVerificationFailed verfiFailed = (AuthException exception) {
    onPhoneAuthFailure(exception);
  };

  static Future<FirebaseUser> getCurrentUser() {
    return FirebaseAuth.instance.currentUser();
  }

  static Future<void> requestPhoneAuthentication(
      // Request Phone Authentication
      {phoneNo: String,
      onSuccess: Function,
      onVerificationCompleted: Function,
      onFailure: Function}) async {
    onPhoneAuthSuccess = onSuccess;
    onPhoneAuthFailure = onFailure;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 30),
        verificationFailed: verfiFailed,
        verificationCompleted: onVerificationCompleted);
  }

  static Future<String> signUpAsCustomer(Customer customer) async {
    try {
      // Register the customer info to firestore
      final customerCollection = Firestore.instance.collection("customers");
      QuerySnapshot customers =
          await customerCollection.where("phoneNumber", isEqualTo: customer.phoneNumber).getDocuments();
      if (customers.documents.isNotEmpty) {
        await customerCollection.document(customers.documents[0].documentID).updateData({
          "uid": customer.uid,
          "displayName": customer.displayName,
          "phoneNumber": customer.phoneNumber,
        });
        return customers.documents[0].documentID;
      } else {
        try {
          DocumentReference documentReference = customerCollection.document();
          customer.customerId = documentReference.documentID;
          documentReference.setData(customer.toJson());
          return customer.customerId;
        } catch (e) {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }

  static Future<void> changeFullCustomerInfo(Customer customer) async {
    await db.collection("customers").document(customer.customerId).updateData(customer.toJson());
  }

  static Future<void> changeFullOwnerInfo(Owner owner) async {
    await db.collection("owners").document(owner.ownerId).updateData(owner.toJson());
  }

  static Future<void> changeCustomerInfo(Customer customer) async {
    // Change Customer Info
    String uid = SessionController.getUid();
    QuerySnapshot docSnapShot = await db.collection("customers").where('uid', isEqualTo: uid).getDocuments();
    if (docSnapShot == null) return;

    if (docSnapShot.documents.length > 0) {
      docSnapShot.documents[0].reference.updateData(customer.toJson());
      SessionController.saveCustomerInfoToLocal(customer);
    }
  }

  static Future<String> signUpAsOwner(Owner owner) async {
    try {
      // Register the owner info to firestore
      final ownerCollection = Firestore.instance.collection("owners");
      QuerySnapshot owners = await ownerCollection.where("phoneNumber", isEqualTo: owner.phoneNumber).getDocuments();
      if (owners.documents.isNotEmpty) {
        await ownerCollection.document(owners.documents[0].documentID).updateData({
          "uid": owner.uid,
          "displayName": owner.businessName,
          "phoneNumber": owner.phoneNumber,
        });
        return owners.documents[0].documentID;
      } else {
        DocumentReference ownerDocumentReference = ownerCollection.document();
        owner.ownerId = ownerDocumentReference.documentID;
        await ownerDocumentReference.setData(owner.toJson());
        return owner.ownerId;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<void> changeOwnerInfo(owner) async {
    String uid = SessionController.getUid();
    QuerySnapshot docSnapShot = await db.collection("owners").where('uid', isEqualTo: uid).getDocuments();
    if (docSnapShot == null) return;

    if (docSnapShot.documents.length > 0) {
      docSnapShot.documents[0].reference.updateData(owner.toJson());
      SessionController.saveOwnerInfoToLocal(owner);
    }
  }

  Future<List<dynamic>> isLogin(String phoneNumber) async {
    QuerySnapshot docSnapShot =
        await db.collection('owners').where('phoneNumber', isEqualTo: phoneNumber).getDocuments();

    List<dynamic> result = [];

    if (docSnapShot == null || docSnapShot.documents.length == 0) {
      QuerySnapshot docSnapShot =
          await db.collection("customers").where('phoneNumber', isEqualTo: phoneNumber).getDocuments();
      if (docSnapShot == null || docSnapShot.documents.length == 0) {
        return result;
      } else {
        result.add(Global.CUSTOMER);
        result.add(docSnapShot.documents[0].data);
        return result;
      }
    } else {
      result.add(Global.OWNER);
      result.add(Owner.fromJson(docSnapShot.documents[0].data));
      return result;
    }
  }

  static Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
