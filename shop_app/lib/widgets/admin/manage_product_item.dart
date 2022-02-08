import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/exceptions/http_exception.dart';

import '/providers/product.dart';
import '/providers/products.dart';
import '/screens/admin/edit_product_screen.dart';

class ManageProductItem extends StatelessWidget {
  final Product product;
  const ManageProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: FittedBox(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: product);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(product);
                } on HttpException catch (_) {
                  scaffoldMessenger.showSnackBar(const SnackBar(
                    content: Text(
                      'Deleting Failed',
                      textAlign: TextAlign.center,
                    ),
                  ));
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
