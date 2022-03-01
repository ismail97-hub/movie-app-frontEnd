import 'package:flutter/material.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';
import 'package:movieapp/presentation/settings/settings_viewmodel.dart';
import 'package:settings_ui/settings_ui.dart';

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
        title: Text("Settings"),
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
                  title: Text('Common'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      title: Text('Language'),
                      value: Text('English'),
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        _viewModel.onNotificationToggle(value);
                      },
                      initialValue: isNotificationAllowed,
                      activeSwitchColor: ColorManager.secondary,
                      title: Text('Notification'),
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text('Cache'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      title: Text('Favorite'),
                      trailing: _cacheTrailing(onPressed: (){_viewModel.deleteFavorite(context);}),
                    ),
                    SettingsTile.navigation(
                      title: Text('History'),
                      trailing:_cacheTrailing(onPressed: (){_viewModel.deleteHistory(context);}),
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text('About'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      title: Text('Visit site'),
                      value: Text('https://www.movcima.com'),
                    ),
                    SettingsTile.navigation(
                      title: Text('Version'),
                      value: Text('1.0.0'),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget _cacheTrailing({required Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p6),
      child: TextButton(
          onPressed: () {onPressed.call();},
          child: Text(
            "delete",
            style: getMediumStyle(
                color: ColorManager.secondary, fontSize: FontSize.s12),
          )),
    );
  }
}
