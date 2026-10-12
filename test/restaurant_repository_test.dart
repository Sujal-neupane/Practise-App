import 'package:flutter_test/flutter_test.dart';
import 'package:practise_app/features/home/data/restaurant_repository.dart';

void main() {
  test('returns paged restaurants and marks the final page', () async {
    final repository = RestaurantRepository();

    final firstPage = await repository.fetchPage(page: 0, pageSize: 3);
    final secondPage = await repository.fetchPage(page: 1, pageSize: 3);

    expect(firstPage.items, hasLength(3));
    expect(firstPage.hasMore, isTrue);
    expect(secondPage.items, hasLength(3));
    expect(secondPage.hasMore, isFalse);
  });

  test('returns an empty page after the final page', () async {
    final page = await RestaurantRepository().fetchPage(page: 2, pageSize: 3);

    expect(page.items, isEmpty);
    expect(page.hasMore, isFalse);
  });
}
