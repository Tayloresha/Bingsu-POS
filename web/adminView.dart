// ignore_for_file: deprecated_member_use

import 'package:web/helpers.dart';
import 'dart:convert';
import 'dart:html';

void main() {
  // Remove the storage items
  final addProductForm = document.querySelector('.AddItem form') as FormElement?;
  final table = document.querySelector('.ListItem table') as TableElement?;

  // Retrieve products and products2 from local storage or initialize empty lists
  final List<Map<String, dynamic>> products = _getStoredData('products') ?? [];
  final List<Map<String, dynamic>> products2 = _getStoredData('products2') ?? [];

  for (int i = 0; i < products.length; i++) {
  // Create a new row
    final newRow = table?.addRow();

    // Add cells to the row
    final nameCell = newRow?.insertCell(0);
    final priceCell = newRow?.insertCell(1);
    final quantityCell = newRow?.insertCell(2);
    final removeCell = newRow?.insertCell(3);

    // Populate cells with product information
    nameCell?.text = products[i]['name'];
    priceCell?.text = 'RM${products[i]['price']}';
    quantityCell?.text = products2[i]['quantity'].toString();

    // Create a remove button and add it to the remove cell
    final removeButton = ButtonElement()..text = 'Remove';
    removeButton.onClick.listen((_) {
      // Find the index of the clicked row
      final rowIndex = table?.rows.indexOf(newRow!);

      // Remove the corresponding product from the lists
      if (rowIndex != null) {
        window.localStorage.clear();
        products.removeAt(rowIndex-1);
        products2.removeAt(rowIndex-1);
        _storeData('products', products); // Update local storage
        _storeData('products2', products2);
      }
      newRow?.remove();
    });
    removeCell?.append(removeButton);
  }

  addProductForm?.onSubmit.listen((event) {
    event.preventDefault(); // Prevent default form submission

    final name = (querySelector('#name') as InputElement).value;
    final price = double.parse((querySelector('#price') as InputElement).value ?? '0');
    final quantity = int.parse((querySelector('#quantity') as InputElement).value ?? '0');

    // Basic validation checks
    if (name == null || name.isEmpty || price <= 0 || quantity <= 0) {
      window.alert('Please enter a valid product name, positive price, and positive quantity.');
      return;
    }

    // Create a new product
    final newProduct = {'name': name, 'price': price};
    final newProduct2 = {'name': name, 'quantity': quantity};

    // Add the new product to the products lists
    products.add(newProduct);
    products2.add(newProduct2);

    // Store updated products and products2 in local storage
    _storeData('products', products);
    _storeData('products2', products2);

    // Create a new row
    final newRow = table?.addRow();

    // Add cells to the row
    final nameCell = newRow?.insertCell(0);
    final priceCell = newRow?.insertCell(1);
    final quantityCell = newRow?.insertCell(2);
    final removeCell = newRow?.insertCell(3);

    // Populate cells with product information
    nameCell?.text = name;
    priceCell?.text = 'RM$price'; // Assuming price is in dollars
    quantityCell?.text = quantity.toString();

     // Create a remove button and add it to the remove cell
    final removeButton = ButtonElement()..text = 'Remove';
    removeButton.onClick.listen((_) {
      // Find the index of the clicked row
      final rowIndex = table?.rows.indexOf(newRow!);

      // Remove the corresponding product from the lists
      if (rowIndex != null) {
        window.localStorage.clear();
        products.removeAt(rowIndex-1);
        products2.removeAt(rowIndex-1);
        _storeData('products', products); // Update local storage
        _storeData('products2', products2);
      }
      /***
      if (rowIndex != null && rowIndex >= 0 && rowIndex < products2.length) {
        products2.removeAt(rowIndex);
        _storeData('products2', products2); // Update local storage
      }
      */
      // Remove the corresponding row from the table
      newRow?.remove();
    });
    removeCell?.append(removeButton);

    // Clear form fields after submission
    addProductForm.reset();
  });
}

// Function to retrieve data from local storage
List<Map<String, dynamic>>? _getStoredData(String key) {
  final String? jsonData = window.localStorage[key];
  if (jsonData != null) {
    return List<Map<String, dynamic>>.from(jsonDecode(jsonData));
  }
  return null;
}

// Function to store data in local storage
void _storeData(String key, List<Map<String, dynamic>> data) {
  final String jsonData = jsonEncode(data);
  window.localStorage[key] = jsonData;
}

List<List<Map<String, dynamic>>> getLocalStorageData() {
  final List<Map<String, dynamic>> products = _getStoredData('products') ?? [];
  final List<Map<String, dynamic>> products2 = _getStoredData('products2') ?? [];
  return [products, products2];
}

