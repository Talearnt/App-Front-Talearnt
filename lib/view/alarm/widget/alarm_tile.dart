import 'package:flutter/material.dart';

import '../../../data/model/respone/alarm.dart';

class AlarmTile extends StatelessWidget {
  final Alarm alarm;

  const AlarmTile({super.key, required this.alarm});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: alarm.isRead ? Colors.white : Colors.blue.withValues(alpha: 0.05),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                alarm.type,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: alarm.isRead ? Colors.grey : Colors.blue,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                alarm.time,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            alarm.text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
