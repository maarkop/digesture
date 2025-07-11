import 'package:flutter/material.dart';
import 'package:syllable/layers/phrase.dart';
import 'layers/interface.dart';
import 'layers/library.dart';
import 'template/prefs.dart';
import 'template/theme.dart';
import 'template/tile.dart';
import 'layers/cursor.dart';

const locales = [
  ...['Serbian', 'English', 'Spanish', 'German', 'French', 'Italian'],
  ...['Polish', 'Portuguese', 'Russian', 'Slovenian', 'Japanese']
];
const tops = ['Primary', 'Black', 'Transparent'];
const initSyllables = ['a', 'A', 'e', 'E', 'i', 'I', 'o', 'O', 'u', 'U'];
const initBreakpoints = ['(', ')', '-', '.', ',', '!', '?', ':', ';'];
const aligns = ['Left', 'Right', 'Center', 'Justify', 'Start', 'End'];
const shifts = ['Syllable', '2 Syllables', 'Word', '1', '2', '5'];
const fonts = [
  ...['JetBrainsMono', 'Departure', 'Haxorville'],
  ...['OpeningHoursMono', 'RobotoMono', 'YukiCode'],
];

enum Pref<T> {
  font('Font', 'JetBrainsMono', Icons.format_italic_rounded,
      ui: true, all: fonts),
  locale('Language', 'English', Icons.language_rounded, ui: true, all: locales),
  appbar('Top', 'Black', Icons.gradient_rounded, all: tops, ui: true),
  background('Background', 'F0F8FF', Icons.tonality_rounded, ui: true),
  primary('Primary', '000000', Icons.colorize_rounded, ui: true),
  backgroundDark('Dark background', '0F0A0A', Icons.tonality_rounded, ui: true),
  primaryDark('Dark primary', 'FEDBD0', Icons.colorize_rounded, ui: true),
  debug('Developer', false, Icons.developer_mode_rounded),
  //
  //INTERFACE
  clearAnimation('Clear animation', 30, Icons.animation_rounded),
  preload('Preload', 2000, Icons.clear_all_rounded),
  fontSize('Font size', 18, Icons.format_size_rounded, ui: true),
  fontBold('Bold', true, Icons.format_bold_rounded, ui: true),
  fontAlign('Text align', 'Center', Icons.format_align_justify,
      ui: true, all: aligns),
  //
  //CURSOR
  exponential('Exponential intensity', false, Icons.stacked_line_chart_rounded),
  cursorShift('Shift', 'Word', Icons.space_bar_rounded, all: shifts),
  syllables('Syllables', initSyllables, Icons.crop_16_9_rounded),
  cursorDelay('Delay', 5, Icons.animation_rounded),
  intensity('Intensity', 20, Icons.gesture_rounded),
  normalised('Normalise by length', false, Icons.straighten_rounded),
  //
  //PHRASE
  phraseMultiplier('Phrase animation', 6, Icons.animation_rounded),
  phraseBreaks('Phrase breaks', initBreakpoints, Icons.crop_16_9_rounded),
  phraseOpacity('Phrase opacity', 10, Icons.tonality_rounded, ui: true),
  //
  //LIBRARY
  book('Book', '', null),
  cache(null, '', null),
  ;

  final T initial;
  final List<T>? all;
  final String? title; //Backend is null
  final IconData? icon;
  final bool ui, secret;

  const Pref(
    this.title,
    this.initial,
    this.icon, {
    this.all,
    this.ui = false,
    this.secret = false,
  });

  T get value => Preferences.get(this);

  Future set(T val) => Preferences.set(this, val);

  Future rev() => Preferences.rev(this);

  Future next() => Preferences.next(this);

  void nextByLayer({String suffix = ''}) {
    NextByLayer(this, suffix: suffix).show();
  }

  bool get isInitial => value == initial;

  @override
  toString() => name;
}

final textKey = GlobalKey();

List<Tile> get settings {
  return [
    Tile('Library', Icons.book_rounded, '', LibraryLayer().show),
    Tile('Interface', Icons.toggle_on, '', InterfaceLayer().show),
    Tile('Cursor', Icons.code_rounded, '', CursorLayer().show),
    Tile('Phrase', Icons.crop_16_9_rounded, '', PhraseLayer().show),
    Tile('Primary', Icons.colorize_rounded, '', ThemeLayer(true).show),
    Tile('Background', Icons.tonality_rounded, '', ThemeLayer(false).show),
  ];
}
