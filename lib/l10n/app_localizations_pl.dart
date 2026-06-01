// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Mój Sklep';

  @override
  String get productsTab => 'Produkty';

  @override
  String get settingsTab => 'Ustawienia';

  @override
  String get productsTitle => 'Produkty';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get languageLabel => 'Język';

  @override
  String get selectLanguage => 'Wybierz język';

  @override
  String get availableLanguages => 'Dostępne języki:';

  @override
  String get ukrainian => 'Ukraiński';

  @override
  String get english => 'Angielski';

  @override
  String get polish => 'Polski';

  @override
  String get productTshirt => 'Koszulka';

  @override
  String get productSneakers => 'Sneakersy';

  @override
  String get productBackpack => 'Plecak';

  @override
  String get productBook => 'Książka';

  @override
  String get productHeadphones => 'Słuchawki';

  @override
  String addedDate(String date) {
    return 'Dodano: $date';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count produktu',
      many: '$count produktów',
      few: '$count produkty',
      one: '1 produkt',
      zero: 'Brak produktów',
    );
    return '$_temp0';
  }

  @override
  String get totalLabel => 'Razem';

  @override
  String totalPrice(String price) {
    return 'Suma: $price';
  }

  @override
  String get sumLabel => 'Suma';

  @override
  String get currencyInfo =>
      'Waluta jest formatowana zgodnie z wybranym językiem';

  @override
  String get dateInfo => 'Daty są formatowane zgodnie z wybranym językiem';

  @override
  String languageChanged(String language) {
    return 'Język zmieniono na $language';
  }

  @override
  String helloUser(String name) {
    return 'Cześć, $name!';
  }

  @override
  String get storeSubtitle => 'Prosty zlokalizowany sklep';

  @override
  String get emptyProducts => 'Nie ma jeszcze produktów';

  @override
  String get save => 'Zapisz';

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get edit => 'Edytuj';

  @override
  String get add => 'Dodaj';
}
