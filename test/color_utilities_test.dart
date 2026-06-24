import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

void main() {
  group('NeumorphicColors', () {
    test('decorationWhiteColor creates valid colors', () {
      const baseColor = Color(0xFF808080);
      final result = NeumorphicColors.decorationWhiteColor(baseColor, intensity: 0.5);
      
      expect(result, isA<Color>());
      expect(result.a, lessThanOrEqualTo(baseColor.a));
    });

    test('decorationDarkColor creates valid colors', () {
      const baseColor = Color(0xFF808080);
      final result = NeumorphicColors.decorationDarkColor(baseColor, intensity: 0.5);
      
      expect(result, isA<Color>());
      expect(result.a, lessThanOrEqualTo(baseColor.a));
    });

    test('embossWhiteColor creates valid colors', () {
      const baseColor = Color(0xFF808080);
      final result = NeumorphicColors.embossWhiteColor(baseColor, intensity: 0.5);
      
      expect(result, isA<Color>());
      expect(result.a, lessThanOrEqualTo(baseColor.a));
    });

    test('embossDarkColor creates valid colors', () {
      const baseColor = Color(0xFF808080);
      final result = NeumorphicColors.embossDarkColor(baseColor, intensity: 0.5);
      
      expect(result, isA<Color>());
      expect(result.a, lessThanOrEqualTo(baseColor.a));
    });

    test('gradientShaderWhiteColor creates valid colors', () {
      final result = NeumorphicColors.gradientShaderWhiteColor(intensity: 0.5);
      
      expect(result, isA<Color>());
      expect(result.a, lessThanOrEqualTo(1.0));
    });

    test('gradientShaderDarkColor creates valid colors', () {
      final result = NeumorphicColors.gradientShaderDarkColor(intensity: 0.5);
      
      expect(result, isA<Color>());
      expect(result.a, lessThanOrEqualTo(1.0));
    });

    test('color constants exist and are valid', () {
      expect(NeumorphicColors.background, isA<Color>());
      expect(NeumorphicColors.accent, isA<Color>());
      expect(NeumorphicColors.variant, isA<Color>());
      expect(NeumorphicColors.disabled, isA<Color>());
      expect(NeumorphicColors.darkBackground, isA<Color>());
      expect(NeumorphicColors.darkAccent, isA<Color>());
      expect(NeumorphicColors.darkVariant, isA<Color>());
      expect(NeumorphicColors.darkDisabled, isA<Color>());
    });

    test('intensity parameter affects opacity', () {
      const baseColor = Color(0xFF808080);
      
      final lowIntensity = NeumorphicColors.decorationWhiteColor(baseColor, intensity: 0.1);
      final highIntensity = NeumorphicColors.decorationWhiteColor(baseColor, intensity: 0.9);
      
      expect(lowIntensity.a, lessThan(highIntensity.a));
    });

    test('handles edge intensity values', () {
      const baseColor = Color(0xFF808080);
      
      final minIntensity = NeumorphicColors.decorationWhiteColor(baseColor, intensity: 0.0);
      final maxIntensity = NeumorphicColors.decorationWhiteColor(baseColor, intensity: 1.0);
      
      expect(minIntensity.a, equals(0.0));
      expect(maxIntensity.a, greaterThan(0.0));
    });
  });

  group('Color edge cases', () {
    test('handles pure colors', () {
      const colors = [
        Color(0xFFFF0000), // Red
        Color(0xFF00FF00), // Green
        Color(0xFF0000FF), // Blue
        Color(0xFFFFFF00), // Yellow
        Color(0xFFFF00FF), // Magenta
        Color(0xFF00FFFF), // Cyan
      ];

      for (final color in colors) {
        final whiteColor = NeumorphicColors.decorationWhiteColor(color, intensity: 0.5);
        final darkColor = NeumorphicColors.decorationDarkColor(color, intensity: 0.5);
        final embossWhite = NeumorphicColors.embossWhiteColor(color, intensity: 0.5);
        final embossDark = NeumorphicColors.embossDarkColor(color, intensity: 0.5);

        expect(whiteColor, isA<Color>());
        expect(darkColor, isA<Color>());
        expect(embossWhite, isA<Color>());
        expect(embossDark, isA<Color>());
      }
    });

    test('handles transparent colors', () {
      const transparentColor = Color(0x00000000);
      
      final whiteColor = NeumorphicColors.decorationWhiteColor(transparentColor, intensity: 0.5);
      final darkColor = NeumorphicColors.decorationDarkColor(transparentColor, intensity: 0.5);
      
      expect(whiteColor, isA<Color>());
      expect(darkColor, isA<Color>());
    });
  });
}