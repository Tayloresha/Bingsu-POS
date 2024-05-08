// Adriana binti Anuar Kamal (2025778) 
import 'package:web/helpers.dart';
import 'dart:html';
import 'adminView.dart';
import 'main.dart';

void main() {
  final List<List<Map<String, dynamic>>> localStorageData = getLocalStorageData();    //nested list of maps to store product information
  final dynamic localStorageFinalAmount = window.localStorage['finalAmount'];    //variable to store profit
  final double finalAmount = double.parse(localStorageFinalAmount ?? '0'); // Parse finalAmount from local storage
  final List<Map<String, dynamic>> products = localStorageData[0];      //extract data from localStorageData into list
  final List<Map<String, dynamic>> products2 = localStorageData[1];    //extract data from localStorageData into list
  final table = document.querySelector('#list-table') as TableElement?;    //select table element
  final totalProfit = document.querySelector('#profit');    //select profit element


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
