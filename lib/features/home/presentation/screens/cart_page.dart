import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../widgets/widget_helper.dart';
import 'booking_success_dialog.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => context.pop(context),
        ),
        title: const Text("Cart",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Your Services Order",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "+ Add more",
                      style: TextStyle(
                        color: Colors.brown.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),

              // Using helper
              WidgetHelper.buildServiceItem(
                title: "Swedish Massage",
                subtitle: "For Male",
                price: "₹4,000",
                time: "60 Mins",
                onRemove: () {},
              ),
              WidgetHelper.buildServiceItem(
                title: "Deep Tissue Massage",
                subtitle: "For Male",
                price: "₹6,200",
                time: "60 Mins",
                onRemove: () {},
              ),
              WidgetHelper.buildServiceItem(
                title: "Hot Stone Massage",
                subtitle: "For Male",
                price: "₹6,200",
                time: "60 Mins",
                onRemove: () {},
              ),
               WidgetHelper.buildServiceItem(
                title: "Deep Tissue Massage",
                subtitle: "For Male",
                price: "₹6,200",
                time: "60 Mins",
                onRemove: () {},
              ),
               WidgetHelper.buildServiceItem(
                title: "Deep Tissue Massage",
                subtitle: "For Male",
                price: "₹6,200",
                time: "60 Mins",
                onRemove: () {},
              ),

              const SizedBox(height: 20),

              const Text(
                "Offers & Discounts",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Coupon box from helper
              WidgetHelper.buildCouponBox(),

              const SizedBox(height: 20),

              const Text("Payment Summary",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
              const SizedBox(height: 12),

              // Summary rows
              WidgetHelper.buildSummaryRow("Selected Services", "₹12,500"),
              WidgetHelper.buildSummaryRow("Additional Fee", "₹50"),
              WidgetHelper.buildSummaryRow("Convenience Fee", "₹100"),

              const SizedBox(height: 10),
              const Divider(),
              WidgetHelper.buildSummaryRow("Payable Amount", "₹12,650",
                  isBold: true, fontSize: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6),
            ],
          ),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    const TextSpan(
                      text: "Total ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "₹30,000",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => BookingSuccessDialog(
                      services: "Swedish Massage and Hot Stone Massage",
                      dateTime: "Thursday, 7 Mar 2024 at 8:00 AM",
                    ),
                  );
                },
                child: const Text(
                  "Pay",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
