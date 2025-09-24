
import 'package:customer_app/features/home/presentation/models/product_model.dart';
import 'package:customer_app/features/store/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          children: [
            for (int i = 0; i < products.length; i += 2) ...[
              Row(
                children: [
                  Expanded(
                    child: ProductCard(product: products[i]),
                  ),
                  const SizedBox(width: 12),
                  if (i + 1 < products.length)
                    Expanded(
                      child: ProductCard(product: products[i + 1]),
                    )
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
              if (i + 2 < products.length) const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}
