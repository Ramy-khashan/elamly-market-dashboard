import 'package:flutter/material.dart';
import '../../model/order_model.dart';

class ShowProductDialog extends StatelessWidget {
  ShowProductDialog({super.key, required this.products, required this.deliveryFees, required this.totalPrice});
  final List<Products> products;
  final String deliveryFees;
  final String totalPrice;
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        height: 600,
        width: 400,
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Order Products",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ))
                ],
              ),
              Expanded(
                child: Scrollbar(
                  controller: controller,
                  trackVisibility: true,
                  thumbVisibility: true,
                  radius: const Radius.circular(15),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          products.length,
                          (index) => Card(
                                elevation: 2,
                                child: ListTile(
                                  title:
                                      Text(products[index].productTitle ?? ""),
                                  leading: Text(
                                    "(${products[index].quantity}x) ",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  subtitle: products[index].isOnSale!
                                      ? Text(
                                          "Product is on sale\n${products[index].isOnSale! ? "Price Before : ${products[index].priceBefore} L.E" : ''}")
                                      : null,
                                  trailing: Text(
                                    "${products[index].price}L.E",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ),
                              )),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                  dense: true,
                  title: const Text("Total products price "),
                  trailing: Text(
                      "${products.fold<double>(0, (previousValue, element) => previousValue + double.parse(element.price.toString()) * double.parse(element.quantity.toString()))}L.E")),
                ListTile(
                  dense: true,
                  title: const Text("Delivery Fees "),
                  trailing: Text("$deliveryFees L.E")),
                ListTile(
                  dense: true,
                  title: const Text("Total price "),
                  trailing: Text("$totalPrice L.E")),
            ],
          ),
        )),
      ),
    );
  }
}
