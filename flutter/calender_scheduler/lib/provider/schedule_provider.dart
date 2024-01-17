import 'package:calender_scheduler/repository/schedule_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/schedule_model.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository repository; //API 요청 로직을 담은 클래스

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  Map<DateTime, List<ScheduleModel>> cache = {};

  ScheduleProvider({
    required this.repository,
  }) : super() {
    getSchedules(date: selectedDate);
  }

  void getSchedules({
    required DateTime date,
  }) async {
    final resp = await repository.getSchedules(date: date);

    cache.update(date, (value) => resp, ifAbsent: () => resp);
    notifyListeners();
  }

  void createSchedule({
    required ScheduleModel schedule,
  }) async {
    final targetDate = schedule.date;
    final uuid = Uuid();

    final tempId = uuid.v4();
    final newSchedule = schedule.copyWith(
      id: tempId,
    );

    //긍정적 응답구간이다. 서버에서 응답받기 전에 캐시를 먼저 업데이트 합니다.
    cache.update(
      targetDate,
      (value) => [...value, newSchedule]..sort(
          (a, b) => a.startTime.compareTo(
            b.startTime,
          ),
        ),
      ifAbsent: () => [schedule],
    );
    notifyListeners(); //캐시 업데이트 반영하기

    try {
      //API 요청
      final savedSchedule = await repository.createSchedule(schedule: schedule);

      cache.update(
        // 서버 응답 기반으로 캐시 업데이트
        targetDate,
        (value) => value
            .map((e) => e.id == tempId
                ? e.copyWith(
                    id: savedSchedule,
                  )
                : e)
            .toList(),
      );
    } catch (e) {
      cache.update(
        //삭제 실패 시 캐시 롤백하기
        targetDate,
        (value) => value.where((e) => e.id != tempId).toList(),
      );
    }
    notifyListeners();
  }

  void deleteSchedule({
    required DateTime date,
    required String id,
  }) async {
    final targetSchedule = cache[date]!.firstWhere(
      (e) => e.id == id,
    ); // 삭제할 일정 기억

    cache.update(
      date,
      (value) => value.where((e) => e.id != id).toList(),
      ifAbsent: () => [],
    ); //긍정적 응답 (응답 전에 캐시 먼저 업데이트)
    notifyListeners();

    try {
      await repository.deleteSchedule(id: id);
    } catch (e) {
      cache.update(
        date,
        (value) => [...value, targetSchedule]..sort(
            (a, b) => a.startTime.compareTo(
              b.startTime,
            ),
          ),
      );
      notifyListeners();
    }
  }

  void changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = date;
    notifyListeners();
  }
}
