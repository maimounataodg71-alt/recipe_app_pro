import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_app_pro/data/favorites_controller.dart';

void main() {
  group('FavoritesController', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('aucun favori au démarrage sans données persistées', () async {
      final controller = FavoritesController();
      await controller.load();
      expect(controller.favoriteIds, isEmpty);
    });

    test('toggle() ajoute puis retire un identifiant', () async {
      final controller = FavoritesController();
      await controller.load();

      await controller.toggle('r1');
      expect(controller.isFavorite('r1'), isTrue);

      await controller.toggle('r1');
      expect(controller.isFavorite('r1'), isFalse);
    });

    test('toggle() notifie les auditeurs', () async {
      final controller = FavoritesController();
      await controller.load();
      var notified = false;
      controller.addListener(() => notified = true);

      await controller.toggle('r2');

      expect(notified, isTrue);
    });

    test('les favoris persistent entre deux instances', () async {
      final controller = FavoritesController();
      await controller.load();
      await controller.toggle('r3');

      final newController = FavoritesController();
      await newController.load();

      expect(newController.isFavorite('r3'), isTrue);
    });
  });
}
