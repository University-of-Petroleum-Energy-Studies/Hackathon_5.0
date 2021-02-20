import 'package:WSHCRD/common/priority.dart';
import 'package:WSHCRD/firebase_services/customer_controller.dart';
import 'package:WSHCRD/models/request.dart';
import 'package:WSHCRD/screens/customer/home/customer_home.dart';
import 'package:WSHCRD/screens/customer/request/request_preview.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewRequestSecondView extends StatefulWidget {
  static const routeName = 'NewRequestSecondView';
  Request request;

  setRequest(Request request) {
    this.request = request;
  }

  @override
  _NewRequestSecondViewState createState() => _NewRequestSecondViewState();
}

class ListItem {
  String value;
  int id;

  ListItem(this.value, this.id);
}

class _NewRequestSecondViewState extends State<NewRequestSecondView> {
  Request request;
  List paymentRequiredSelection = <bool>[false, true];

  @override
  void initState() {
    request = widget.request;
    request.setRequestVisibility(2);
    request.setPriority(0);
    super.initState();
  }

  Widget gap = SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<Request>(
        create: (BuildContext context) {
          return request;
        },
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
                                    width: 20,
                                    height: 20,
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
                                    width: 35,
                                    height: 35,
                                    child: Center(
                                      child: Text(
                                        '2',
                                        style: TextStyle(color: kGreenColor, fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ),
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
                          'Select priority',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        gap,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(child: PriorityWidget(0)),
                            Expanded(child: PriorityWidget(1)),
                            Expanded(child: PriorityWidget(2)),
                          ],
                        ),
                        gap,
                        Text(
                          'Does this task requires payment to complete?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        gap,
                        ToggleButtons(
                          isSelected: paymentRequiredSelection,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: Text(
                                "Yes",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: Text(
                                'No',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                          fillColor: kGreenColor,
                          selectedColor: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          onPressed: (index) {
                            setState(() {
                              paymentRequiredSelection[index] = true;
                              paymentRequiredSelection[(index - 1).abs()] = false;
                              request.paymentRequired = paymentRequiredSelection[0];
                            });
                          },
                        ),
                        gap,
                        Text(
                          'Who should see this request?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        gap,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(child: RequestVisibilityWidget(2)),
                            Expanded(child: RequestVisibilityWidget(0)),
                          ],
                        ),
                        gap,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: 1,
                              ),
                            ),
                            Flexible(flex: 4, child: RequestVisibilityWidget(1)),
                            Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: 1,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5),
                child: MaterialButton(
                  onPressed: () {
                    createNewRequest();
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
                          'POST WISH',
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
      ),
    );
  }

  /*
  Initiate new Request creation and save it to firebase
   */

  Future<void> createNewRequest() async {
    showLoadingScreen();
    print(SessionController.getCustomerInfoFromLocal().customerId);
    request.ownerId = SessionController.getCustomerInfoFromLocal().customerId;
    DateTime dateTime = DateTime.now().toUtc();
    request.creationDateInEpoc = dateTime.millisecondsSinceEpoch;
    request.creationDate = DateFormat(Global.dateTimeFormat).format(dateTime);
    await CustomerController.addRequest(request);
    closeLoadingScreen();
    BotToast.showText(text: "Requested created successfully");
    Navigator.pushNamedAndRemoveUntil(
        context, RequestPreviewView.routeName, (route) => route.settings.name == CustomerHomeScreen.routeName,
        arguments: request.toJson());
  }
}

class RequestVisibilityWidget extends StatefulWidget {
  int index;

  RequestVisibilityWidget(this.index);

  @override
  _RequestVisibilityWidgetState createState() => _RequestVisibilityWidgetState();
}

class _RequestVisibilityWidgetState extends State<RequestVisibilityWidget> {
  List<String> values = ['Stores only', 'Nearby users only', 'Both'];

  @override
  Widget build(BuildContext context) {
    Request request = Provider.of<Request>(context);
    return GestureDetector(
      onTap: () {
        request.setRequestVisibility(widget.index);
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              values[widget.index],
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: request.requestVisibility == widget.index ? kGreenColor : Colors.white,
          border: Border.all(color: kBorderColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}
