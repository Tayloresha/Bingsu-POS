//NUR ATHISHA BINTI MOHD ZARIMAN 2118676

// ignore_for_file: deprecated_member_use

import 'package:web/helpers.dart';
//converting JSON data to Dart objects (and vice versa)
import 'dart:convert';
import 'dart:html';

void main() {
  // This selects the <form> element inside an element with the class .AddItem
  final addProductForm = document.querySelector('.AddItem form') as FormElement?;
  // This selects the <table> element inside an element with the class .ListItem
  final table = document.querySelector('.ListItem table') as TableElement?;

  // Retrieve products and products2 from local storage or initialize empty lists
  final List<Map<String, dynamic>> products = _getStoredData('products') ?? [];
  final List<Map<String, dynamic>> products2 = _getStoredData('products2') ?? [];

  //List<Map<String, dynamic>> represents a list of maps where each map contains string keys and values of any type.
  //List: Indicates that this is a list, which is an ordered collection of items.

  // Populate the table with products that are already inside local storage
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
      if (rowIndex != null) { //If a valid rowIndex is found
        window.localStorage.clear();  //clears all data in the local storage
        products.removeAt(rowIndex-1);  // Removes the product at the specified index
        products2.removeAt(rowIndex-1); 
        _storeData('products', products); // Update local storage
        _storeData('products2', products2);
      }
      newRow?.remove(); //removes the row
    });
    removeCell?.append(removeButton); //appends the remove button to the remove cell
  }

  // Populate the table with products that are entered by user
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
      newRow?.remove();
    });
    removeCell?.append(removeButton);

    // Clear form fields after submission
    addProductForm.reset();
  });
}

// Function to retrieve data from local storage
List<Map<String, dynamic>>? _getStoredData(String key) {
  final String? jsonData = window.localStorage[key];  //This line retrieves the data associated with the given key from the local storage. 
  if (jsonData != null) {
    return List<Map<String, dynamic>>.from(jsonDecode(jsonData));
  }
  return null;
}   // retrieves data from the local storage using a provided key, 
    //decodes it from JSON format into a list of maps, and returns the decoded data.

// Function to store data in local storage
void _storeData(String key, List<Map<String, dynamic>> data) {
  final String jsonData = jsonEncode(data);   //convert the data object (a list of maps) into a JSON-encoded string.
  window.localStorage[key] = jsonData;
}

List<List<Map<String, dynamic>>> getLocalStorageData() {
  final List<Map<String, dynamic>> products = _getStoredData('products') ?? [];
  final List<Map<String, dynamic>> products2 = _getStoredData('products2') ?? [];
  return [products, products2];
}

