class Ledger {
  String ledgerId;
  String customerId;
  String ownerId;
  int creationDateInEpoc;
  String creationDate;
  bool hasPayments;
  int lastUpdateDateInEpoc;
  int lastPayAmount;
  String lastPayType;
  double balance;

  Ledger({
    this.ledgerId,
    this.customerId,
    this.ownerId,
    this.creationDateInEpoc,
    this.creationDate,
    this.hasPayments,
    this.lastUpdateDateInEpoc,
    this.lastPayAmount,
    this.lastPayType,
    this.balance,
  });

  Ledger.fromJson(Map<String, dynamic> json) {
    ledgerId = json['ledgerId'];
    customerId = json['customerId'];
    ownerId = json['ownerId'];
    creationDateInEpoc = json['creationDateInEpoc'];
    creationDate = json['creationDate'];
    hasPayments = json['hasPayments'] ?? false;
    lastUpdateDateInEpoc = json['lastUpdateDateInEpoc'];
    lastPayAmount = json['lastPayAmount'];
    lastPayType = json['lastPayType'];
    balance = (json['balance'] is double) ? json['balance'] : json['balance'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ledgerId'] = this.ledgerId;
    data['customerId'] = this.customerId;
    data['ownerId'] = this.ownerId;
    data['creationDate'] = this.creationDate;
    data['creationDateInEpoc'] = this.creationDateInEpoc;
    data['hasPayments'] = this.hasPayments;
    data['lastUpdateDateInEpoc'] = this.lastUpdateDateInEpoc;
    data['lastPayType'] = this.lastPayType;
    data['lastPayAmount'] = this.lastPayAmount;
    data['balance'] = this.balance;
    return data;
  }
}
