import 'package:flutter/material.dart';
import 'package:flutter_ui_mockup_main/features/home/presentation/screens/cart_page.dart';
import 'package:go_router/go_router.dart';

class ServiceSection extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>>? services;

  const ServiceSection({
    super.key,
    required this.title,
    this.services,
  });

  @override
  State<ServiceSection> createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          childrenPadding: EdgeInsets.zero,
          initiallyExpanded: expanded,
          onExpansionChanged: (value) => setState(() => expanded = value),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          trailing: Icon(
            expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.brown,
          ),
          children: widget.services != null
              ? widget.services!.map((s) => _buildServiceItem(s)).toList()
              : [],
        ),
      ),
    );
  }

  Widget _buildServiceItem(Map<String, dynamic> s) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            s["title"],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),

          // Description
          Text(
            s["desc"],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${s["price"]} · ${s["time"]} · ${s["type"]}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildActionButton(s),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(Map<String, dynamic> s) {
    final isAdded = s["added"] as bool;

    return Container(
      height: 36,
      decoration: BoxDecoration(
        gradient: isAdded
            ? null
            : const LinearGradient(
                colors: [Color(0xFF8B5E3C), Color(0xFFD2A679)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        color: isAdded ? Colors.white : null,
        borderRadius: BorderRadius.circular(10),
        border: isAdded ? Border.all(color: Colors.brown, width: 1.2) : null,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          context.push('/cart');
        },
        child: Text(
          isAdded ? "Remove" : "Add",
          style: TextStyle(
            color: isAdded ? Colors.brown : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
