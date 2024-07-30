// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';


const double _kItemExtent = 32.0;
const bool _kUseMagnifier = true;
// const double _kMagnification = 2.35/2.1;
const double _kMagnification = 1.12;
const double _kDatePickerPadSize = 20.0;
// The density of a date picker is different from a generic picker.
// Eyeballed from iOS.
// const double _kSqueeze = 1.25;
const double _kSqueeze = 0.618;
const double _diameterRatio = 2.6;

const TextStyle _kDefaultPickerTextStyle = TextStyle(
  letterSpacing: -0.83,
);

TextStyle _themeTextStyle(BuildContext context, { bool isValid = true }) {
  final TextStyle style = CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle;
  return isValid
      ? style.copyWith(color: CupertinoDynamicColor.maybeResolve(style.color, context))
      : style.copyWith(color: CupertinoDynamicColor.resolve(CupertinoColors.inactiveGray, context));
}

void _animateColumnControllerToItem(FixedExtentScrollController controller, int targetItem) {
  controller.animateToItem(
    targetItem,
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 200),
  );
}

const Widget _startSelectionOverlay = CupertinoPickerDefaultSelectionOverlay(capEndEdge: false);
const Widget _centerSelectionOverlay = CupertinoPickerDefaultSelectionOverlay(capStartEdge: false, capEndEdge: false);
const Widget _endSelectionOverlay = CupertinoPickerDefaultSelectionOverlay(capStartEdge: false);


class _DatePickerLayoutDelegate extends MultiChildLayoutDelegate {
  _DatePickerLayoutDelegate({
    required this.columnWidths,
    required this.textDirectionFactor,
  }) : assert(columnWidths != null),
        assert(textDirectionFactor != null);

  // The list containing widths of all columns.
  final List<double> columnWidths;

  // textDirectionFactor is 1 if text is written left to right, and -1 if right to left.
  final int textDirectionFactor;

  @override
  void performLayout(Size size) {
    double remainingWidth = size.width;

    for (int i = 0; i < columnWidths.length; i++) {
      remainingWidth -= columnWidths[i] + _kDatePickerPadSize * 2;
    }

    double currentHorizontalOffset = 0.0;

    for (int i = 0; i < columnWidths.length; i++) {
      final int index = textDirectionFactor == 1 ? i : columnWidths.length - i - 1;

      double childWidth = columnWidths[index] + _kDatePickerPadSize * 2;
      if (index == 0 || index == columnWidths.length - 1) {
        childWidth += remainingWidth / 2;
      }

      // We can't actually assert here because it would break things badly for
      // semantics, which will expect that we laid things out here.
      assert(() {
        if (childWidth < 0) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: FlutterError(
                'Insufficient horizontal space to render the '
                    'CupertinoDatePicker because the parent is too narrow at '
                    '${size.width}px.\n'
                    'An additional ${-remainingWidth}px is needed to avoid '
                    'overlapping columns.',
              ),
            ),
          );
        }
        return true;
      }());
      layoutChild(index, BoxConstraints.tight(Size(math.max(0.0, childWidth), size.height)));
      positionChild(index, Offset(currentHorizontalOffset, 0.0));

      currentHorizontalOffset += childWidth;
    }
  }

  @override
  bool shouldRelayout(_DatePickerLayoutDelegate oldDelegate) {
    return columnWidths != oldDelegate.columnWidths
        || textDirectionFactor != oldDelegate.textDirectionFactor;
  }
}

enum _PickerColumnType {
  // Day of month column in date mode.
  dayOfMonth,
  // Month column in date mode.
  month,
  // Year column in date mode.
  year,
  // Medium date column in dateAndTime mode.
  date,
  // Hour column in time and dateAndTime mode.
  hour,
  // minute column in time and dateAndTime mode.
  minute,
  // AM/PM column in time and dateAndTime mode.
  dayPeriod,
}
class CustomCupertinoDatePicker extends StatefulWidget {

