import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tokens from docs/DESIGN.md (light theme, Round 3 radius scale).
abstract final class EriColors {
  static const background = Color(0xFFE5EAF2);
  static const foreground = Color(0xFF0F141D);
  static const card = Color(0xFFFFFFFF);
  static const muted = Color(0xFFE2E6EE);
  static const mutedForeground = Color(0xFF5F636C);
  static const border = Color(0xFFD2D6DD);
  static const primary = Color(0xFF3B5BFF);
  static const primaryBright = Color(0xFF0015EC);
  // verdicts
  static const landed = Color(0xFF2B7A47);
  static const notReceived = Color(0xFFC62B29);
  static const suspicious = Color(0xFF966500);
}

abstract final class EriRadius {
  static const sm = 10.0; // chips, fields inside cards
  static const md = 16.0; // cards, alerts (the default)
  static const lg = 24.0; // panels
  static const xl = 32.0; // big surfaces
  static const pill = 999.0; // buttons, tags, inputs
}

/// Verdict colours as a ThemeExtension, so widgets ask the theme instead of hard-coding them.
class EriVerdicts extends ThemeExtension<EriVerdicts> {
  const EriVerdicts({this.landed = EriColors.landed, this.notReceived = EriColors.notReceived, this.suspicious = EriColors.suspicious});

  final Color landed;
  final Color notReceived;
  final Color suspicious;

  @override
  EriVerdicts copyWith({Color? landed, Color? notReceived, Color? suspicious}) => EriVerdicts(
      landed: landed ?? this.landed, notReceived: notReceived ?? this.notReceived, suspicious: suspicious ?? this.suspicious);

  @override
  EriVerdicts lerp(EriVerdicts? other, double t) => other == null
      ? this
      : EriVerdicts(
          landed: Color.lerp(landed, other.landed, t)!,
          notReceived: Color.lerp(notReceived, other.notReceived, t)!,
          suspicious: Color.lerp(suspicious, other.suspicious, t)!,
        );
}

/// Tests have no network to fetch Google Fonts; they set this to false and get the platform font instead.
bool eriGoogleFonts = true;

/// Lexend 600 for display, Inter for body; numbers use tabular figures so ticking amounts don't jitter.
TextStyle display(double size, {Color color = EriColors.foreground}) {
  final style = TextStyle(
      fontSize: size, fontWeight: FontWeight.w600, letterSpacing: -0.03 * size, height: 1.05, color: color,
      fontFeatures: const [FontFeature.tabularFigures()]);
  return eriGoogleFonts ? GoogleFonts.lexend(textStyle: style) : style;
}

const tabular = [FontFeature.tabularFigures()];

ThemeData eriTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: EriColors.primary,
    brightness: Brightness.light,
    primary: EriColors.primary,
    onPrimary: Colors.white,
    surface: EriColors.background,
    onSurface: EriColors.foreground,
    error: EriColors.notReceived,
  );
  final base = ThemeData.light().textTheme;
  final text = (eriGoogleFonts ? GoogleFonts.interTextTheme(base) : base).apply(
    bodyColor: EriColors.foreground,
    displayColor: EriColors.foreground,
  );
  const pillShape = StadiumBorder();

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: EriColors.background,
    textTheme: text,
    dividerColor: EriColors.border,
    cardTheme: CardThemeData(
      color: EriColors.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(EriRadius.lg)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: pillShape,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: pillShape,
        foregroundColor: EriColors.foreground,
        minimumSize: const Size(0, 48),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: EriColors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: display(20),
      foregroundColor: EriColors.foreground,
    ),
    extensions: const [EriVerdicts()],
  );
}
