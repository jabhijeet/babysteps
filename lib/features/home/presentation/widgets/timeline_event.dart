import 'package:flutter/material.dart';

enum TimelineEventType { feed, sleep, diaper, activity, medical, growth }

class TimelineEvent {
  TimelineEvent({
    required this.id,
    required this.type,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  final int id;
  final TimelineEventType type;
  final DateTime time;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
}
