import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenn_app/widgets/setting.dart';
import 'package:zenn_app/widgets/settings/favorite_articles.dart';
import 'package:zenn_app/widgets/settings/history_articles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationConfig {
  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const supportedLocales = [
    Locale('en', ''), // 英語
    Locale('ja', ''), // 日本語
  ];
}

void main() {
  group('Setting Widget Tests', () {
    testWidgets('Displays all sections and tiles correctly',
            (WidgetTester tester) async {
          // テスト用のウィジェットをラップ
          await tester.pumpWidget(
            const MaterialApp(
              localizationsDelegates: LocalizationConfig.localizationsDelegates,
              supportedLocales: LocalizationConfig.supportedLocales,
              home: Setting(),
            ),
          );

          // 設定セクションが正しく表示されることを確認
          expect(find.text('Language'), findsAny); // 言語セクション
          expect(find.text('ArticleManage'), findsOneWidget); // 記事管理セクション
          expect(find.text('version'), findsAny); // バージョンセクション

          // 設定タイルが正しく表示されることを確認
          expect(find.text('Favorite'), findsOneWidget); // お気に入り
          expect(find.text('historyArticles'), findsOneWidget); // 閲覧履歴
          expect(find.text('1.0'), findsOneWidget); // バージョン番号
        });

    testWidgets('Navigates to Favorite Articles screen when Favorite tile is tapped',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              localizationsDelegates: LocalizationConfig.localizationsDelegates,
              supportedLocales: LocalizationConfig.supportedLocales,
              home: Setting(),
            ),
          );

          // Favorite タイルをタップ
          await tester.tap(find.text('Favorite'));
          await tester.pumpAndSettle();

          // FavoriteArticles 画面が表示されることを確認
          expect(find.byType(FavoriteArticles), findsOneWidget);
        });

    testWidgets('Navigates to History Articles screen when History tile is tapped',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              localizationsDelegates: LocalizationConfig.localizationsDelegates,
              supportedLocales: LocalizationConfig.supportedLocales,
              home: Setting(),
            ),
          );

          // History タイルをタップ
          await tester.tap(find.text('historyArticles'));
          await tester.pumpAndSettle();

          // HistoryArticles 画面が表示されることを確認
          expect(find.byType(HistoryArticles), findsOneWidget);
        });

    testWidgets('Displays version number correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: LocalizationConfig.localizationsDelegates,
          supportedLocales: LocalizationConfig.supportedLocales,
          home: Setting(),
        ),
      );

      // バージョン番号が正しく表示されていることを確認
      expect(find.text('1.0'), findsOneWidget);
    });
  });
}
