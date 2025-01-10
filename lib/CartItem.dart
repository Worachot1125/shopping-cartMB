import 'package:flutter/material.dart';
import 'Items.dart';

class CartItem extends StatefulWidget {
  final Item items;
  final Function(double) onPriceChange;
  final GlobalKey<CartItemState> key;

  CartItem({
    required this.items,
    required this.onPriceChange,
    required this.key,
  }) : super(key: key);

  @override
  State<CartItem> createState() => CartItemState(); // Remove underscore
}

class CartItemState extends State<CartItem> { // Remove underscore
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.items.amount;
  }

  void resetQuantity() {
    setState(() {
      quantity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.items.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Price: ${widget.items.price}',
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (quantity > 0) {
                    quantity--;
                    widget.onPriceChange(-widget.items.price);
                  }
                });
                print('Quantity decreased: $quantity');
              },
            ),
            Text(
              '$quantity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  quantity++;
                  widget.onPriceChange(widget.items.price);
                });
                print('Quantity increased: $quantity');
              },
            ),
          ],
        ),
      ],
    );
  }
}
