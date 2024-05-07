// ignore: deprecated_member_use
import 'package:web/helpers.dart';
import 'dart:html';

void main() {
  Storage storage = window.localStorage;

  double totalPrice = 0;

  // APPEND PRODUCT TO PRODUCT LIST
  // Find the product-grid element
  // ignore: deprecated_member_use
  DivElement productGrid = querySelector('.product-grid') as DivElement;

  // List to store product information
  List<Map<String, dynamic>> products = [
    {'name': '', 'price': 'RM5.00', 'stock': 5, 'id': 1},
    {'name': 'Apple', 'price': 'RM3.00', 'stock': 10, 'id': 2},
    // Add more products as needed
  ];

  // Function to append a product to the product grid
  void appendProduct(Map<String, dynamic> product) {
    // Create a new product item
    DivElement productItem = DivElement();
    productItem.className = 'product-list';

    // Create elements for the product item
    HeadingElement productName = HeadingElement.h1();
    productName.text = product['name'];

    ParagraphElement price = ParagraphElement();
    price.text = product['price'];

    HeadingElement stock = HeadingElement.h3();
    stock.text = 'In Stock: ';

    SpanElement stockValue = SpanElement();
    stockValue.text = product['stock'].toString();

    DivElement counterContainer = DivElement();
    counterContainer.className = 'counter-container';

    ButtonElement decrementButton = ButtonElement();
    decrementButton.text = '-';
    decrementButton.id = 'decrement-button${product['id']}';

    ButtonElement incrementButton = ButtonElement();
    incrementButton.text = '+';
    incrementButton.id = 'increment-button${product['id']}';

    // Counter
    SpanElement counterValue = SpanElement();
    counterValue.text = '0';
    counterContainer.append(decrementButton);
    counterContainer.append(counterValue);
    counterContainer.append(incrementButton);

    // Append elements to the product item
    stock.append(stockValue);

    productItem.append(productName);
    productItem.append(price);
    productItem.append(stock);
    productItem.append(counterContainer);

    // Append the product item to the product-grid
    productGrid.append(productItem);
  }

  // CURRENTLY NOT IN USE
  // Append each product to the product grid
  //for (var product in products) {
  //appendProduct(product);
  //}

  // APPEND PRODUCT TO PAYMENT TABLE

  // Initialize a list to store product data
  List<Map<String, String>> productList = [];

  // Function to add a row to the table
  void addRowToTable(int number, String description, double basePrice,
      int quantity, double totalPrice) {
    // Get the table element
    // ignore: deprecated_member_use
    TableElement table = querySelector('#payment-table') as TableElement;

    // Create a map to store product data for this row
    Map<String, String> rowData = {
      'number': number.toString(),
      'description': description,
      'basePrice': basePrice.toStringAsFixed(2),
      'quantity': quantity.toString(),
      'totalPrice': totalPrice.toStringAsFixed(2)
    };

    // Append the map to the list
    productList.add(rowData);

    // Create a new row
    TableRowElement row = table.addRow();

    // Add cells to the row
    row.addCell().text = number.toString(); // Number
    row.addCell().text = description; // Product Description
    TableCellElement basePriceCell = row.addCell(); // Base Price
    var basePriceSpan = SpanElement();
    basePriceSpan.id = 'base-price$number';
    basePriceSpan.text = basePrice.toStringAsFixed(2);
    basePriceCell.append(basePriceSpan);

    TableCellElement qtyCell = row.addCell(); // Quantity
    var qtySpan = SpanElement();
    qtySpan.id = 'qty-value$number';
    qtySpan.text = quantity.toString();
    qtyCell.append(qtySpan);

    TableCellElement totalPriceCell = row.addCell(); // Total Price
    var totalPriceSpan = SpanElement();
    totalPriceSpan.id = 'total-price$number';
    totalPriceSpan.text = totalPrice.toStringAsFixed(2);
    totalPriceCell.append(totalPriceSpan);
  }

  // CURRENTLY NOT IN USE
  //  Add a row to the table
  //addRowToTable(1, 'Banana', 5.00, 0, 0.00);

  // SUBTOTAL
  var subTotal = querySelector('#sub-total') as SpanElement;

  void updateSubTotal() {
    subTotal.text = totalPrice.toStringAsFixed(2);
  }

  var incrementButton = querySelector('#increment-button1') as ButtonElement;
  var decrementButton = querySelector('#decrement-button1') as ButtonElement;
  var qtyValue1 = querySelector('#qty-value1') as SpanElement;
  var stockValue1 = querySelector('#stock-value1') as Element;
  var totalPrice1 = querySelector('#total-price1') as SpanElement;
  var basePrice1 = querySelector('#base-price1') as Element;
  var basePrice = double.parse(basePrice1.innerHTML);

  // DISCOUNT
  var discount = querySelector('#discount') as SpanElement;

  double calculateDiscount(double basePrice) {
    // Calculate the discount amount (2% of the base price)
    double discountAmount = -(0.02 * basePrice);

    // Return the discounted price
    return discountAmount;
  }

  // GST
  var gst = querySelector('#gst') as SpanElement;

  double calculateGST(double totalPrice) {
    // Calculate the GST amount (6% of the total price)
    double gstAmount = 0.06 * totalPrice;

    // Return the GST amount
    return gstAmount;
  }

  // ROUNDING
  var totalAfterRounding =
      querySelector('#total-after-rounding') as SpanElement;

  void roundTotal(double total) {
    double remainder = total % 1;
    double roundedValue = total - remainder;
    if (remainder < 0.01) {
      roundedValue += remainder.floorToDouble();
    } else if (remainder < 0.05) {
      roundedValue += remainder.ceilToDouble();
    } else {
      roundedValue += remainder;
    }

    totalAfterRounding.text = roundedValue.toStringAsFixed(2);
  }

  // TOTAL AFTER DISCOUNT AND GST
  var totalBeforeRounding =
      querySelector('#total-before-rounding') as SpanElement;

  // Calculate the total after discount and gst
  void calculateTotal() {
    double discountAmount = calculateDiscount(basePrice);
    double gstAmount = calculateGST(totalPrice);

    // Calculate the total after discount and gst
    double total = totalPrice + discountAmount + gstAmount;

    totalBeforeRounding.text = total.toStringAsFixed(2);

    roundTotal(total);
  }

  int counter = 0;

  // INCREMENT AND DECREMENT BUTTONS
  void updateCounter(int value) {
    counter = value;
    qtyValue1.text = '$counter';
  }

  void updateTotalPrice() {
    totalPrice = counter * basePrice;
    totalPrice1.text = totalPrice.toStringAsFixed(2);
  }

  incrementButton.onClick.listen((_) {
    if (counter < int.parse(stockValue1.innerHTML)) {
      updateCounter(counter + 1);
      if (counter == 2) {
        discount.text = calculateDiscount(basePrice).toStringAsFixed(2);
      }
      updateTotalPrice();
      updateSubTotal();
      gst.text = calculateGST(totalPrice).toStringAsFixed(2);
      calculateTotal();
    }
  });

  decrementButton.onClick.listen((_) {
    if (counter > 0) {
      updateCounter(counter - 1);
      if (counter == 1) {
        discount.text = '0.00';
      }
      updateTotalPrice();
      updateSubTotal();
      gst.text = calculateGST(totalPrice).toStringAsFixed(2);
      calculateTotal();
    }
  });

  // PAY BUTTON
  var payButton = querySelector(".pay-button") as ButtonElement;

  payButton.onClick.listen((_) {
    // Clear payment display
    qtyValue1.text = '0';
    totalPrice = 0;
    totalPrice1.text = '0.00';
    subTotal.text = '0.00';
    discount.text = '0.00';
    gst.text = '0.00';
    totalBeforeRounding.text = '0.00';
    totalAfterRounding.text = '0.00';

    // Remove all rows from the payment-table
    var paymentTableBody = querySelector('#payment-table > tbody') as Element;
    paymentTableBody.innerHTML = ''; // Clear the inner HTML to remove all rows

    // Display Receipt
  });
}
