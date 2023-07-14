import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:service_manager/model/prouct_model.dart/product_model.dart';

class PdfGenerator {
  Future<void> generateInvoicePDF(
      BuildContext context, Map<String, BillProductModel> products,String totalAmount,String discount) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Shop Name',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Shop Address',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 32),
              pw.Text(
                'User Name',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'User Address',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                'Date: 01/01/2022',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 32),
              pw.Table(
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(2),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                  4: pw.FlexColumnWidth(2),
                },
                children: [
                  _buildTableRow(
                      ['Product', 'Qty', 'Price', 'Discount', 'Total']),
                ...products.entries.map((entry) {
                    final productName = entry.key;
                    final product = entry.value;
                    final quantity = product.qty;
                    final price = '\$${product.amount}';
                    final discount = '\$${product.discount}';
                    final total = '\$${product.totalAmount}';

                    return _buildTableRow(
                      [productName, quantity, price, discount, total],
                    );
                  }).toList(),
                ],
              ),
              pw.SizedBox(height: 16),
              pw.Divider(),
              pw.SizedBox(height: 16),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Discount:',
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                     '₹$discount',
                    style: pw.TextStyle(fontSize: 16),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total Amount:',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '₹$totalAmount',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final filePath = '${output.path}/invoice.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF file with a PDF viewer
    OpenFile.open(filePath);
  }

  pw.TableRow _buildTableRow(List<String> rowData) {
    return pw.TableRow(
      children: rowData.map((data) {
        return pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 8.0),
          child: pw.Text(
            data,
            style: pw.TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}
