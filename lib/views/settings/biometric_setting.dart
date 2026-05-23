/*
* Copyright (C) Keshav Priyadarshi and others - All Rights Reserved.
*
* SPDX-License-Identifier: GPL-3.0-or-later
* You may use, distribute and modify this code under the
* terms of the GPL-3.0+ license.
*
* You should have received a copy of the GNU General Public License v3.0 with
* this file. If not, please visit https://www.gnu.org/licenses/gpl-3.0.html
*
* See https://github.com/SifMuna/UpperNotes
*/

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:settings_ui/settings_ui.dart';

// Project imports:
import 'package:uppernotes/data/preference_and_config.dart';
import 'package:uppernotes/models/app_theme.dart';
import 'package:uppernotes/models/biometric_auth.dart';
import 'package:uppernotes/utils/styles.dart';

class BiometricSetting extends StatefulWidget {
  const BiometricSetting({super.key});

  @override
  State<BiometricSetting> createState() => _BiometricSettingState();
}

class _BiometricSettingState extends State<BiometricSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biometric'.tr(),
          style: appBarTitle,
        ),
      ),
      body: _settings(),
    );
  }

  Widget _settings() {
    final bool biometricOn = PreferencesStorage.isBiometricAuthEnabled;
    final bool intervalMode =
        PreferencesStorage.biometricChallengeMode == 'interval';
    final int days = PreferencesStorage.passphraseRequiredEveryDays;

    return SettingsList(
      platform: DevicePlatform.iOS,
      lightTheme: const SettingsThemeData(),
      darkTheme: SettingsThemeData(
        settingsListBackground: AppThemes.darkSettingsScaffold,
        settingsSectionBackground: AppThemes.darkSettingsCanvas,
      ),
      sections: [
        SettingsSection(
          tiles: <SettingsTile>[
            SettingsTile.switchTile(
              initialValue: biometricOn,
              title: Text('Enable biometric authentication'.tr()),
              onToggle: (value) {
                if (value) {
                  BiometricAuth.enable();
                } else {
                  BiometricAuth.disable();
                }

                setState(() {});
              },
              description: Text(
                "Users are advised to assess their threat perception before enabling biometric authentication. Don't enable this if you're storing state secrets! Visit FAQs for more information."
                    .tr(),
              ),
            ),
          ],
        ),
        if (biometricOn)
          SettingsSection(
            title: Text('Passphrase challenge'.tr()),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                initialValue: !intervalMode,
                title: Text('Allow biometrics indefinitely'.tr()),
                description: Text(
                  'When on, biometrics alone unlocks the app. When off, the passphrase is required at least once every {days} days.'
                      .tr(namedArgs: {'days': days.toString()}),
                ),
                onToggle: (value) async {
                  await PreferencesStorage.setBiometricChallengeMode(
                      value ? 'indefinite' : 'interval');
                  setState(() {});
                },
              ),
              if (intervalMode)
                SettingsTile.navigation(
                  title: Text('Require passphrase every'.tr()),
                  value: Text(
                      '{days} days'.tr(namedArgs: {'days': days.toString()})),
                  onPressed: (context) async {
                    final picked = await _pickIntervalDays(context, days);
                    if (picked != null) {
                      await PreferencesStorage.setPassphraseRequiredEveryDays(
                          picked);
                      setState(() {});
                    }
                  },
                ),
            ],
          ),
      ],
    );
  }

  Future<int?> _pickIntervalDays(BuildContext context, int current) async {
    final controller = TextEditingController(text: current.toString());
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Require passphrase every'.tr()),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            enableSuggestions: false,
            autocorrect: false,
            enableIMEPersonalizedLearning: false,
            decoration: InputDecoration(
              suffixText: 'days'.tr(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'.tr()),
            ),
            TextButton(
              onPressed: () {
                final parsed = int.tryParse(controller.text.trim());
                if (parsed != null && parsed >= 1 && parsed <= 365) {
                  Navigator.of(context).pop(parsed);
                }
              },
              child: Text('Save'.tr()),
            ),
          ],
        );
      },
    );
  }
}
