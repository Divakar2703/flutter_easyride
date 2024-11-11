import 'package:flutter/material.dart';

class BankSelectionDropdown extends StatefulWidget {
  @override
  _BankSelectionDropdownState createState() => _BankSelectionDropdownState();
}

class _BankSelectionDropdownState extends State<BankSelectionDropdown> {
  String? selectedBank;

  final List<Map<String, dynamic>> banks = [
    {'name': 'GPay', 'image': 'assets/images/gpay.jpg'},
    {'name': 'Paytm', 'image': 'assets/images/paytem.png'},
    {'name': 'PhonePay', 'image': 'assets/images/phonepay.png'},
     {'name': 'RozaPay', 'image': 'assets/images/rojapay.png'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Choose Your Bank',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
           
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                
                value: selectedBank,
                
                
                hint: Text('Online'),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBank = newValue;
                  });
                },
                items: banks
                    .map<DropdownMenuItem<String>>((Map<String, dynamic> bank) {
                  return DropdownMenuItem<String>(
                    value: bank['name'],
                    child: Row(
                      children: [
                        Image.asset(
                          bank['image'],
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Text(bank['name']),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
