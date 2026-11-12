import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;

import 'app_theme_color.dart';

class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.bg,
    required this.railBg,
    required this.sideBg,
    required this.cardBg,
    required this.cardHoverBg,
    required this.surfaceSoft,
    required this.inputBg,
    required this.footerBg,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.primaryActionBg,
    required this.primaryActionForeground,
    required this.primaryActionHoverBg,
    required this.brand,
    required this.brandForeground,
    required this.brandSoft,
    required this.brandTrack,
    required this.brandProgress,
    required this.accent,
    required this.accentOn,
    required this.error,
    required this.success,
    required this.toggleBg,
    required this.toggleIcon,
    required this.itemActiveBg,
    required this.filterActiveBg,
    required this.progressTrack,
    required this.taskCardSelectedBorder,
    required this.taskCardHoverBg,
    required this.taskCardAction,
    required this.taskCardProgressFill,
    required this.taskCardIconBg,
    required this.taskCardFailedIconBg,
    required this.taskMeta,
    required this.taskMetaSubtle,
    required this.taskErrorMeta,
    required this.searchHint,
    required this.headerDivider,
    required this.captionButtonHover,
    required this.captionButtonCloseHover,
  });

  static const Color lightAccent = Color(0xFF1F6FEB);

  // 「冷雾海洋」配色：中性色偏冷灰蓝，强调色用清澈的天青蓝，
  // 让卡片、进度条、选中态在同一套色系里过渡，不再是原来的草绿。
  static const light = AppPalette(
    bg: Color(0xFFF3F6FB),
    railBg: Color(0xFFE7EDF6),
    sideBg: Color(0xFFEFF4FA),
    cardBg: Color(0xFFFFFFFF),
    cardHoverBg: Color(0xFFF5F8FD),
    surfaceSoft: Color(0xFFEAF0F7),
    inputBg: Color(0xFFEDF2F8),
    footerBg: Color(0xFFF7FAFE),
    border: Color(0x66A9BDD4),
    textPrimary: Color(0xFF0E1726),
    textSecondary: Color(0xFF54637A),
    textMuted: Color(0xFF7C8AA0),
    primaryActionBg: Color(0xFF0E1726),
    primaryActionForeground: Color(0xFFFFFFFF),
    primaryActionHoverBg: Color(0xFF1B2A40),
    brand: lightAccent,
    brandForeground: Color(0xFFFFFFFF),
    brandSoft: Color(0x141F6FEB),
    brandTrack: Color(0x261F6FEB),
    brandProgress: Color(0xFF1F6FEB),
    accent: Color(0xFFEDF2F8),
    accentOn: Color(0xFFF7FAFE),
    error: Color(0xFFD92D20),
    success: Color(0xFF07875A),
    toggleBg: Color(0xFFFFFFFF),
    toggleIcon: Color(0xFF54637A),
    itemActiveBg: Color(0x141F6FEB),
    filterActiveBg: Color(0x331F6FEB),
    progressTrack: Color(0x33A9BDD4),
    taskCardSelectedBorder: Color(0x401F6FEB),
    taskCardHoverBg: Color(0xFFEFF5FD),
    taskCardAction: Color(0xFF54637A),
    taskCardProgressFill: Color(0xFF1F6FEB),
    taskCardIconBg: Color(0xFFF5F8FD),
    taskCardFailedIconBg: Color(0x14D92D20),
    taskMeta: Color(0xFF54637A),
    taskMetaSubtle: Color(0xFF7C8AA0),
    taskErrorMeta: Color(0xCCD92D20),
    searchHint: Color(0xFF7C8AA0),
    headerDivider: Color(0xA3A9BDD4),
    captionButtonHover: Color(0x0F0E1726),
    captionButtonCloseHover: Color(0xFFE5484D),
  );

  static final dark = AppPalette(
    bg: const Color(0xFF0A0E14),
    railBg: Colors.black,
    sideBg: const Color(0xFF0E131A),
    cardBg: const Color(0xFF121923),
    cardHoverBg: const Color(0xFF16202B),
    surfaceSoft: const Color(0xFF1A2431),
    inputBg: const Color(0xFF0F1620),
    footerBg: Colors.black.withValues(alpha: 0.25),
    border: const Color(0xFF253243),
    textPrimary: const Color(0xFFF2F6FC),
    textSecondary: const Color(0xFFA7B4C6),
    textMuted: const Color(0xFF6F7C90),
    primaryActionBg: const Color(0xFFF2F6FC),
    primaryActionForeground: const Color(0xFF0A0E14),
    primaryActionHoverBg: const Color(0xFFDDE6F1),
    brand: const Color(0xFF6EA8FF),
    brandForeground: const Color(0xFF06152E),
    brandSoft: const Color(0x1A6EA8FF),
    brandTrack: const Color(0x2C6EA8FF),
    brandProgress: const Color(0xFF6EA8FF),
    accent: const Color(0xFF0F1620),
    accentOn: const Color(0xFF0A0E14),
    error: const Color(0xFFFF8A80),
    success: const Color(0xFF4ADE80),
    toggleBg: Colors.white.withValues(alpha: 0.08),
    toggleIcon: const Color(0xFFA7B4C6),
    itemActiveBg: Colors.white.withValues(alpha: 0.08),
    filterActiveBg: const Color(0x3D6EA8FF),
    progressTrack: const Color(0xFF1B2431),
    taskCardSelectedBorder: const Color(0xFF31425A),
    taskCardHoverBg: const Color(0xFF16202B),
    taskCardAction: const Color(0xFFC3CEDC),
    taskCardProgressFill: const Color(0xFF6EA8FF),
    taskCardIconBg: const Color(0xFF161F2A),
    taskCardFailedIconBg: const Color(0xFF2A1D1F),
    taskMeta: const Color(0xFF9AA8BB),
    taskMetaSubtle: const Color(0xFF6F7C90),
    taskErrorMeta: const Color(0xFFD89A93),
    searchHint: const Color(0xFF55627A),
    headerDivider: const Color(0x1AFFFFFF),
    captionButtonHover: const Color(0x0DFFFFFF),
    captionButtonCloseHover: const Color(0xFFE81123),
  );

  static AppPalette lightFor(AppThemeColor themeColor) {
    if (themeColor == AppThemeColor.azure) return light;
    return _withThemeColor(light, color: themeColor.light, foreground: themeColor.lightForeground, dark: false);
  }

  static AppPalette darkFor(AppThemeColor themeColor) {
    if (themeColor == AppThemeColor.azure) return dark;
    return _withThemeColor(dark, color: themeColor.dark, foreground: themeColor.darkForeground, dark: true);
  }

  static AppPalette _withThemeColor(
    AppPalette palette, {
    required Color color,
    required Color foreground,
    required bool dark,
  }) {
    return palette.copyWith(
      brand: color,
      brandForeground: foreground,
      brandSoft: color.withValues(alpha: dark ? 0.10 : 0.08),
      brandTrack: color.withValues(alpha: dark ? 0.17 : 0.15),
      brandProgress: color,
      filterActiveBg: color.withValues(alpha: dark ? 0.24 : 0.20),
      taskCardProgressFill: color,
    );
  }

  final Color bg;
  final Color railBg;
  final Color sideBg;
  final Color cardBg;
  final Color cardHoverBg;
  final Color surfaceSoft;
  final Color inputBg;
  final Color footerBg;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color primaryActionBg;
  final Color primaryActionForeground;
  final Color primaryActionHoverBg;
  final Color brand;
  final Color brandForeground;
  final Color brandSoft;
  final Color brandTrack;
  final Color brandProgress;
  final Color accent;
  final Color accentOn;
  final Color error;
  final Color success;
  final Color toggleBg;
  final Color toggleIcon;
  final Color itemActiveBg;
  final Color filterActiveBg;
  final Color progressTrack;
  final Color taskCardSelectedBorder;
  final Color taskCardHoverBg;
  final Color taskCardAction;
  final Color taskCardProgressFill;
  final Color taskCardIconBg;
  final Color taskCardFailedIconBg;
  final Color taskMeta;
  final Color taskMetaSubtle;
  final Color taskErrorMeta;
  final Color searchHint;
  final Color headerDivider;
  final Color captionButtonHover;
  final Color captionButtonCloseHover;

  static AppPalette of(BuildContext context) {
    final extension = Theme.of(context).extension<AppPalette>();
    if (extension != null) {
      return extension;
    }
    return shad.Theme.of(context).brightness == Brightness.light ? light : dark;
  }

  @override
  AppPalette copyWith({
    Color? bg,
    Color? railBg,
    Color? sideBg,
    Color? cardBg,
    Color? cardHoverBg,
    Color? surfaceSoft,
    Color? inputBg,
    Color? footerBg,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? primaryActionBg,
    Color? primaryActionForeground,
    Color? primaryActionHoverBg,
    Color? brand,
    Color? brandForeground,
    Color? brandSoft,
    Color? brandTrack,
    Color? brandProgress,
    Color? accent,
    Color? accentOn,
    Color? error,
    Color? success,
    Color? toggleBg,
    Color? toggleIcon,
    Color? itemActiveBg,
    Color? filterActiveBg,
    Color? progressTrack,
    Color? taskCardSelectedBorder,
    Color? taskCardHoverBg,
    Color? taskCardAction,
    Color? taskCardProgressFill,
    Color? taskCardIconBg,
    Color? taskCardFailedIconBg,
    Color? taskMeta,
    Color? taskMetaSubtle,
    Color? taskErrorMeta,
    Color? searchHint,
    Color? headerDivider,
    Color? captionButtonHover,
    Color? captionButtonCloseHover,
  }) {
    return AppPalette(
      bg: bg ?? this.bg,
      railBg: railBg ?? this.railBg,
      sideBg: sideBg ?? this.sideBg,
      cardBg: cardBg ?? this.cardBg,
      cardHoverBg: cardHoverBg ?? this.cardHoverBg,
      surfaceSoft: surfaceSoft ?? this.surfaceSoft,
      inputBg: inputBg ?? this.inputBg,
      footerBg: footerBg ?? this.footerBg,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      primaryActionBg: primaryActionBg ?? this.primaryActionBg,
      primaryActionForeground: primaryActionForeground ?? this.primaryActionForeground,
      primaryActionHoverBg: primaryActionHoverBg ?? this.primaryActionHoverBg,
      brand: brand ?? this.brand,
      brandForeground: brandForeground ?? this.brandForeground,
      brandSoft: brandSoft ?? this.brandSoft,
      brandTrack: brandTrack ?? this.brandTrack,
      brandProgress: brandProgress ?? this.brandProgress,
      accent: accent ?? this.accent,
      accentOn: accentOn ?? this.accentOn,
      error: error ?? this.error,
      success: success ?? this.success,
      toggleBg: toggleBg ?? this.toggleBg,
      toggleIcon: toggleIcon ?? this.toggleIcon,
      itemActiveBg: itemActiveBg ?? this.itemActiveBg,
      filterActiveBg: filterActiveBg ?? this.filterActiveBg,
      progressTrack: progressTrack ?? this.progressTrack,
      taskCardSelectedBorder: taskCardSelectedBorder ?? this.taskCardSelectedBorder,
      taskCardHoverBg: taskCardHoverBg ?? this.taskCardHoverBg,
      taskCardAction: taskCardAction ?? this.taskCardAction,
      taskCardProgressFill: taskCardProgressFill ?? this.taskCardProgressFill,
      taskCardIconBg: taskCardIconBg ?? this.taskCardIconBg,
      taskCardFailedIconBg: taskCardFailedIconBg ?? this.taskCardFailedIconBg,
      taskMeta: taskMeta ?? this.taskMeta,
      taskMetaSubtle: taskMetaSubtle ?? this.taskMetaSubtle,
      taskErrorMeta: taskErrorMeta ?? this.taskErrorMeta,
      searchHint: searchHint ?? this.searchHint,
      headerDivider: headerDivider ?? this.headerDivider,
      captionButtonHover: captionButtonHover ?? this.captionButtonHover,
      captionButtonCloseHover: captionButtonCloseHover ?? this.captionButtonCloseHover,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) {
      return this;
    }
    return AppPalette(
      bg: Color.lerp(bg, other.bg, t)!,
      railBg: Color.lerp(railBg, other.railBg, t)!,
      sideBg: Color.lerp(sideBg, other.sideBg, t)!,
      cardBg: Color.lerp(cardBg, other.cardBg, t)!,
      cardHoverBg: Color.lerp(cardHoverBg, other.cardHoverBg, t)!,
      surfaceSoft: Color.lerp(surfaceSoft, other.surfaceSoft, t)!,
      inputBg: Color.lerp(inputBg, other.inputBg, t)!,
      footerBg: Color.lerp(footerBg, other.footerBg, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      primaryActionBg: Color.lerp(primaryActionBg, other.primaryActionBg, t)!,
      primaryActionForeground: Color.lerp(primaryActionForeground, other.primaryActionForeground, t)!,
      primaryActionHoverBg: Color.lerp(primaryActionHoverBg, other.primaryActionHoverBg, t)!,
      brand: Color.lerp(brand, other.brand, t)!,
      brandForeground: Color.lerp(brandForeground, other.brandForeground, t)!,
      brandSoft: Color.lerp(brandSoft, other.brandSoft, t)!,
      brandTrack: Color.lerp(brandTrack, other.brandTrack, t)!,
      brandProgress: Color.lerp(brandProgress, other.brandProgress, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentOn: Color.lerp(accentOn, other.accentOn, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      toggleBg: Color.lerp(toggleBg, other.toggleBg, t)!,
      toggleIcon: Color.lerp(toggleIcon, other.toggleIcon, t)!,
      itemActiveBg: Color.lerp(itemActiveBg, other.itemActiveBg, t)!,
      filterActiveBg: Color.lerp(filterActiveBg, other.filterActiveBg, t)!,
      progressTrack: Color.lerp(progressTrack, other.progressTrack, t)!,
      taskCardSelectedBorder: Color.lerp(taskCardSelectedBorder, other.taskCardSelectedBorder, t)!,
      taskCardHoverBg: Color.lerp(taskCardHoverBg, other.taskCardHoverBg, t)!,
      taskCardAction: Color.lerp(taskCardAction, other.taskCardAction, t)!,
      taskCardProgressFill: Color.lerp(taskCardProgressFill, other.taskCardProgressFill, t)!,
      taskCardIconBg: Color.lerp(taskCardIconBg, other.taskCardIconBg, t)!,
      taskCardFailedIconBg: Color.lerp(taskCardFailedIconBg, other.taskCardFailedIconBg, t)!,
      taskMeta: Color.lerp(taskMeta, other.taskMeta, t)!,
      taskMetaSubtle: Color.lerp(taskMetaSubtle, other.taskMetaSubtle, t)!,
      taskErrorMeta: Color.lerp(taskErrorMeta, other.taskErrorMeta, t)!,
      searchHint: Color.lerp(searchHint, other.searchHint, t)!,
      headerDivider: Color.lerp(headerDivider, other.headerDivider, t)!,
      captionButtonHover: Color.lerp(captionButtonHover, other.captionButtonHover, t)!,
      captionButtonCloseHover: Color.lerp(captionButtonCloseHover, other.captionButtonCloseHover, t)!,
    );
  }
}
