import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatProductDate(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).toString();
  return DateFormat.yMd(locale).format(date);
}

String formatProductPrice(BuildContext context, double price) {
  final locale = Localizations.localeOf(context);

  final symbol = switch (locale.languageCode) {
    'uk' => '₴',
    'pl' => 'zł',
    _ => r'$',
  };

  final format = NumberFormat.currency(
    locale: locale.toString(),
    symbol: symbol,
    decimalDigits: 0,
  );

  return format.format(price);
}
