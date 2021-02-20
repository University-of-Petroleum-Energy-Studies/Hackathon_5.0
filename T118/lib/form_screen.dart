import 'package:flutter/material.dart';
import 'package:trilochana/landing_screen.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String name;
  String address;
  String pin;
  String mobNumber;
  String gender;
  String dob;
  bool declaration;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Name is required';
                }

                return null;
              },
              onSaved: (String value) {
                name = value;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Address is required';
                }

                return null;
              },
              onSaved: (String value) {
                name = value;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPin() {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Pin Code',
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              keyboardType: TextInputType.number,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Pin code is required';
                }

                if (!RegExp(r"^[1-9][0-9]{5}$").hasMatch(value)) {
                  return 'Please enter correct pin code';
                }

                return null;
              },
              onSaved: (String value) {
                name = value;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobNumber() {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              keyboardType: TextInputType.phone,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Phone number is required';
                }

                if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
                  return 'Please enter correct phone number';
                }

                return null;
              },
              onSaved: (String value) {
                name = value;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGender() {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Gender',
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Gender is required';
                }

                return null;
              },
              onSaved: (String value) {
                name = value;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDob() {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'DOB',
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              keyboardType: TextInputType.datetime,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'DOB is required';
                }

                return null;
              },
              onSaved: (String value) {
                name = value;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeclaration() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: 'Read and agree the ',
              style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                new TextSpan(
                  text: 'Term & Conditions',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            if (!_formKey.currentState.validate()) {
              return;
            }
            _formKey.currentState.save();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LandingScreen(),
              ),
            );
          },
          splashColor: Colors.lightBlue,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width / 3,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.teal,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.amber,
                Colors.red,
              ],
              stops: [0.0, 1.0],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Registration',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildName(),
                        _buildAddress(),
                        _buildPin(),
                        _buildMobNumber(),
                        _buildGender(),
                        _buildDob(),
                        _buildDeclaration(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
