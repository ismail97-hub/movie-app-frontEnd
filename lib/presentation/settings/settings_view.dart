import 'package:flutter/material.dart';
import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/language_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';
import 'package:movieapp/presentation/settings/settings_viewmodel.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  SettingsViewModel _viewModel = instance<SettingsViewModel>();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.settings.tr()),
        elevation: AppSize.s4,
      ),
      backgroundColor: ColorManager.primary,
      body: StreamBuilder<bool>(
          stream: _viewModel.outputIsNotificaitonAllowed,
          builder: (context, snapshot) {
            bool isNotificationAllowed = snapshot.data ?? false;
            return SettingsList(
              lightTheme: SettingsThemeData(
                settingsListBackground: ColorManager.primary,
                settingsTileTextColor: ColorManager.white.withOpacity(0.8),
                tileDescriptionTextColor: ColorManager.white.withOpacity(0.5),
                titleTextColor: ColorManager.secondary,
              ),
              sections: [
                SettingsSection(
                  title: Text(AppStrings.common.tr()),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      title: Text(AppStrings.language.tr()),
                      value: Text(AppStrings.lang.tr()),
                      onPressed: (context) {
                        _viewModel.changeLanguage(context);
                      },
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        _viewModel.onNotificationToggle(value);
                      },
                      initialValue: isNotificationAllowed,
                      activeSwitchColor: ColorManager.secondary,
                      title: Text(AppStrings.notification.tr()),
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(AppStrings.cache.tr()),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      title: Text(AppStrings.favorites.tr()),
                      trailing: _cacheTrailing(onPressed: () {
                        _viewModel.deleteFavorite(context);
                      }),
                    ),
                    SettingsTile.navigation(
                      title: Text(AppStrings.history.tr()),
                      trailing: _cacheTrailing(onPressed: () {
                        _viewModel.deleteHistory(context);
                      }),
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(AppStrings.about.tr()),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      title: Text(AppStrings.visitSite.tr()),
                      value: Text(Constant.site),
                    ),
                    SettingsTile.navigation(
                      title: Text(AppStrings.Version.tr()),
                      value: Text(Constant.version),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget _cacheTrailing({required Function onPressed}) {
    return TextButton(
        onPressed: () {
          onPressed.call();
        },
        child: Text(
          AppStrings.delete.tr(),
          style: getMediumStyle(
              color: ColorManager.secondary, fontSize: FontSize.s12),
        ));
  }
}
