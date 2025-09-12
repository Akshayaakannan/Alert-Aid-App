import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // Correct import for icons

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 50, // Set height to 50px as requested
      width: MediaQuery.of(context).size.width, // Full width of the device
      color: Colors.white, // Background color
      child: Row(
        children: [
          // Time on the left with specified width and height
          SizedBox(
            width: 54, // Width of the time areaS
            height: 18, // Height of the time area
            child: const Text(
              '5:13 PM', // Change dynamically later
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),

          const Spacer(), // Pushes icons to the right

          // Status icons on the right with specified width and height
          SizedBox(
            width: 102, // Width for the icon group
            height: 18, // Height for the icon group
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Ionicons.alarm, size: 14),
                SizedBox(width: 4),
                Icon(Ionicons.cellular, size: 14),
                SizedBox(width: 4),
                Icon(Ionicons.wifi, size: 14),
                SizedBox(width: 4),
                Icon(Ionicons.bluetooth, size: 14),
                SizedBox(width: 4),
                Icon(Ionicons.battery_full, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
