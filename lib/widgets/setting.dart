import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zenn_app/widgets/settings/favorite_articles.dart';
import 'package:zenn_app/widgets/settings/history_articles.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  /* 記事管理の共通Tile */
  SettingsTile articleTile({
    required Icon leadingIcon,
    required String title,
    required WidgetBuilder destinationBuilder,
  }) {
    return SettingsTile.navigation(
      leading: leadingIcon,
      title: Text(title),
      onPressed: (context) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: destinationBuilder),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitle = AppLocalizations.of(context)!.title;
    final settingTitle = AppLocalizations.of(context)!.language;
    final languageSectionTitle = AppLocalizations.of(context)!.language;
    final articleManage = AppLocalizations.of(context)!.articleManage;
    final favoriteMenu = AppLocalizations.of(context)!.favorite;
    final version = AppLocalizations.of(context)!.version;
    final historyArticles = AppLocalizations.of(context)!.historyArticles;

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.blue,
        ),
        body: SettingsList( // 設定画面を構築
          sections: [
            /* 言語 */
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
            /* 記事管理 */
            SettingsSection(
                title: Text(articleManage),
                tiles: <SettingsTile> [
                  /* お気に入り */
                  articleTile(
                    leadingIcon: const Icon(Icons.favorite),
                    title: favoriteMenu,
                    destinationBuilder: (_) => const FavoriteArticles(),
                  ),
                  /* 閲覧履歴 */
                  articleTile(
                    leadingIcon: const Icon(Icons.history),
                    title: historyArticles,
                    destinationBuilder: (_) => const HistoryArticles(),
                  ),
                ],
            ),
            /* バージョン */
            SettingsSection(
              title: Text(version),
              tiles:<SettingsTile> [
                SettingsTile(
                  leading: const Icon(Icons.build),
                  title: Text(version),
                  value: const Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                        '1.0',
                      style: TextStyle(
                          fontSize: 16.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
