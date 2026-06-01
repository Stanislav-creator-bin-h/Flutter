// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Store';

  @override
  String get productsTab => 'Products';

  @override
  String get settingsTab => 'Settings';

  @override
  String get productsTitle => 'Products';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageLabel => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get availableLanguages => 'Available languages:';

  @override
  String get ukrainian => 'Ukrainian';

  @override
  String get english => 'English';

  @override
  String get polish => 'Polish';

  @override
  String get productTshirt => 'T-shirt';

  @override
  String get productSneakers => 'Sneakers';

  @override
  String get productBackpack => 'Backpack';

  @override
  String get productBook => 'Book';

  @override
  String get productHeadphones => 'Headphones';

  @override
  String addedDate(String date) {
    return 'Added: $date';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get totalLabel => 'Total';

  @override
  String totalPrice(String price) {
    return 'Total: $price';
  }

  @override
  String get sumLabel => 'Sum';

  @override
  String get currencyInfo => 'Currency is formatted for the selected language';

  @override
  String get dateInfo => 'Dates are formatted for the selected language';

  @override
  String languageChanged(String language) {
    return 'Language changed to $language';
  }

  @override
  String helloUser(String name) {
    return 'Hello, $name!';
  }

  @override
  String get storeSubtitle => 'Simple localized shop';

  @override
  String get emptyProducts => 'No products yet';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';
}
