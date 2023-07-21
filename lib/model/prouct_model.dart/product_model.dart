class BillProductModel {
  int type;
  String docId;
  String key;
  String productName;
  String qty;
  String discount;
  String amount;
  String totalAmount;
  BillProductModel({
    required this.type,
    required this.docId,
    required this.key,
    required this.productName,
    required this.qty,
    required this.discount,
    required this.amount,
    required this.totalAmount,
  });
}
