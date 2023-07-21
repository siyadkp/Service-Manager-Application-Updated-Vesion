
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/admin_add_product/admin_add_product_provider.dart';
import 'package:service_manager/controller/provider/billing_provider/billing_provider.dart';
import 'package:service_manager/controller/provider/service_call_status_updation/service_call_status_updation.dart';
import '../../../model/prouct_model.dart/product_model.dart';
import '../../../view/billing/billing.dart';
import '../../../view/billing/widget/service_call_showing_widget.dart';

class AddProductToBillNotif extends ChangeNotifier {
  TextEditingController product = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  String validationError='';
  Map<String,BillProductModel>customerBillData={};
  List<String>customerBillDataKeys=[];
 
  // Future<void> generateInvoicePDF(BuildContext context) async {
  //   final pdf = pw.Document();

  //   // Add content to the PDF
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Text('Hello, World!'),
  //         );
  //       },
  //     ),
  //   );

  //   // Save the PDF to the device's storage
  //   final output = await getExternalStorageDirectory();
  //   final outputFile = File('${output?.path}/invoice.pdf');
  //   await outputFile.writeAsBytes(await pdf.save());

  //   // Navigate to the PDF viewer page
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Hill(pdfFile: outputFile),
  //     ),
  //   );

  //   await _downloadFile(outputFile);
  // }

  // Future<void> checkPermission() async {
  //   PermissionStatus status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     status = await Permission.storage.request();
  //     if (!status.isGranted) {
  //       // Handle permission denied
  //       return;
  //     }
  //   }
  // }

  // Future<void> _downloadFile(File file) async {
  //   await checkPermission();
  //   final downloadsDirectory = await getDownloadsDirectoryPath();
  //   const fileName = 'invoice.pdf';
  //   final savedDir = '${downloadsDirectory}/';

  //   await FlutterDownloader.enqueue(
  //     url: file.path,
  //     savedDir: savedDir,
  //     fileName: fileName,
  //     showNotification: true,
  //     openFileFromNotification: true,
      
  //   );
  // }

  // Future<String?> getDownloadsDirectoryPath() async {
  //   String? directoryPath;
  //   if (Platform.isAndroid) {
  //     final directory = await getExternalStorageDirectory();
  //     directoryPath = directory?.path;
  //   } else if (Platform.isIOS) {
  //     final directory = await getApplicationDocumentsDirectory();
  //     directoryPath = directory.path;
  //   }

  //   return directoryPath;
  // }
 
  addTobill(BuildContext context,BillProductModel billProduct, String key,) {
    customerBillData.putIfAbsent(key, () => billProduct);
    totalBillAmountCalculateHelper(context);
      if(billProduct.type==2){
      Provider.of<ServiceCallStatusUpdationNotifier>(context,listen: false).billedProductStatusUpdation('Delivery', billProduct.docId);
    }

    mapKeyStoring();
    
  }

  
  totalBillAmountCalculateHelper(BuildContext context){
   Provider.of<BillingNotifier>(context,listen: false).totalBillAmountCalculater(context);
  }
  mapKeyStoring() {
    customerBillDataKeys = [];
    customerBillDataKeys.addAll(customerBillData.keys);
    notifyListeners();
  }

  removeTobill(BuildContext context,BillProductModel billProduct,index,) {
    if(customerBillData[billProduct.key]?.type==2){
    addProductSingleWidgetBuilderObj[index].isAddedToBill=false;
     Provider.of<ServiceCallStatusUpdationNotifier>(context,listen: false).billedProductStatusUpdation('Complete', billProduct.docId);
    }
    customerBillData.remove(billProduct.key);
    totalBillAmountCalculateHelper(context);
    mapKeyStoring();
   
     
    
  }
 
  productDataLoading(String key,BuildContext context){
AdminAddProductNotifier adminAddProductNotifierObj=Provider.of<AdminAddProductNotifier>(context,listen: false);
qty.text='1';
discount.text='0';
amount.text=adminAddProductNotifierObj.productDatas[key]?.get('retailPrice');
totalAmount.text=amount.text;
notifyListeners();
}

productTotalAmount(){
    int intQty = qty.text =='' ?1:int.parse(qty.text);
    int intAmount= amount.text ==''?0:int.parse(amount.text);
    int intDiscount= discount.text =='' ?0: int.parse(discount.text);
totalAmount.text=((intAmount*intQty)-intDiscount).toString();
notifyListeners();
}

validation(){
  
  if(product.text.isEmpty){
     validationError='Please enter your Product Name';
  }else  if(qty.text.isEmpty){
     validationError='Please enter your Product Qty';
  }else  if(discount.text.isEmpty){
     validationError='Please enter your Product discount';
  }else  if(amount.text.isEmpty){
     validationError='Please enter your Product amount';
  }else  if(totalAmount.text.isEmpty){
     validationError='Please enter your Product totalAmount';
  }else{
    validationError='';
      notifyListeners();
    return true;
  }
  notifyListeners();
    return false;
}

controllerDataClearing(BuildContext context){
  product.text='';
  qty.text='';
  discount.text='';
  amount.text='';
  totalAmount.text='';
}

}

