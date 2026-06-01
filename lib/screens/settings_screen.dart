import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/language_model.dart';

class SettingsScreen extends StatelessWidget {
  final Locale currentLocale;
  final Future<void> Function(Locale locale) onLocaleChanged;

  const SettingsScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  String _localizedLanguageName(AppLocalizations l10n, String code) {
    switch (code) {
      case 'uk':
        return l10n.ukrainian;
      case 'en':
        return l10n.english;
      case 'pl':
        return l10n.polish;
      default:
        return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.language, size: 32),
                  title: Text(
                    l10n.languageLabel,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(l10n.selectLanguage),
                ),
                const Divider(),
                DropdownButtonFormField<String>(
                  initialValue: currentLocale.languageCode,
                  decoration: InputDecoration(
                    labelText: l10n.selectLanguage,
                    border: const OutlineInputBorder(),
                  ),
                  items: LanguageModel.languages.map((language) {
                    return DropdownMenuItem<String>(
                      value: language.code,
                      child: Row(
                        children: [
                          Text(language.flag),
                          const SizedBox(width: 10),
                          Text(_localizedLanguageName(l10n, language.code)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (code) async {
                    if (code == null) return;
                    final language = LanguageModel.getByCode(code);
                    await onLocaleChanged(Locale(code));
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.languageChanged(language.name)),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📋 ${l10n.availableLanguages}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...LanguageModel.languages.map((language) {
                  final isCurrent = language.code == currentLocale.languageCode;
                  return ListTile(
                    leading: Text(
                      language.flag,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(_localizedLanguageName(l10n, language.code)),
                    trailing: isCurrent
                        ? Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                    onTap: () async {
                      if (isCurrent) return;
                      await onLocaleChanged(Locale(language.code));
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.languageChanged(language.name)),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('💰 ${l10n.currencyInfo}'),
                const SizedBox(height: 8),
                Text('📅 ${l10n.dateInfo}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
