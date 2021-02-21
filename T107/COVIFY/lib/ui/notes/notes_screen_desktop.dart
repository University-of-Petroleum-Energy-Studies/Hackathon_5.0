
import 'package:covid19/constants/colors.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:covid19/constants/text_styles.dart';
import 'package:covid19/utils/device/device_utils.dart';
import 'package:covid19/constants/dimens.dart';
import 'package:covid19/widgets/sized_box_height_widget.dart';



class NotesScreenDesktop extends StatefulWidget {
  @override
  _NotesScreenDesktopState createState() => _NotesScreenDesktopState();
}

class _NotesScreenDesktopState extends State<NotesScreenDesktop> {

  TextEditingController taskTitleInputController=new TextEditingController();
  TextEditingController taskDescripInputController=new TextEditingController();

  @override
  initState() {
    taskTitleInputController = new TextEditingController();
    taskDescripInputController = new TextEditingController();
    super.initState();

    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  _showDialog() async {
    await showDialog<String>(
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                maxLength: 5,
                maxLines: 1,
                autofocus: true,
                decoration: InputDecoration(labelText: 'Day',hintText: 'Day1'),
                controller: taskTitleInputController,
              ),
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                minLines: null,
                maxLength: 200,
                expands: true,
                decoration: InputDecoration(labelText: 'How do you feel ?', border: OutlineInputBorder(),focusColor: AppColors.primaryColor),
                controller: taskDescripInputController,
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Add'),
              onPressed: () {

                if (taskDescripInputController.text.isNotEmpty &&
                    taskTitleInputController.text.isNotEmpty) {
                  Firestore.instance
                      .collection('todos')
                      .add({
                    "title": taskTitleInputController.text.toUpperCase(),
                    "description": taskDescripInputController.text,
                    "timestamp": new DateTime.now()
                  })
                      .then((result) => {
                    Navigator.of(context, rootNavigator: true).pop(),
                    taskTitleInputController.clear(),
                    taskDescripInputController.clear(),
                  })
                      .catchError((err) => print(err));
                }
              })
        ],
      ), context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    final screenWidth = DeviceUtils.getScaledWidth(context, 1);
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: new Icon(Icons.add,size: 30,color: Colors.white,),
        onPressed: ()=>_showDialog(),
      ),
      body: new StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("todos").orderBy("timestamp", descending: false).snapshots(),
          builder : (context , snapshot){
            if (!snapshot.hasData) return new Center(child : new CircularProgressIndicator());

            return new Container(
              padding: const EdgeInsets.all(20),
              margin: EdgeInsets.only(
                left: screenWidth / 7,
                right: screenWidth / 7,
              ),
              child: new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder:(context , index)=>
                new Column(
                  children: [
                    new Card(
                      elevation: 8,
                      child: new ListTile(
                        title : Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: new Text(snapshot.data.documents[index]["title"],style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold, fontFamily: 'pSans'),),
                        ),
                        subtitle:new Text(snapshot.data.documents[index]["description"],style: TextStyle(fontSize: 20,color: Colors.grey[800],fontWeight: FontWeight.bold, fontFamily: 'pSans'),),
                        trailing: new IconButton(
                          icon: new Icon(Icons.delete,size: 30,color: Colors.red[800],),
                          onPressed: (){
                            snapshot.data.documents[index].reference.delete();
                          },
                        ),
                      ),
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10)),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

}