  CustomCupertinoDatePicker({
  super.key,
  this.mode = CupertinoDatePickerMode.dateAndTime,
  required this.onDateTimeChanged,
  DateTime? initialDateTime,
  this.minimumDate,
  this.maximumDate,
  this.minimumYear = 1,
  this.maximumYear,
  this.minuteInterval = 1,
  this.use24hFormat = false,
  this.dateOrder,
  this.backgroundColor,
  }) : initialDateTime = initialDateTime ?? DateTime.now(),
  assert(mode != null),
  assert(onDateTimeChanged != null),
  assert(minimumYear != null),
  assert(
  minuteInterval > 0 && 60 % minuteInterval == 0,
  'minute interval is not a positive integer factor of 60',
  ) {
  assert(this.initialDateTime != null);
  assert(
  mode != CupertinoDatePickerMode.dateAndTime || minimumDate == null || !this.initialDateTime.isBefore(minimumDate!),
  'initial date is before minimum date',
  );
  assert(
  mode != CupertinoDatePickerMode.dateAndTime || maximumDate == null || !this.initialDateTime.isAfter(maximumDate!),
  'initial date is after maximum date',
  );
  assert(
  mode != CupertinoDatePickerMode.date || (minimumYear >= 1 && this.initialDateTime.year >= minimumYear),
  'initial year is not greater than minimum year, or minimum year is not positive',
  );
  assert(
  mode != CupertinoDatePickerMode.date || maximumYear == null || this.initialDateTime.year <= maximumYear!,
  'initial year is not smaller than maximum year',
  );
  assert(
  mode != CupertinoDatePickerMode.date || minimumDate == null || !minimumDate!.isAfter(this.initialDateTime),
  'initial date ${this.initialDateTime} is not greater than or equal to minimumDate $minimumDate',
  );
  assert(
  mode != CupertinoDatePickerMode.date || maximumDate == null || !maximumDate!.isBefore(this.initialDateTime),
  'initial date ${this.initialDateTime} is not less than or equal to maximumDate $maximumDate',
  );
  assert(
  this.initialDateTime.minute % minuteInterval == 0,
  'initial minute is not divisible by minute interval',
  );
  }

  final CupertinoDatePickerMode mode;

  final DateTime initialDateTime;

  final DateTime? minimumDate;

  final DateTime? maximumDate;

  final int minimumYear;

  final int? maximumYear;

  final int minuteInterval;

  /// Whether to use 24 hour format. Defaults to false.
  final bool use24hFormat;


  final DatePickerDateOrder? dateOrder;

  final ValueChanged<DateTime> onDateTimeChanged;

  final Color? backgroundColor;

  @override
  State<StatefulWidget> createState() { // ignore: no_logic_in_create_state, https://github.com/flutter/flutter/issues/70499
    // The `time` mode and `dateAndTime` mode of the picker share the time
    // columns, so they are placed together to one state.
    // The `date` mode has different children and is implemented in a different
    // state.
    switch (mode) {
      case CupertinoDatePickerMode.time:
      // case CupertinoDatePickerMode.dateAndTime:
      //   return _CustomCupertinoDatePickerDateTimeState();
      case CupertinoDatePickerMode.date:
        return _CustomCupertinoDatePickerDateState(dateOrder: dateOrder);
      default:
        return _CustomCupertinoDatePickerDateState(dateOrder: dateOrder);
    }
  }

  // Estimate the minimum width that each column needs to layout its content.
  static double _getColumnWidth(
      _PickerColumnType columnType,
      CupertinoLocalizations localizations,
      BuildContext context,
      ) {
    String longestText = '';

    switch (columnType) {
      case _PickerColumnType.date:
      // Measuring the length of all possible date is impossible, so here
      // just some dates are measured.
        for (int i = 1; i <= 12; i++) {
          // An arbitrary date.
          final String date =
          localizations.datePickerMediumDate(DateTime(2018, i, 25));
          if (longestText.length < date.length) {
            longestText = date;
          }
        }
        break;
      case _PickerColumnType.hour:
        for (int i = 0; i < 24; i++) {
          final String hour = localizations.datePickerHour(i);
          if (longestText.length < hour.length) {
            longestText = hour;
          }
        }
        break;
      case _PickerColumnType.minute:
        for (int i = 0; i < 60; i++) {
          final String minute = localizations.datePickerMinute(i);
          if (longestText.length < minute.length) {
            longestText = minute;
          }
        }
        break;
      case _PickerColumnType.dayPeriod:
        longestText =
        localizations.anteMeridiemAbbreviation.length > localizations.postMeridiemAbbreviation.length
            ? localizations.anteMeridiemAbbreviation
            : localizations.postMeridiemAbbreviation;
        break;
      case _PickerColumnType.dayOfMonth:
        for (int i = 1; i <=31; i++) {
          final String dayOfMonth = localizations.datePickerDayOfMonth(i);
          if (longestText.length < dayOfMonth.length) {
            longestText = dayOfMonth;
          }
        }
        break;
      case _PickerColumnType.month:
        for (int i = 1; i <=12; i++) {
          final String month = localizations.datePickerMonth(i);
          if (longestText.length < month.length) {
            longestText = month;
          }
        }
        break;
      case _PickerColumnType.year:
        longestText = localizations.datePickerYear(2018);
        break;
    }

    assert(longestText != '', 'column type is not appropriate');

    return TextPainter.computeMaxIntrinsicWidth(
      text: TextSpan(
        style: _themeTextStyle(context),
        text: longestText,
      ),
      textDirection: Directionality.of(context),
    );
  }
}

