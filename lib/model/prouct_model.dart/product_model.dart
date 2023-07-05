import 'dart:io';

class ProductModel {
  String productName;
  String serialNumber;
  String qty;
  String wholesalePrice;
  String retailPrice;
  String totalPrice;
  String photo;
  ProductModel(
      {required this.productName,
      required this.serialNumber,
      required this.qty,
      required this.wholesalePrice,
      required this.retailPrice,
      required this.totalPrice,required this.photo});
}
