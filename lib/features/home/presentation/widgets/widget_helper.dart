import 'package:flutter/material.dart';

class WidgetHelper {
  static Widget buildServiceItem({
    required String title,
    required String subtitle,
    required String price,
    required String time,
    required VoidCallback onRemove,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              // Service Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black54)),
                    const SizedBox(height: 6),
                    Text("$price • $time",
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),

              // Remove Button
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.brown.shade300),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.brown,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: onRemove,
                child: const Text("Remove",
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey[200], thickness: 1),
      ],
    );
  }

  // Summary Row Widget
  static Widget buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    double fontSize = 14,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)),
          const Spacer(),
          Text(value,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)),
        ],
      ),
    );
  }

  // Coupon Container
  static Widget buildCouponBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.local_offer_outlined, color: Colors.brown),
          SizedBox(width: 8),
          Text(
            "Apply Coupon",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black54),
        ],
      ),
    );
  }
}