typedef _ColumnBuilder = Widget Function(double offAxisFraction, TransitionBuilder itemPositioningBuilder, Widget selectionOverlay);



class _CustomCupertinoDatePickerDateState extends State<CustomCupertinoDatePicker> {

  _CustomCupertinoDatePickerDateState({
    required this.dateOrder,
  });

  final DatePickerDateOrder? dateOrder;

  late int textDirectionFactor;
  late CupertinoLocalizations localizations;

  // Alignment based on text direction. The variable name is self descriptive,
  // however, when text direction is rtl, alignment is reversed.
  late Alignment alignCenterLeft;
  late Alignment alignCenterRight;

  // The currently selected values of the picker.
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  // The controller of the day picker. There are cases where the selected value
  // of the picker is invalid (e.g. February 30th 2018), and this dayController
  // is responsible for jumping to a valid value.
  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  bool isDayPickerScrolling = false;
  bool isMonthPickerScrolling = false;
  bool isYearPickerScrolling = false;

  bool get isScrolling => isDayPickerScrolling || isMonthPickerScrolling || isYearPickerScrolling;

  // Estimated width of columns.
  Map<int, double> estimatedColumnWidths = <int, double>{};

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialDateTime.day;
    selectedMonth = widget.initialDateTime.month;
    selectedYear = widget.initialDateTime.year;

    dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
    monthController = FixedExtentScrollController(initialItem: selectedMonth - 1);
    yearController = FixedExtentScrollController(initialItem: selectedYear);

