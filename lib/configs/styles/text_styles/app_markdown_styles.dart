part of 'app_text_styles.dart';

class AppMarkdownStyles {
  const AppMarkdownStyles._();
  static const baseFont = 'SF pro';

  static MarkdownStyleSheet defaultStyle() => MarkdownStyleSheet(
        h1: const TextStyle(
          fontFamily: baseFont,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        h2: const TextStyle(
          fontFamily: baseFont,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        h3: const TextStyle(
          fontFamily: baseFont,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        p: const TextStyle(
          fontFamily: baseFont,
          fontSize: 16,
          color: Colors.white70,
          height: 1.6,
        ),
        strong: const TextStyle(
          fontFamily: baseFont,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        em: const TextStyle(
          fontFamily: baseFont,
          fontStyle: FontStyle.italic,
          color: Colors.white70,
        ),
        blockquote: const TextStyle(
          fontFamily: baseFont,
          fontStyle: FontStyle.italic,
          color: Colors.greenAccent,
        ),
        code: const TextStyle(
          fontFamily: 'Courier',
          color: Colors.orangeAccent,
          backgroundColor: Color(0xFF333333),
        ),
        listBullet: const TextStyle(
          fontFamily: baseFont,
          fontSize: 16,
          color: Colors.white,
        ),
        tableHead: const TextStyle(
          fontFamily: baseFont,
          fontWeight: FontWeight.w600,
          color: Colors.cyanAccent,
        ),
        tableBody: const TextStyle(
          fontFamily: baseFont,
          fontSize: 14,
          color: Colors.white,
        ),
      );
}
