import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Settings extends StatelessWidget {
  IconData? icon;
  String? nameOfSetting;
  Settings({super.key, required this.icon, required this.nameOfSetting});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: 23,
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                '$nameOfSetting',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 12,
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Settingswithfilledbg extends StatelessWidget {
  IconData? icon;
  String? nameOfSetting;
  Settingswithfilledbg(
      {super.key, required this.icon, required this.nameOfSetting});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 23,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  '$nameOfSetting',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            )
          ],
        ),
      ),
    );
  }
}
