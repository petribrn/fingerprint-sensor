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

    final historyRecordsFetched = await historyRecordRepository.fetchAllHistoryRecords() ?? [];

    // Sorting by latest read date
    final historyRecordsRaw = historyRecordsFetched..sort((f1, f2) => f2.readDate.compareTo(f1.readDate));

    // Grouping by read date
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
