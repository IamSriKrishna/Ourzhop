
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:flutter/material.dart';

class PaymentRow {
  final String label;
  final String value;
  final PaymentRowType type;

  PaymentRow({
    required this.label,
    required this.value,
    this.type = PaymentRowType.normal,
  });
}

enum PaymentRowType { normal, discount, free, total }

class CartPaymentDetails extends StatelessWidget {
  final CartState cartState;
  final List<PaymentRow>? customRows;
  final EdgeInsets? margin;
  final double discountAmount;

  const CartPaymentDetails({
    super.key,
    required this.cartState,
    this.customRows,
    this.margin,
    this.discountAmount = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final rows = customRows ?? _getDefaultPaymentRows();

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ...rows.map((row) => _PaymentRowWidget(row: row)),
          const Divider(thickness: 1),
          _PaymentRowWidget(
            row: PaymentRow(
              label: 'Total',
              value: '₹${(cartState.totalAmount - discountAmount).toStringAsFixed(2)}',
              type: PaymentRowType.total,
            ),
          ),
        ],
      ),
    );
  }

  List<PaymentRow> _getDefaultPaymentRows() {
    return [
      PaymentRow(
        label: 'MRP Total',
        value: '₹${cartState.totalAmount.toStringAsFixed(2)}',
      ),
      PaymentRow(
        label: 'Product Discount',
        value: '- ₹${discountAmount.toStringAsFixed(2)}',
        type: PaymentRowType.discount,
      ),
      PaymentRow(
        label: 'Delivery Fee',
        value: 'FREE',
        type: PaymentRowType.free,
      ),
    ];
  }
}

class _PaymentRowWidget extends StatelessWidget {
  final PaymentRow row;

  const _PaymentRowWidget({required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.label,
            style: TextStyle(
              fontSize: row.type == PaymentRowType.total ? 16 : 14,
              fontWeight: row.type == PaymentRowType.total ? FontWeight.w600 : FontWeight.normal,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            row.value,
            style: TextStyle(
              fontSize: row.type == PaymentRowType.total ? 16 : 14,
              fontWeight: row.type == PaymentRowType.total ? FontWeight.w600 : FontWeight.normal,
              color: _getValueColor(row.type),
            ),
          ),
        ],
      ),
    );
  }

  Color _getValueColor(PaymentRowType type) {
    switch (type) {
      case PaymentRowType.discount:
      case PaymentRowType.free:
        return Colors.green;
      case PaymentRowType.total:
      case PaymentRowType.normal:
        return Colors.black;
    }
  }
}
