import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LandingScreen();
}

class _LandingScreen extends State<LandingScreen> {
  static List<String> numbers = [null];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _buildParentMobNumber() {
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
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Parent's Phone Number",
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              keyboardType: TextInputType.phone,
              validator: (String value) {
                if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
                  return 'Please enter correct phone number';
                }

                return null;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            if (!_formKey.currentState.validate()) {
              return;
            }
            _formKey.currentState.save();
          },
          splashColor: Colors.lightBlue,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width / 4,
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
              'Submit',
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

  @override
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
          child: Container(
            margin: EdgeInsets.only(top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Add Contact Details',
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
                        _buildParentMobNumber(),
                        ..._getAllNumbers(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildSubmit(),
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

  List<Widget> _getAllNumbers() {
    List<Widget> numberFields = [];

    for (int i = 0; i < numbers.length; i++) {
      numberFields.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: NumberField(i),
              ),
              SizedBox(
                width: 16,
              ),
              _addRemoveButton(i == numbers.length - 1, i),
            ],
          ),
        ),
      );
    }
    return numberFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          numbers.insert(0, null);
        } else
          numbers.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class NumberField extends StatefulWidget {
  final int index;
  NumberField(this.index);

  @override
  _NumberFieldState createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _LandingScreen.numbers[widget.index] ?? '';
    });

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
              controller: _nameController,
              onChanged: (v) => _LandingScreen.numbers[widget.index] = v,
              decoration: InputDecoration(
                labelText: "Add another contact number",
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              keyboardType: TextInputType.phone,
              validator: (String value) {
                if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
                  return 'Please enter correct phone number';
                }

                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
