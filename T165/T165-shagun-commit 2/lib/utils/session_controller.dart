import 'dart:async';
import 'dart:convert';

import 'package:WSHCRD/models/customer.dart';
import 'package:WSHCRD/models/owner.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/owner.dart';

class SessionController {
  static const String KEY_UID = "uid";
  static const String KEY_DISPLAYNAME = "displayName";
  static const String KEY_PHONENUMBER = "phoneNumber";
  static const String KEY_BUSINESSNAME = "businessName";
  static const String KEY_CATEGORY = "category";
  static const String KEY_OWNER = "owner";
  static const String KEY_USER_TYPE = "userType";
  static const String KEY_SELECTED_RADIUS_INDEX = "selectedIndex";
  static SharedPreferences _sharedPrefs;
  static StreamController<int> radiusController = StreamController<int>.broadcast();
  static StreamController<Owner> ownerController = StreamController<Owner>.broadcast();
  static const String KEY_CUSTOMER = "customer";

  static void initialize(SharedPreferences sharedPreferences) {
    _sharedPrefs = sharedPreferences;
  }

  /*
  Save the owner to local storage
   */
  static void saveOwnerInfoToLocal(Owner owner) {
    SessionController.setUid(owner.uid);
    SessionController.setPhoneNumber(owner.phoneNumber);
    SessionController.setBusinessName(owner.businessName);
    SessionController.setCategory(owner.category);
    SessionController.setUserType(Global.OWNER);
    _sharedPrefs.setString(KEY_OWNER, jsonEncode(owner.toJson()));
    ownerController.add(owner);
  }

  static Owner getOwnerInfoFromLocal() {
    return Owner.fromJson(jsonDecode(_sharedPrefs.getString(KEY_OWNER)));
  }

  /*
  Save the customer to local storage
   */
  static void saveCustomerInfoToLocal(Customer customer) {
    SessionController.setUid(customer.uid);
    SessionController.setPhoneNumber(customer.phoneNumber);
    SessionController.setDisplayName(customer.displayName);
    SessionController.setUserType(Global.CUSTOMER);

    _sharedPrefs.setString(KEY_CUSTOMER, jsonEncode(customer.toJson()));
  }

  static Customer getCustomerInfoFromLocal() {
    return Customer.fromJson(jsonDecode(_sharedPrefs.getString(KEY_CUSTOMER)));
  }

  static void setUid(String uid) {
    _sharedPrefs.setString(KEY_UID, uid);
  }

  static String getUid() {
    return _sharedPrefs.getString(KEY_UID) ?? '';
  }

  static void setDisplayName(String displayName) {
    _sharedPrefs.setString(KEY_DISPLAYNAME, displayName);
  }

  static String getDisplayName() {
    return _sharedPrefs.getString(KEY_DISPLAYNAME) ?? '';
  }

  static void setUserType(String type) {
    _sharedPrefs.setString(KEY_USER_TYPE, type);
  }

  static String getUserType() {
    return _sharedPrefs.getString(KEY_USER_TYPE) ?? '';
  }

  static void setPhoneNumber(String phoneNumber) {
    _sharedPrefs.setString(KEY_PHONENUMBER, phoneNumber);
  }

  static String getPhoneNumber() {
    return _sharedPrefs.getString(KEY_PHONENUMBER) ?? '';
  }

  static void setBusinessName(String businessName) {
    _sharedPrefs.setString(KEY_BUSINESSNAME, businessName);
  }

  static String getBusinessName() {
    return _sharedPrefs.getString(KEY_BUSINESSNAME) ?? '';
  }

  static void setCategory(String category) {
    _sharedPrefs.setString(KEY_CATEGORY, category);
  }

  static String getCategory() {
    return _sharedPrefs.getString(KEY_CATEGORY) ?? '';
  }

  static clearSession() {
    return _sharedPrefs.clear();
  }

  static int getSelectedRadiusIndex() {
    return _sharedPrefs.getInt(KEY_SELECTED_RADIUS_INDEX) ?? 0;
  }

  static setSelectedRadiusIndex(int radius) {
    radiusController.add(radius);
    return _sharedPrefs.setInt(KEY_SELECTED_RADIUS_INDEX, radius);
  }

  /*
  Method is used to emit the radius changes in the app so that other widgets can update
   */
  static getRadiusStream() {
    Future.delayed(const Duration(milliseconds: 500), () {
      // just to ensure that the stream gets the data when needed
      radiusController.add(getSelectedRadiusIndex());
    });
    return radiusController.stream.asBroadcastStream();
  }

  /*
  Method is used to emit the owner changes in the app so that other widgets can update
   */

  static getOwnerStream() {
    Future.delayed(const Duration(milliseconds: 500), () {
      // just to ensure that the stream gets the data when needed
      ownerController.add(getOwnerInfoFromLocal());
    });
    return ownerController.stream.asBroadcastStream();
  }
}
