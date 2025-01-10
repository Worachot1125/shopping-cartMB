import 'package:flutter/material.dart';
import 'CartItem.dart';
import 'Items.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Shopping Cart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = <Item>[
    Item(name: 'iPhone 15 Pro Max', price: 1500),
    Item(name: 'MacBook Pro', price: 2500),
    Item(name: 'iPad Pro', price: 10000),
  ];

  double total = 0;
  final List<GlobalKey<CartItemState>> _cartItemKeys = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < items.length; i++) {
      _cartItemKeys.add(GlobalKey<CartItemState>());
    }
  }

  void _updateTotalPrice(double priceChange) {
    setState(() {
      total += priceChange;
    });
  }

  void _clearCart() {
    setState(() {
      total = 0;
      for (var i = 0; i < items.length; i++) {
        items[i].amount = 0;
        _cartItemKeys[i].currentState?.resetQuantity();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextButton.icon(
              onPressed: _clearCart,
              label: Text('Clear Cart'),
              icon: Icon(Icons.clear),
            ),
            for (var i = 0; i < items.length; i++)
              CartItem(
                key: _cartItemKeys[i],
                items: items[i],
                onPriceChange: _updateTotalPrice,
              ),
            Expanded(
              child: Container(),
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:'),
                  Text('$total ฿',
                      style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
