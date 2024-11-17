import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zenn_app/widgets/settings/favorite_articles.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarTitle = AppLocalizations.of(context)!.title;
    final settingTitle = AppLocalizations.of(context)!.language;
    final languageSectionTitle = AppLocalizations.of(context)!.language;
    final articleManage = AppLocalizations.of(context)!.articleManage;
    final favoriteMenu = AppLocalizations.of(context)!.favorite;

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.blue,
        ),
        body: SettingsList( // 設定画面を構築
          sections: [
            SettingsSection(
              title: Text(settingTitle),
              tiles:<SettingsTile> [
                SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                    title: Text(languageSectionTitle),
                    value: Text(languageSectionTitle),
                  onPressed: (context) {
                  },
                ),
              ],
            ),
            SettingsSection(
                title: Text(articleManage),
                tiles: <SettingsTile> [
                  SettingsTile.navigation(
                      title: Text(favoriteMenu),
                      onPressed: (context) async {
                        // お気に入り一覧画面へ
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const FavoriteArticles(
                            )),
                        );
                      },
                  ),
                ],
            ),
          ],
        ),
      );
  }
}
