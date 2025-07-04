part of 'app_decoration.dart';

class _ElevatedButtonStyle
{
  const _ElevatedButtonStyle();

  ButtonStyle primary() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.black05;
        if (states.contains(WidgetState.hovered)) return AppColors.white;
        if (states.contains(WidgetState.focused)) return AppColors.white;
        if (states.contains(WidgetState.pressed)) return AppColors.white;
        return AppColors.black;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states){
        if (states.contains(WidgetState.hovered)) return AppColors.black;
        if (states.contains(WidgetState.focused)) return AppColors.black;
        return AppColors.white;
      }),
      minimumSize: WidgetStateProperty.all(const Size(180, 50)),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColors.black, width: 2),
        ),
      ),
    );
  }

  ButtonStyle second() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) return AppColors.black;
        if (states.contains(WidgetState.disabled)) return AppColors.white;
        return AppColors.white;
      }),
      foregroundColor: WidgetStateProperty.all(Colors.black54),
      minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColors.black, width: 2),
        ),
      ),
    );
  }

  ButtonStyle text() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) return AppColors.gray;
        if (states.contains(WidgetState.disabled)) return AppColors.white;
        return AppColors.white;
      }),
      foregroundColor: WidgetStateProperty.all(Colors.black54),
      minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColors.white, width: 2),
        ),
      ),
    );
  }

  ButtonStyle transparent() 
  {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return Colors.transparent;
        if (states.contains(WidgetState.hovered)) return Colors.white10;
        return Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      minimumSize: WidgetStateProperty.all(const Size(180.0, 55.0)),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
      )
    );
  }
 
}