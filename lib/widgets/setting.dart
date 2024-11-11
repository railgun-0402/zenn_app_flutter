import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.title),
          backgroundColor: Colors.blue,
        ),
        body: SettingsList( // 設定画面を構築
          sections: [
            SettingsSection(
              title: Text(AppLocalizations.of(context)!.language),
              tiles:<SettingsTile> [
                SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                    title: Text(AppLocalizations.of(context)!.language),
                    value: Text(AppLocalizations.of(context)!.language),
                  onPressed: (context) {
                  },
                ),
                SettingsTile.switchTile(
                    initialValue: true,
                    onToggle: (value) {
                      // トグルの切り替え処理
                    },
                    title: const Text('Enable custom theme'),
                    leading: const Icon(Icons.format_paint),
                ),
              ],
            )
          ],
        ),
      );
  }
}
