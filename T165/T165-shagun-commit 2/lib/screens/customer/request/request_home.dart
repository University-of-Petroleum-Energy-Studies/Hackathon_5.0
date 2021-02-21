import 'package:WSHCRD/common/request_card.dart';
import 'package:WSHCRD/firebase_services/customer_controller.dart';
import 'package:WSHCRD/models/request.dart';
import 'package:WSHCRD/utils/global.dart';
import 'package:WSHCRD/utils/session_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestHomeView extends StatefulWidget {
  static const routeName = 'RequestHomeView';

  @override
  _RequestHomeViewState createState() => _RequestHomeViewState();
}

class _RequestHomeViewState extends State<RequestHomeView> {
  @override
  Widget build(BuildContext context) {
    print('_RequestHomeViewState called');
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'My Wishes'.toUpperCase(),
              style: TextStyle(color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(tabs: [
              Tab(
                child: Text(
                  'Active Wishes'.toUpperCase(),
                  style: TextStyle(color: kTitleColor),
                ),
              ),
              Tab(
                child: Text(
                  'Expired Wishes'.toUpperCase(),
                  style: TextStyle(color: kTitleColor),
                ),
              ),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: CustomerController.getAllActiveRequests(
                        SessionController.getCustomerInfoFromLocal().customerId,
                        DateTime.now().toUtc().subtract(Duration(hours: 24))),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.documents.isNotEmpty) {
                        List<Request> requests = snapshot.data.documents.map((e) => Request.fromJson(e.data)).toList();
                        if (requests.isNotEmpty) {
                          return ListView.builder(
                              itemCount: requests.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                print('requests list called' + index.toString());
                                return Container(
                                  decoration:
                                      BoxDecoration(shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                                          //color: const Color(0xFF66BB6A),
                                          boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 8.0,
                                        ),
                                      ]),
                                  margin: EdgeInsets.all(10),
                                  child: RequestCard(
                                    requests[index],
                                    index,
                                    type: RequestCard.MY_WISHES,
                                    onDeleteClicked: () async {
                                      showLoadingScreen();
                                      await CustomerController.deleteRequest(requests[index].requestId);
                                      closeLoadingScreen();
                                      BotToast.showText(text: "Request deleted successfully");
                                    },
                                  ),
                                );
                              });
                        }
                      }
                      return Container();
                    }),
              ),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: CustomerController.getAllExpiredRequests(
                        SessionController.getCustomerInfoFromLocal().customerId,
                        DateTime.now().toUtc().subtract(Duration(hours: 24))),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Request> requests = snapshot.data.documents.map((e) => Request.fromJson(e.data)).toList();
                        if (requests.isNotEmpty) {
                          return ListView.builder(
                              itemCount: requests.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Container(
                                  decoration:
                                      BoxDecoration(shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                                          //color: const Color(0xFF66BB6A),
                                          boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 8.0,
                                        ),
                                      ]),
                                  margin: EdgeInsets.all(10),
                                  child: RequestCard(
                                    requests[index],
                                    index,
                                    type: RequestCard.MY_WISHES,
                                    onDeleteClicked: () async {
                                      showLoadingScreen();
                                      await CustomerController.deleteRequest(requests[index].requestId);
                                      closeLoadingScreen();
                                      BotToast.showText(text: "Request deleted successfully");
                                    },
                                  ),
                                );
                              });
                        }
                      }
                      return Container();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
