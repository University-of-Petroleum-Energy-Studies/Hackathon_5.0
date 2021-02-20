class Payment {
  double amount;
  int dateTimeInEpoc;
  String dateTime;
  String type;
  double balance;
  String ledgerId;
  String ownerId;
  String customerId;
  String remarks;

  static const GET = "get";

  static const GIVE = "give";

  Payment({this.amount, this.dateTime, this.dateTimeInEpoc, this.type, this.balance});

  Payment.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] is double ? json['amount'] : json['amount'].toDouble();
    dateTime = json['dateTime'];
    dateTimeInEpoc = json['dateTimeInEpoc'];
    type = json['type'];
    ownerId = json['ownerId'];
    customerId = json['customerId'];
    balance = json['balance'];
    ledgerId = json['ledgerId'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["amount"] = amount;
    data["dateTime"] = dateTime;
    data["dateTimeInEpoc"] = dateTimeInEpoc;
    data["type"] = type;
    data["balance"] = balance;
    data["ledgerId"] = ledgerId;
    data["ownerId"] = ownerId;
    data["customerId"] = customerId;
    data["remarks"] = remarks;
    return data;
  }
}
