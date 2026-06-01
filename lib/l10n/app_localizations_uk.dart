// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Мій Магазин';

  @override
  String get productsTab => 'Товари';

  @override
  String get settingsTab => 'Налаштування';

  @override
  String get productsTitle => 'Товари';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get languageLabel => 'Мова';

  @override
  String get selectLanguage => 'Оберіть мову';

  @override
  String get availableLanguages => 'Доступні мови:';

  @override
  String get ukrainian => 'Українська';

  @override
  String get english => 'Англійська';

  @override
  String get polish => 'Польська';

  @override
  String get productTshirt => 'Футболка';

  @override
  String get productSneakers => 'Кросівки';

  @override
  String get productBackpack => 'Рюкзак';

  @override
  String get productBook => 'Книга';

  @override
  String get productHeadphones => 'Навушники';

  @override
  String addedDate(String date) {
    return 'Додано: $date';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count товару',
      many: '$count товарів',
      few: '$count товари',
      one: '1 товар',
      zero: 'Немає товарів',
    );
    return '$_temp0';
  }

  @override
  String get totalLabel => 'Всього';

  @override
  String totalPrice(String price) {
    return 'Сума: $price';
  }

  @override
  String get sumLabel => 'Сума';

  @override
  String get currencyInfo => 'Валюта форматується відповідно до вибраної мови';

  @override
  String get dateInfo => 'Дати форматуються відповідно до вибраної мови';

  @override
  String languageChanged(String language) {
    return 'Мову змінено на $language';
  }

  @override
  String helloUser(String name) {
    return 'Привіт, $name!';
  }

  @override
  String get storeSubtitle => 'Простий локалізований магазин';

  @override
  String get emptyProducts => 'Товарів ще немає';

  @override
  String get save => 'Зберегти';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get edit => 'Редагувати';

  @override
  String get add => 'Додати';
}
