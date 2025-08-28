package com.opencbs.core.helpers;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;

public class DateHelperTest {

    @Test
    public void testDaysBetweenAs_30_360() {
        LocalDate start = LocalDate.of(2019,01,28);
        LocalDate end = LocalDate.of(2019,04,01);
        Long daysBetweenAs30360 = DateHelper.daysBetweenAs_30_360(start, end);
        Assertions.assertEquals(63L, daysBetweenAs30360.longValue());
    }

    @Test
    public void testDaysBetweenAs_30_360_2() {
        LocalDate start = LocalDate.of(2019,4,1);
        LocalDate end = LocalDate.of(2019,7,24);
        Long daysBetweenAs30360 = DateHelper.daysBetweenAs_30_360(start, end);
        Assertions.assertEquals(113L, daysBetweenAs30360.longValue());
    }
}