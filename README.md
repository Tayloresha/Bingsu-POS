<p align="center">
GROUP BINGSU
  <br>‘POINT OF SALE SYSTEM’<br><br>
Prepared by Nur Athisha Binti Mohd Zariman (2118676), Nora Alissa binti Ismail(2117862) & Adriana binti Anuar Kamal (2025778)<br><br>
  ‘POINT OF SALE SYSTEM’ is a website used by businesses to process transactions in retail settings

</p><br>

**1. Project Description**
<br>
          This project aims to develop a Point-of-Sale (POS) system with functionalities for administrators. The system will cater to businesses of all sizes by offering unlimited product storage and detailed sales management features.
<br><br>

**2. Project Requirement**
<br>
1. It contains unlimited slots for storage. <br>
2. Each row will store number of items, product description,
product price, product quantity and product total.
3. Product description, price, quantity available are maintained
by admin (Admin view). Admin can also view product
availability (inventory) and total profit of all the sold products.
4. There will be 2% discount for the same item purchased twice.
5. The total or final amount should be displayed at the end of the
last product.
6. There is a rounding of the total or final amount based on
National Bank requirement, which anything above 5 cents will
be round to the nearest number. For example, 6.01 is rounded
to 6.0 and 6.05 is rounded to 6.1.
7. The payable amount is subjected to 6% of GST.
8. The receipt of the purchases must contain date and time of
the purchased items including all the above requirements.<br><br>

**3. Group Contribution**
<br>
Each of the team members prepared one web page for the project as shown in the following table. <br><br>

| **Name** | **Contribution** |
|----------|------------------|
| Nur Athisha Binti Mohd Zariman (2118676)|- Page: Admin View <br> - adminView.html, adminView.dart, adminView.css, styles.css <br> - Header for every pages <br> - Compile all codes <br> - Fixing all codes|
| Nora Alissa binti Ismail (2117862)|- Page: Main Page <br> - index.html, main.dart, index.css <br> - do the code for payment calculation|
| Adriana binti Anuar Kamal (2025778)|- Page: Inventory <br> - inventory.html, inventory.dart, inventory.css <br> - ~~do popout for receip~~|

<br><br>

**4. Uses of Each Pages**
<br>
| **Page** | **Description** |
|----------|------------------|
| index.html - Main Page|- Display all products available (product name, price, stock/quantity) <br> - Display products selected and the calculation for payment <br> - ~~When 'PAY' button is clicked, receipt will pop out~~|
| adminView.html - Admin View|- Display all product descriptions (name), prices and quantities available <br> - Admin can add products <br> - Admin can remove products|
| inventory.html - Inventory|- Display product availability <br> - Display total profits of sold products|

<br><br>


**5. References**
<br><br>
&emsp; Build a web app with Dart Retrieved 7 May 2024 from <br> &emsp; https://dart.dev/web/get-started
<br><br>
&emsp; dart:html Retrieved 7 May 2024 from <br> &emsp; https://dart.dev/libraries/dart-html
<br><br>



