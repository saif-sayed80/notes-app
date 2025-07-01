import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;


String formatNoteDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final noteDay = DateTime(date.year, date.month, date.day);
  final timeString = intl.DateFormat('h:mm a').format(date);

  if (noteDay == today) {
    return 'Today $timeString';
  } else if (noteDay == today.subtract(Duration(days: 1))) {
    return 'Yesterday $timeString';
  } else {
    final fullDate = intl.DateFormat('MMMd').format(date);
    return fullDate;
  }
}


TextDirection? getTextDirection(String text) {
  final firstChar = text.trim().characters.firstOrNull;
  if (firstChar == null) return TextDirection.ltr;

  final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(firstChar);
  return isArabic ? TextDirection.rtl : TextDirection.ltr;
}