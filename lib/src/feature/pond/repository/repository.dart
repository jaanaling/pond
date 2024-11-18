import 'package:pond_care/src/feature/pond/models/decoration.dart';
import 'package:pond_care/src/feature/pond/models/fish.dart';
import 'package:pond_care/src/feature/pond/models/plant.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';

import '../../../core/utils/json_loader.dart';

class PondRepository {
  final String key = 'pond';

  Future<List<Pond>> load() {
    return JsonLoader.loadData<Pond>(
      key,
      'assets/json/$key.json',
      (json) => Pond.fromMap(json),
    );
  }

  Future<List<Fish>> loadFish() {
    return JsonLoader.loadData<Fish>(
      key,
      'assets/json/fish.json',
      (json) => Fish.fromMap(json),
    );
  }

  Future<List<Plant>> loadPlants() {
    return JsonLoader.loadData<Plant>(
      key,
      'assets/json/plants.json',
      (json) => Plant.fromMap(json),
    );
  }

  Future<List<Decorations>> loadDecorations() {
    return JsonLoader.loadData<Decorations>(
      key,
      'assets/json/decorations.json',
      (json) => Decorations.fromMap(json),
    );
  }

  Future<void> update(Pond updated) async {
    return JsonLoader.modifyDataList<Pond>(
      key,
      updated,
      () async => await load(),
      (item) => item.toMap(),
      (itemList) async {
        final index = itemList.indexWhere((d) => d.id == updated.id);
        if (index != -1) {
          itemList[index] = updated;
        }
      },
    );
  }

  Future<void> save(Pond item) {
    return JsonLoader.saveData<Pond>(
      key,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }

  Future<void> remove(Pond item) {
    return JsonLoader.removeData<Pond>(
      key,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }
}
