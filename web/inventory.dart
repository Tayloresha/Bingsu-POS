// ignore: deprecated_member_use
import 'package:web/helpers.dart';
import 'dart:html';
import 'adminView.dart';
import 'main.dart';

void main() {
  final List<List<Map<String, dynamic>>> localStorageData = getLocalStorageData();
  final dynamic localStorageFinalAmount = window.localStorage['finalAmount'];
  final double finalAmount = double.parse(localStorageFinalAmount ?? '0'); // Parse finalAmount from local storage
  final List<Map<String, dynamic>> products = localStorageData[0];
  final List<Map<String, dynamic>> products2 = localStorageData[1];
  final table = document.querySelector('#list-table') as TableElement?;
  final totalProfit = document.querySelector('#profit');


// Iterate over products list and create a row for each product
  for (int i = 0; i < products.length; i++) {
    // Create a new row
    final newRow = table?.addRow();

    // Add cells to the row
    final noCell = newRow?.insertCell(0);
    final nameCell = newRow?.insertCell(1);
    final priceCell = newRow?.insertCell(2);
    final quantityCell = newRow?.insertCell(3);
    // Populate cells with product information
    noCell?.text = (i+1).toString();
    nameCell?.text = products[i]['name'];
    priceCell?.text = 'RM${products[i]['price']}';
    quantityCell?.text = products2[i]['quantity'].toString();;

  }
  totalProfit?.text = finalAmount.toStringAsFixed(2); // Display finalAmount

  
}