    PaintingBinding.instance.systemFonts.addListener(_handleSystemFontsChange);
  }

  void _handleSystemFontsChange() {
    setState(() {
      // System fonts change might cause the text layout width to change.
      _refreshEstimatedColumnWidths();
    });
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();

    PaintingBinding.instance.systemFonts.removeListener(_handleSystemFontsChange);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    textDirectionFactor = Directionality.of(context) == TextDirection.ltr ? 1 : -1;
    localizations = CupertinoLocalizations.of(context);

    alignCenterLeft = textDirectionFactor == 1 ? Alignment.centerLeft : Alignment.centerRight;
    alignCenterRight = textDirectionFactor == 1 ? Alignment.centerRight : Alignment.centerLeft;

    _refreshEstimatedColumnWidths();
  }

  void _refreshEstimatedColumnWidths() {
    estimatedColumnWidths[_PickerColumnType.dayOfMonth.index] = CustomCupertinoDatePicker._getColumnWidth(_PickerColumnType.dayOfMonth, localizations, context);
    estimatedColumnWidths[_PickerColumnType.month.index] = CustomCupertinoDatePicker._getColumnWidth(_PickerColumnType.month, localizations, context);
    estimatedColumnWidths[_PickerColumnType.year.index] = CustomCupertinoDatePicker._getColumnWidth(_PickerColumnType.year, localizations, context);
  }

  // The DateTime of the last day of a given month in a given year.
  // Let `DateTime` handle the year/month overflow.
  DateTime _lastDayInMonth(int year, int month) => DateTime(year, month + 1, 0);

  Widget _buildDayPicker(double offAxisFraction, TransitionBuilder itemPositioningBuilder, Widget selectionOverlay) {
    final int daysInCurrentMonth = _lastDayInMonth(selectedYear, selectedMonth).day;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          isDayPickerScrolling = true;
        } else if (notification is ScrollEndNotification) {
          isDayPickerScrolling = false;
          _pickerDidStopScrolling();
        }

        return false;
      },
      child: CupertinoPicker(
        scrollController: dayController,
        offAxisFraction: offAxisFraction,
        itemExtent: _kItemExtent,
        useMagnifier: _kUseMagnifier,
        magnification: _kMagnification,
        diameterRatio: _diameterRatio,
        backgroundColor: widget.backgroundColor,
        squeeze: _kSqueeze,
        onSelectedItemChanged: (int index) {
          selectedDay = index + 1;
          if (_isCurrentDateValid) {
            widget.onDateTimeChanged(DateTime(selectedYear, selectedMonth, selectedDay));
          }
        },
        looping: true,
        selectionOverlay: selectionOverlay,
        children: List<Widget>.generate(31, (int index) {
          final int day = index + 1;
          return itemPositioningBuilder(
            context,
            Text(
              localizations.datePickerDayOfMonth(day),
              textAlign: TextAlign.left,
              style: _themeTextStyle(context, isValid: day <= daysInCurrentMonth),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMonthPicker(double offAxisFraction, TransitionBuilder itemPositioningBuilder, Widget selectionOverlay) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          isMonthPickerScrolling = true;
        } else if (notification is ScrollEndNotification) {
          isMonthPickerScrolling = false;
          _pickerDidStopScrolling();
        }

        return false;
      },
      child: CupertinoPicker(
        scrollController: monthController,
        offAxisFraction: offAxisFraction,
        itemExtent: _kItemExtent,
        useMagnifier: _kUseMagnifier,
        magnification: _kMagnification,
        backgroundColor: widget.backgroundColor,
        squeeze: _kSqueeze,
        diameterRatio: _diameterRatio,
        onSelectedItemChanged: (int index) {
          selectedMonth = index + 1;
          if (_isCurrentDateValid) {
            widget.onDateTimeChanged(DateTime(selectedYear, selectedMonth, selectedDay));
          }
        },
        looping: true,
        selectionOverlay: selectionOverlay,
        children: List<Widget>.generate(12, (int index) {
          final int month = index + 1;
          final bool isInvalidMonth = (widget.minimumDate?.year == selectedYear && widget.minimumDate!.month > month)
              || (widget.maximumDate?.year == selectedYear && widget.maximumDate!.month < month);

          return itemPositioningBuilder(
            context,
            Text(
              localizations.datePickerMonth(month),
              textAlign: TextAlign.left,
              style: _themeTextStyle(context, isValid: !isInvalidMonth),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildYearPicker(double offAxisFraction, TransitionBuilder itemPositioningBuilder, Widget selectionOverlay) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          isYearPickerScrolling = true;
        } else if (notification is ScrollEndNotification) {
          isYearPickerScrolling = false;
          _pickerDidStopScrolling();
        }

        return false;
      },
      child: CupertinoPicker.builder(
        scrollController: yearController,
        itemExtent: _kItemExtent,
        offAxisFraction: offAxisFraction,
        useMagnifier: _kUseMagnifier,
        squeeze: _kSqueeze,
        diameterRatio: _diameterRatio,
        magnification: _kMagnification,
        backgroundColor: widget.backgroundColor,
        onSelectedItemChanged: (int index) {
          selectedYear = index;
          if (_isCurrentDateValid) {
            widget.onDateTimeChanged(DateTime(selectedYear, selectedMonth, selectedDay));
          }
        },
        itemBuilder: (BuildContext context, int year) {
          if (year < widget.minimumYear) {
            return null;
          }

          if (widget.maximumYear != null && year > widget.maximumYear!) {
            return null;
          }

          final bool isValidYear = (widget.minimumDate == null || widget.minimumDate!.year <= year)
              && (widget.maximumDate == null || widget.maximumDate!.year >= year);

          return itemPositioningBuilder(
            context,
            Text(
              localizations.datePickerYear(year),
              textAlign: TextAlign.left,
              style: _themeTextStyle(context, isValid: isValidYear),
            ),
          );
        },
        selectionOverlay: selectionOverlay,
      ),
    );
  }

  bool get _isCurrentDateValid {
    // The current date selection represents a range [minSelectedData, maxSelectDate].
    final DateTime minSelectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
    final DateTime maxSelectedDate = DateTime(selectedYear, selectedMonth, selectedDay + 1);

    final bool minCheck = widget.minimumDate?.isBefore(maxSelectedDate) ?? true;
    final bool maxCheck = widget.maximumDate?.isBefore(minSelectedDate) ?? false;

    return minCheck && !maxCheck && minSelectedDate.day == selectedDay;
  }

  // One or more pickers have just stopped scrolling.
  void _pickerDidStopScrolling() {
    // Call setState to update the greyed out days/months/years, as the currently
    // selected year/month may have changed.
    setState(() { });

    if (isScrolling) {
      return;
    }

    // Whenever scrolling lands on an invalid entry, the picker
    // automatically scrolls to a valid one.
    final DateTime minSelectDate = DateTime(selectedYear, selectedMonth, selectedDay);
    final DateTime maxSelectDate = DateTime(selectedYear, selectedMonth, selectedDay + 1);

    final bool minCheck = widget.minimumDate?.isBefore(maxSelectDate) ?? true;
    final bool maxCheck = widget.maximumDate?.isBefore(minSelectDate) ?? false;

    if (!minCheck || maxCheck) {
      // We have minCheck === !maxCheck.
      final DateTime targetDate = minCheck ? widget.maximumDate! : widget.minimumDate!;
      _scrollToDate(targetDate);
      return;
    }

    // Some months have less days (e.g. February). Go to the last day of that month
    // if the selectedDay exceeds the maximum.
    if (minSelectDate.day != selectedDay) {
      final DateTime lastDay = _lastDayInMonth(selectedYear, selectedMonth);
      _scrollToDate(lastDay);
    }
  }

  void _scrollToDate(DateTime newDate) {
    assert(newDate != null);
    SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
      if (selectedYear != newDate.year) {
        _animateColumnControllerToItem(yearController, newDate.year);
      }

      if (selectedMonth != newDate.month) {
        _animateColumnControllerToItem(monthController, newDate.month - 1);
      }

      if (selectedDay != newDate.day) {
        _animateColumnControllerToItem(dayController, newDate.day - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<_ColumnBuilder> pickerBuilders = <_ColumnBuilder>[];
    List<double> columnWidths = <double>[];

    final DatePickerDateOrder datePickerDateOrder =
        dateOrder ?? localizations.datePickerDateOrder;

    switch (datePickerDateOrder) {
      case DatePickerDateOrder.mdy:
        pickerBuilders = <_ColumnBuilder>[_buildMonthPicker, _buildDayPicker, _buildYearPicker];
        columnWidths = <double>[
          estimatedColumnWidths[_PickerColumnType.month.index]!,
          estimatedColumnWidths[_PickerColumnType.dayOfMonth.index]!,
          estimatedColumnWidths[_PickerColumnType.year.index]!,
        ];
        break;
      case DatePickerDateOrder.dmy:
        pickerBuilders = <_ColumnBuilder>[_buildDayPicker, _buildMonthPicker, _buildYearPicker];
        columnWidths = <double>[
          estimatedColumnWidths[_PickerColumnType.dayOfMonth.index]!,
          estimatedColumnWidths[_PickerColumnType.month.index]!,
          estimatedColumnWidths[_PickerColumnType.year.index]!,
        ];
        break;
      case DatePickerDateOrder.ymd:
        pickerBuilders = <_ColumnBuilder>[_buildYearPicker, _buildMonthPicker, _buildDayPicker];
        columnWidths = <double>[
          estimatedColumnWidths[_PickerColumnType.year.index]!,
          estimatedColumnWidths[_PickerColumnType.month.index]!,
          estimatedColumnWidths[_PickerColumnType.dayOfMonth.index]!,
        ];
        break;
      case DatePickerDateOrder.ydm:
        pickerBuilders = <_ColumnBuilder>[_buildYearPicker, _buildDayPicker, _buildMonthPicker];
        columnWidths = <double>[
          estimatedColumnWidths[_PickerColumnType.year.index]!,
          estimatedColumnWidths[_PickerColumnType.dayOfMonth.index]!,
          estimatedColumnWidths[_PickerColumnType.month.index]!,
        ];
        break;
    }

    final List<Widget> pickers = <Widget>[];

    for (int i = 0; i < columnWidths.length; i++) {
      final double offAxisFraction = (i - 1) * 0.3 * textDirectionFactor;

      EdgeInsets padding = const EdgeInsets.only(left: _kDatePickerPadSize);
      // if (textDirectionFactor == -1) {
      //   padding = const EdgeInsets.only(left: _kDatePickerPadSize);
      // }

      Widget selectionOverlay = _centerSelectionOverlay;
      if (i == 0) {
        selectionOverlay = _startSelectionOverlay;
      } else if (i == columnWidths.length - 1) {
        selectionOverlay = _endSelectionOverlay;
      }

      pickers.add(LayoutId(
        id: i,
        child: pickerBuilders[i](
          offAxisFraction,
              (BuildContext context, Widget? child) {
            return Container(
              alignment: i == columnWidths.length - 1
                  ? alignCenterLeft
                  : alignCenterRight,
              padding: i == 0 ? null : padding,
              child: Container(
                // alignment: i == 0 ? alignCenterLeft : alignCenterRight,
                alignment: Alignment.centerLeft,
                width: columnWidths[i] + _kDatePickerPadSize,
                child: child,
              ),
            );
          },
          selectionOverlay,
        ),
      ));
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: DefaultTextStyle.merge(
        style: _kDefaultPickerTextStyle,
        child: CustomMultiChildLayout(
          delegate: _DatePickerLayoutDelegate(
            columnWidths: columnWidths,
            textDirectionFactor: textDirectionFactor,
          ),
          children: pickers,
        ),
      ),
    );
  }
}

