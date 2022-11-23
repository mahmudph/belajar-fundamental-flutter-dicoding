/*
 * Created by mahmud on Wed Nov 23 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:mahmud_flutter_restauran/utils/utils.dart';

void main() {
  group('test unit test', () {
    test(
      'Should have valid delay duration to be able run at hour 11 in a day',
      () {
        var currentDateTime = DateTime.parse("2022-11-23 01:00:00.299871");
        var delayTimeExecution = getFrequenltyPeriodictSchedule(
          currentDateTime,
        );
        var delayTimeDuration = delayTimeExecution.difference(currentDateTime);
        expect(delayTimeDuration.inMinutes, 599);
        expect(delayTimeDuration.inDays, 0);
      },
    );
    test(
      'Scheduler should run tommorow when current date time is gratter than 11 am',
      () {
        var currentDateTime = DateTime.parse("2022-11-23 12:00:00.299871");
        var delayTimeExecution = getFrequenltyPeriodictSchedule(
          currentDateTime,
        );
        var delayTimeDuration = delayTimeExecution.difference(currentDateTime);
        expect(delayTimeDuration.inMinutes, 1379);
        expect(delayTimeExecution.day, greaterThan(currentDateTime.day));
      },
    );
  });
}
