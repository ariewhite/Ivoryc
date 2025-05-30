part of 'app_text_styles.dart';

class _Button{
  const _Button();

  TextStyle defaultStyle() => AppTextStyles.defaultStyle().copyWith(
    color: AppColors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  );

  TextStyle primary({
    bool isDisabled = false,
  }) =>
    defaultStyle().copyWith(
      color: AppColors.white,
    );

  TextStyle second({
    bool isDisabled = false,
  }) =>
    defaultStyle().copyWith(
      color: AppColors.black,
    );

  TextStyle disabled() => defaultStyle().copyWith(
    color: AppColors.black30,
  );
}