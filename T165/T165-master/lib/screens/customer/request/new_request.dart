import 'package:WSHCRD/models/request.dart';
import 'package:WSHCRD/screens/customer/request/new_request_second.dart';
import 'package:WSHCRD/screens/owner/categories.dart';
import 'package:WSHCRD/screens/signup/pick_location.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class NewRequestView extends StatefulWidget {
  static const routeName = 'NewRequestView';

  // Regex to check phone numbers
  RegExp _phoneRegExp = RegExp(
    r"(?:(?:\+?([1-9]|[0-9][0-9]|[0-9][0-9][0-9])\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([0-9][1-9]|[0-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?",
    caseSensitive: false,
    multiLine: true,
  );
  // Regex to check phone email
  RegExp _emailRegExp = RegExp(
    r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*",
    caseSensitive: false,
    multiLine: true,
  );
  @override
  _NewRequestViewState createState() => _NewRequestViewState();
}

class ListItem {
  String value;
  int id;

  ListItem(this.value, this.id);
}

class _NewRequestViewState extends State<NewRequestView> {
  Request request;
  List selections = <bool>[true, false];
  List<ListItem> itemList;
  TextEditingController itemController = new TextEditingController();

  @override
  void initState() {
    request = Request();
    itemList = [];
    super.initState();
  }

  Widget gap = SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'New Request'.toUpperCase(),
            style: TextStyle(color: kTitleColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Hero(
                                tag: 'hero',
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style: TextStyle(color: kGreenColor, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                              ),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: kBorderColor,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: kBorderColor,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: kBorderColor,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: kBorderColor,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: kBorderColor,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              Hero(
                                tag: 'hero2',
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      gap,
                      Text(
                        'Where do you stay?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      gap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/compass_green.png',
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    request.address ?? "Enter Address",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await pickLocationAndSetItToRequest();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Change',
                                style: TextStyle(fontWeight: FontWeight.bold, color: kGreenColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      gap,
                      Text(
                        'Select Category',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: MaterialButton(
                          onPressed: () => navigateAndGetCategory(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              request.category == null
                                  ? Text("Select",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black.withOpacity(0.5)))
                                  : Text(
                                      request.category,
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                    ),
                              Icon(Icons.expand_more),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                      gap,
                      Center(
                        child: ToggleButtons(
                          isSelected: selections,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: Text(
                                "LIST",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: Text(
                                'PARAGRAPH',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                          fillColor: kGreenColor,
                          selectedColor: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          onPressed: (index) {
                            setState(() {
                              selections[index] = true;
                              selections[(index - 1).abs()] = false;
                            });
                          },
                        ),
                      ),
                      gap,
                      Text(
                        'What are the things/help you need?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      gap,
                      Visibility(
                        visible: selections[0],
                        child: Column(
                          children: <Widget>[
                            Theme(
                              data: ThemeData(primaryColor: Colors.black, primaryColorDark: Colors.black),
                              child: TextFormField(
                                controller: itemController,
                                decoration: InputDecoration(
                                  hintText: 'Add an item...(example - Milk - 500ml)',
                                  border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.redAccent)),
                                ),
                                onFieldSubmitted: (newItem) {
                                  validateAndAddItemToRequest(newItem);
                                },
                              ),
                            ),
                            gap,
                            Column(
                              children: getSavedItems(),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: selections[1],
                        child: Theme(
                          data: ThemeData(primaryColor: Colors.black, primaryColorDark: Colors.black),
                          child: TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.redAccent)),
                            ),
                            onChanged: (newText) {
                              request.itemParagraph = newText;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5),
              child: MaterialButton(
                onPressed: () {
                  saveRequest();
                },
                color: kGreenColor,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'NEXT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  navigateAndGetCategory() async {
    // Navigate and get the selected category
    var _category = await Navigator.pushNamed(
      context,
      Categories.routeName,
    );
    setState(() {
      request.category = _category;
    });
  }

  getSavedItems() {
    List<Widget> savedItems = [];
    itemList.forEach((element) {
      savedItems.add(Card(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  element.value,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  setState(() {
                    itemList.remove(element);
                  });
                },
              )
            ],
          ),
        ),
      ));
    });
    if (savedItems.isEmpty) {
      savedItems.add(Container());
    }
    return savedItems;
  }

  /*
  Check if all the fileds are filled by the user and verify each entry
   */
  String checkIfValidInputsAndGetErrMessages() {
    String message = "";

    if (request.location == null || request.address == null) {
      message += "Please enter your address\n";
    }
    if (request.category == null) {
      message += 'Please select a category\n';
    }

    if (request.type == Request.LIST && (request.itemArray == null || request.itemArray.isEmpty)) {
      message += 'Please add atleast one item in the list';
    } else if (request.type == Request.PARAGRAPH && (request.itemParagraph == null || request.itemParagraph.isEmpty)) {
      message += 'Please add atleast one item in the paragraph';
    } else if (request.type == Request.PARAGRAPH) {
      if (containsContactInfo(request.itemParagraph)) {
        message += 'Posting contact information is not allowed';
      }
    }
    return message;
  }

  containsContactInfo(text) {
    return containsEmail(text) || containsPhone(text);
  }

  containsEmail(String text) {
    bool val = widget._emailRegExp.hasMatch(text);
    if (val) print('Email found');
    return val;
  }

  containsPhone(String text) {
    bool val = widget._phoneRegExp.hasMatch(text);
    if (val) print('phone found');
    return val;
  }

  saveRequest() {
    if (selections[0]) {
      request.type = Request.LIST;
      request.itemArray = itemList.map((e) => e.value).toList();
      request.itemParagraph = null;
    } else {
      request.type = Request.PARAGRAPH;
      request.itemArray = null;
    }
    String messages = checkIfValidInputsAndGetErrMessages();

    if (messages == null || messages.isEmpty) {
      Navigator.pushNamed(context, NewRequestSecondView.routeName, arguments: request.toJson());
    } else {
      BotToast.showText(text: messages);
    }
  }

  /*
  Every time new item is added, check for its validity and don't allow contact info.
   */
  void validateAndAddItemToRequest(String newItem) {
    // validate entry before adding to db
    if (newItem.isEmpty) {
      Global.showToastMessage(context: context, msg: "Item cannot be empty");
    } else if (containsContactInfo(newItem)) {
      // check for presense of contact info in the text
      Global.showToastMessage(context: context, msg: "Posting contact information is not allowed");
    } else {
      itemList.add(ListItem(newItem, DateTime.now().millisecondsSinceEpoch));
      itemController.clear();
    }
  }

  /*
  Get location from google maps and set it to the request
   */

  Future<void> pickLocationAndSetItToRequest() async {
    // Get Shop location from google maps
    var _pickResult = await Navigator.pushNamed(
      context,
      PickLocation.routeName,
    );
    PickResult pickResult = _pickResult as PickResult;
    if (pickResult != null && pickResult.geometry != null) {
      request.location = GeoFirePoint(pickResult.geometry.location.lat, pickResult.geometry.location.lng);
      request.address = pickResult.formattedAddress;
      setState(() {});
    }
  }
}
