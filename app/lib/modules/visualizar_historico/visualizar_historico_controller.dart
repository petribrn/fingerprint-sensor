import 'dart:async';

import 'package:collection/collection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

import '../../contracts/contracts.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../global_widgets/global_widgets.dart';
import '../modules.dart';

class GetxVisualizarHistoricoController extends GetxController implements VisualizarHistoricoController {
  final HistoryRecordRepository historyRecordRepository;
  final BottomNavigationBarUtils bottomNavigationBarUtils;

  StreamSubscription? tabSubscription;

  GetxVisualizarHistoricoController({
    required this.historyRecordRepository,
    required this.bottomNavigationBarUtils,
  });

  final _historyRecords = <String, List<HistoryRecord>>{}.obs;
  final _isLoading = true.obs;

  @override
  RxMap<String, List<HistoryRecord>> get historyRecordsRx => _historyRecords;

  @override
  Map<String, List<HistoryRecord>> get historyRecords => _historyRecords;

  @override
  bool get isLoading => _isLoading.value;

  @override
  int get latestDayReadCount {
    if (historyRecords.entries.isEmpty) {
      return 0;
    }

    return historyRecords.entries.first.value.length;
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    _initOnPageOpenListener();
    await _fetchHistoryRecords();
  }

  void _initOnPageOpenListener() {
    tabSubscription = bottomNavigationBarUtils.onTabChangedStream.listen((mode) async {
      if (mode == AccessMode.verificar_biometria) {
        await _fetchHistoryRecords();
      }
    });
  }

  Future<void> _fetchHistoryRecords() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return await Get.dialog(const ConnectivityDialog());
    }

    _isLoading.value = true;

    // final historyRecordsFetched = await historyRecordRepository.fetchAllHistoryRecords() ?? [];

    // Sorting by latest creation date
    // final historyRecordsRaw = historyRecordsFetched..sort((f1, f2) => f2.readDate.compareTo(f1.readDate));

    // Remove this mocks when API is fully integrated
    final historyRecordsRaw = <HistoryRecord>[
      HistoryRecord(fingerprint: Fingerprint(fingerprintId: 1, creationDate: DateTime(2017, 9, 7)), readDate: DateTime(2021, 9, 7, 14, 55)),
      HistoryRecord(fingerprint: Fingerprint(fingerprintId: 8, creationDate: DateTime(2021, 9, 7)), readDate: DateTime(2022, 9, 7, 19, 7)),
      HistoryRecord(fingerprint: Fingerprint(fingerprintId: 2, creationDate: DateTime(2018, 9, 7)), readDate: DateTime(2022, 10, 21, 8, 3)),
      HistoryRecord(fingerprint: Fingerprint(fingerprintId: 9, creationDate: DateTime(2021, 9, 7)), readDate: DateTime(2022, 3, 4, 7, 23)),
      HistoryRecord(
          fingerprint: Fingerprint(fingerprintId: 3, name: 'André de Souza', creationDate: DateTime(2019, 9, 7)),
          readDate: DateTime(2020, 5, 5, 17, 35)),
      HistoryRecord(fingerprint: Fingerprint(fingerprintId: 4, creationDate: DateTime(2020, 9, 7)), readDate: DateTime(2022, 8, 29, 23, 40)),
      HistoryRecord(fingerprint: Fingerprint(fingerprintId: 5, creationDate: DateTime(2021, 9, 7)), readDate: DateTime(2022, 11, 4, 2, 56)),
      HistoryRecord(
          fingerprint: Fingerprint(fingerprintId: 6, name: 'Franco Tavares', creationDate: DateTime(2021, 9, 7)),
          readDate: DateTime(2022, 11, 20, 11, 33)),
      HistoryRecord(fingerprint: Fingerprint(fingerprintId: 7, creationDate: DateTime(2021, 9, 7)), readDate: DateTime(2022, 11, 20, 15, 15)),
    ]..sort((f1, f2) => f2.readDate.compareTo(f1.readDate));

    _historyRecords.value = groupBy<HistoryRecord, String>(historyRecordsRaw, (record) => record.readDate.formattedDate);

    await Future.delayed(const Duration(milliseconds: 800));
    _isLoading.value = false;
  }

  @override
  Future<void> reloadData() async => await _fetchHistoryRecords();

  @override
  Future<void> onClose() async {
    super.onClose();

    await tabSubscription?.cancel();
  }
}
