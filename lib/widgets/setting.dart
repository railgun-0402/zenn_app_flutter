import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zenn_app/helper/storage_helper.dart';
import 'package:zenn_app/models/article.dart';
import 'package:zenn_app/widgets/settings/favorite_articles.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  /* お気に入り一覧 */
  List<Article> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  /* お気に入り一覧を取得 */
  Future<void> _loadFavorites() async {
    final favorites = await StorageHelper.getFavorites();
    // Widgetがマウントされている場合、Navigatorを使用
    if (!mounted) return;

    setState(() {
      _favorites = favorites;
    });
  }

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
                                builder: (_) => FavoriteArticles(
                                favoriteArticles: _favorites
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
