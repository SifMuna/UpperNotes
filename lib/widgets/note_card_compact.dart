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
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:uppernotes/data/preference_and_config.dart';
import 'package:uppernotes/models/safenote.dart';
import 'package:uppernotes/utils/notes_color.dart';
import 'package:uppernotes/utils/string_utils.dart';
import 'package:uppernotes/utils/text_direction_util.dart';

class NoteCardWidgetCompact extends StatelessWidget {
  final SafeNote note;
  final int index;

  const NoteCardWidgetCompact({
    super.key,
    required this.note,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Pick colors from the accent colors based on index
    final color = NotesColor.getNoteColor(notIndex: index);
    final fontColor = getFontColorForBackground(color);
    final previewText = note.title == ' ' ? note.description : note.title;

    return Card(
      shadowColor: PreferencesStorage.isThemeDark ? Colors.white : Colors.black,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: AutoSizeText(
          sanitize(previewText),
          textDirection: getTextDirecton(previewText),
          style: TextStyle(
            color: fontColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'MerriweatherBlack',
          ),
          minFontSize: 15,
          maxLines: 2,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
