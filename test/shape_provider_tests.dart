import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_neumorphic_plus/src/shape/circle_path_provider.dart';
import 'package:flutter_neumorphic_plus/src/shape/rect_path_provider.dart';
import 'package:flutter_neumorphic_plus/src/shape/rrect_path_provider.dart';
import 'package:flutter_neumorphic_plus/src/shape/stadium_path_provider.dart';
import 'package:flutter_neumorphic_plus/src/shape/beveled_path_provider.dart';

void main() {
  group('NeumorphicBoxShape', () {
    test('circle creates correctly', () {
      final circle = NeumorphicBoxShape.circle();
      
      expect(circle.isCircle, isTrue);
      expect(circle.isRoundRect, isFalse);
      expect(circle.isStadium, isFalse);
      expect(circle.isCustomPath, isFalse);
    });

    test('roundRect creates correctly', () {
      final roundRect = NeumorphicBoxShape.roundRect(BorderRadius.circular(8));
      
      expect(roundRect.isRoundRect, isTrue);
      expect(roundRect.isCircle, isFalse);
      expect((roundRect.customShapePathProvider as RRectPathProvider).borderRadius, BorderRadius.circular(8));
    });

    test('stadium creates correctly', () {
      final stadium = NeumorphicBoxShape.stadium();
      
      expect(stadium.isStadium, isTrue);
      expect(stadium.isCircle, isFalse);
    });

    test('path creates correctly', () {
      const provider = CirclePathProvider();
      final path = NeumorphicBoxShape.path(provider);
      
      expect(path.isCustomPath, isTrue);
      expect(path.customShapePathProvider, provider);
    });

    test('equality works correctly', () {
      final shape1 = NeumorphicBoxShape.circle();
      final shape2 = NeumorphicBoxShape.circle();
      final shape3 = NeumorphicBoxShape.roundRect(BorderRadius.circular(8));
      
      expect(shape1.customShapePathProvider.runtimeType, shape2.customShapePathProvider.runtimeType);
      expect(shape1.customShapePathProvider.runtimeType, isNot(shape3.customShapePathProvider.runtimeType));
    });
  });

  group('Path Providers', () {
    test('CirclePathProvider creates correct path', () {
      const provider = CirclePathProvider();
      final size = Size(100, 100);
      
      final path = provider.getPath(size);
      
      expect(path, isNotNull);
      expect(path.getBounds(), Rect.fromLTWH(0, 0, 100, 100));
    });

    test('RectPathProvider creates correct path', () {
      const provider = RectPathProvider();
      final size = Size(100, 100);
      
      final path = provider.getPath(size);
      
      expect(path, isNotNull);
      expect(path.getBounds(), Rect.fromLTWH(0, 0, 100, 100));
    });

    test('RRectPathProvider creates correct path', () {
      const provider = RRectPathProvider(BorderRadius.zero);
      final rect = Rect.fromLTWH(0, 0, 100, 100);
      
      final path = provider.getPath(Size(100, 100));
      
      expect(path, isNotNull);
      expect(path.getBounds(), rect);
    });

    test('StadiumPathProvider creates correct path', () {
      const provider = StadiumPathProvider();
      final size = Size(100, 50);
      
      final path = provider.getPath(size);
      
      expect(path, isNotNull);
      expect(path.getBounds(), Rect.fromLTWH(0, 0, 100, 50));
    });

    test('BeveledPathProvider creates correct path', () {
      const provider = BeveledPathProvider(BorderRadius.zero);
      final rect = Rect.fromLTWH(0, 0, 100, 100);
      
      final path = provider.getPath(Size(100, 100));
      
      expect(path, isNotNull);
      expect(path.getBounds(), rect);
    });

    test('Path providers return consistent paths for same size', () {
      const provider = CirclePathProvider();
      final size = Size(100, 100);
      
      final path1 = provider.getPath(size);
      final path2 = provider.getPath(size);
      
      // Paths should be equivalent for the same input
      expect(path1.getBounds(), path2.getBounds());
    });
  });

  group('NeumorphicBoxShape with different sizes', () {
    test('circle creates correct paths', () {
      final circle = NeumorphicBoxShape.circle();
      final size1 = Size(100, 100);
      final size2 = Size(200, 100);
      
      final path1 = circle.customShapePathProvider.getPath(size1);
      final path2 = circle.customShapePathProvider.getPath(size2);
      
      // Circle path provider creates a circle within the bounds
      expect(path1, isNotNull);
      expect(path2, isNotNull);
      expect(path1.getBounds().width, 100);
      expect(path1.getBounds().height, 100);
      expect(path2.getBounds().width, 200);
      expect(path2.getBounds().height, 100);
    });

    test('roundRect adapts to different sizes', () {
      final roundRect = NeumorphicBoxShape.roundRect(BorderRadius.circular(8));
      final size1 = Size(100, 100);
      final size2 = Size(200, 50);
      
      final path1 = roundRect.customShapePathProvider.getPath(size1);
      final path2 = roundRect.customShapePathProvider.getPath(size2);
      
      expect(path1.getBounds(), Rect.fromLTWH(0, 0, 100, 100));
      expect(path2.getBounds(), Rect.fromLTWH(0, 0, 200, 50));
    });
  });
}