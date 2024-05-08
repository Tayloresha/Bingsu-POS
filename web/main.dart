// Made By Nora Alissa bint Ismail (2117862)
import 'package:web/helpers.dart';
import 'dart:html';
import 'adminView.dart';

void main() {
  final List<List<Map<String, dynamic>>> localStorageData =
      getLocalStorageData();
  final List<Map<String, dynamic>> products = localStorageData[0];
  final TableElement? table =
      document.querySelector('#list-table') as TableElement?;
  final Element? totalSpan = document.querySelector('#total-after-rounding');
  final Element? subTotalSpan = document.querySelector('#sub-total');
  final Element? discountSpan = document.querySelector('#discount');
  final Element? gstSpan = document.querySelector('#gst');
  final Element? totalBeforeRoundSpan =
      document.querySelector('#total-before-rounding');
  final DateTime purchaseTime = DateTime.now();

  double subtotal = 0.0;
  double discount = 0.0;
  double totalDiscount = 0.0;
  double totalPrice = 0.0;

// Rounds the final price
  double roundPrice(double amount) {
    // Multiply by 100 to shift the decimal two places (e.g., 6.01 becomes 601.0).
    double scaledValue = amount * 100;

    // Subtract the integer part from the scaled value to isolate the decimal part
    double decimalPart = scaledValue - scaledValue.floor();

    // Calculate the remainder when dividing by 10 (to check cents above the last whole ten)
    double remainder = decimalPart % 10;

    print(remainder);

    // Apply custom rounding rules
    if (remainder > 0 && remainder < 5) {
      // If remainder is between 1 and 4 (inclusive), subtract remainder to round down to the nearest ten
      scaledValue -= remainder;
    } else if (remainder >= 5 && remainder <= 9) {
      // If remainder is between 5 and 9, add (10 - remainder) to round up to the next ten
      scaledValue += (10 - remainder);
    }

    // Scale back to the original range and return the rounded value
    return scaledValue / 100;
  }

  // Function to Update Totals
  void updateTotals() {
    discountSpan?.text = totalDiscount.toStringAsFixed(2);
    double taxedAmount = subtotal * 1.06; // Applying 6% GST
    gstSpan?.text = (taxedAmount - subtotal).toStringAsFixed(2);
    totalBeforeRoundSpan?.text =
        (totalPrice - totalDiscount + (taxedAmount - subtotal))
            .toStringAsFixed(2);
    double finalAmount =
        roundPrice(totalPrice - totalDiscount + (taxedAmount - subtotal));
    totalSpan?.text =
        'RM${finalAmount.toStringAsFixed(2)} on ${purchaseTime.toString()}';

    // Store finalAmount in local storage
    window.localStorage['finalAmount'] = finalAmount.toString();
  }

  // Iterate over products list and create a row for each product
  for (int i = 0; i < products.length; i++) {
    final newRow = table?.addRow();
    final noCell = newRow?.insertCell(0);
    final nameCell = newRow?.insertCell(1);
    final priceCell = newRow?.insertCell(2);
    final quantityCell = newRow?.insertCell(3);
    final totalCell = newRow?.insertCell(4);

    // Populate cells with product information
    noCell?.text = (i + 1).toString();
    nameCell?.text = products[i]['name'];
    priceCell?.text = 'RM${products[i]['price'].toString()}';

    // Create input element for quantity
    final quantityInput = NumberInputElement();
    quantityInput.min = '0';
    quantityCell?.append(quantityInput);

    // Initialize previous quantity value to 0
    int previousQuantity = 0;

    // Event Listener for Quantity
    quantityInput.onInput.listen((event) {
      final int quantity = int.parse(quantityInput.value ?? '0');
      double productTotal = products[i]['price'] * quantity;

      final int currentQuantity = int.parse(quantityInput.value ?? '0');

      if (currentQuantity > previousQuantity) {
        // when the quantity increases
        if (quantity == 2) {
          discount = (productTotal / 2) *
              0.02; // 2% discount for the same item purchased twice
          totalDiscount += discount;
        }
        subtotal += productTotal;

        totalCell?.text = productTotal.toStringAsFixed(2);
        totalPrice += products[i]['price'];
        subTotalSpan?.text =
            totalPrice.toStringAsFixed(2); // Display subtotal here
      } else if (currentQuantity < previousQuantity) {
        // when the quantity decreases
        if (quantity < 2) {
          discount = (productTotal / 2) *
              0.02; // 2% discount for the same item purchased twice
          totalDiscount -= discount;
        }
        subtotal -= productTotal;

        totalCell?.text = productTotal.toStringAsFixed(2);
        totalPrice -= products[i]['price'];
        subTotalSpan?.text =
            totalPrice.toStringAsFixed(2); // Display subtotal here
      }

      previousQuantity = currentQuantity;

      updateTotals(); // Update total whenever a quantity changes
    });
  }

// Function that clears payment details
  void clearPayment() {
    // Clear payment details
    subTotalSpan?.text = '0.00';

    discountSpan?.text = '0.00';

    gstSpan?.text = '0.00';

    totalBeforeRoundSpan?.text = '0.00';

    totalSpan?.text = '0.00';
  }

  // Query the pay button
  final ButtonElement payButton = querySelector('.pay-button') as ButtonElement;

  // Event listener to the pay button
  payButton.onClick.listen((_) {
    // Clear payment on the table
    clearPayment();
  });
}
