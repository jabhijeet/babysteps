import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';

class InsightCharts {
  static Widget buildGenericBarChart({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required LinearGradient gradient,
    required List<double> dailyData,
    required int selectedDays,
    List<LinearGradient>? rodGradients,
  }) {
    final now = DateTime.now();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (dailyData.isNotEmpty ? dailyData.reduce((a, b) => a > b ? a : b) : 0) * 1.2 + 1,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final date = now.subtract(Duration(days: (selectedDays - 1) - value.toInt()));
                          String text = '';
                          if (selectedDays <= 7) {
                            text = ['M', 'T', 'W', 'T', 'F', 'S', 'S'][date.weekday - 1];
                          } else {
                            if (value.toInt() % (selectedDays > 15 ? 5 : 3) == 0) {
                              text = '${date.day}/${date.month}';
                            }
                          }
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(text, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 10, fontWeight: FontWeight.bold)),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true, 
                        reservedSize: 40, 
                        getTitlesWidget: (val, meta) => SideTitleWidget(
                          meta: meta,
                          child: Text(val.toInt().toString(), style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyMedium?.color)),
                        ),
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (val) => FlLine(color: Colors.grey.withValues(alpha: 0.1), strokeWidth: 1)),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(selectedDays, (index) {
                    final rodGradient = (rodGradients != null && rodGradients.length > index)
                        ? rodGradients[index]
                        : gradient;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: dailyData[index],
                          gradient: rodGradient,
                          width: selectedDays > 15 ? 6 : (selectedDays > 7 ? 8 : 12),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildGrowthChart({
    required BuildContext context,
    required List<GrowthLog> logs,
    required int selectedDays,
    DateTime? birthDate,
    String? gender,
  }) {
    return _GrowthTrendChart(logs: logs, birthDate: birthDate, selectedDays: selectedDays, gender: gender);
  }
}

class _GrowthTrendChart extends StatefulWidget {
  const _GrowthTrendChart({required this.logs, required this.birthDate, required this.selectedDays, this.gender});

  final List<GrowthLog> logs;
  final DateTime? birthDate;
  final int selectedDays;
  final String? gender;

  @override
  State<_GrowthTrendChart> createState() => _GrowthTrendChartState();
}

class _GrowthTrendChartState extends State<_GrowthTrendChart> {
  int _selectedMetricIndex = 0; // 0: Weight, 1: Height, 2: Head

  double _getWhoValue(int days, List<double> percentileData, double rateAfter24) {
    final months = days / ConversionFactors.daysToMonths;
    if (months <= percentileData.length - 1) {
      return _interpolate(percentileData, months);
    }
    return percentileData.last +
           (months - (percentileData.length - 1)) * rateAfter24;
  }

  double _interpolate(List<double> values, double month) {
    final int m1 = month.floor();
    final int m2 = month.ceil();
    if (m1 >= values.length - 1) return values.last;
    if (m1 == m2) return values[m1];
    return values[m1] + (values[m2] - values[m1]) * (month - m1);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.logs.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 48),
              const Center(child: Text('No growth logs in this period.')),
              const SizedBox(height: 48),
            ],
          ),
        ),
      );
    }

    final birthDate = widget.birthDate;
    if (birthDate == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 48),
              const Center(child: Text('Birth date required for growth charts.')),
              const SizedBox(height: 48),
            ],
          ),
        ),
      );
    }

    final List<GrowthLog> sortedLogs = List<GrowthLog>.from(widget.logs)..sort((a, b) => a.startTime.compareTo(b.startTime));

    final now = DateTime.now();
    final currentAgeDays = now.difference(birthDate).inDays;
    final maxAgeDays = [currentAgeDays, widget.selectedDays].reduce((a, b) => a > b ? a : b);
    final double maxAgeMonths = maxAgeDays / ConversionFactors.daysToMonths;

    final spots = <FlSpot>[];
    
    for (final log in sortedLogs) {
      double? val;
      if (_selectedMetricIndex == 0) val = log.weight;
      if (_selectedMetricIndex == 1) val = log.height;
      if (_selectedMetricIndex == 2) val = log.headCircumference;

      if (val != null) {
        final int ageDays = log.startTime.difference(birthDate).inDays;
        final double ageMonths = ageDays > 0 ? ageDays / ConversionFactors.daysToMonths : 0;
        spots.add(FlSpot(ageMonths, val));
      }
    }

    final whoSpots3 = <FlSpot>[];
    final whoSpots15 = <FlSpot>[];
    final whoSpots50 = <FlSpot>[];
    final whoSpots85 = <FlSpot>[];
    final whoSpots97 = <FlSpot>[];

    List<double> p3, p15, p50, p85, p97;
    double rate;
    final isGirl = widget.gender?.toLowerCase() == 'girl';

    if (_selectedMetricIndex == 0) {
       p3 = isGirl ? WhoGrowthData.girlWeightP3 : WhoGrowthData.boyWeightP3;
       p15 = isGirl ? WhoGrowthData.girlWeightP15 : WhoGrowthData.boyWeightP15;
       p50 = isGirl ? WhoGrowthData.girlWeightP50 : WhoGrowthData.boyWeightP50;
       p85 = isGirl ? WhoGrowthData.girlWeightP85 : WhoGrowthData.boyWeightP85;
       p97 = isGirl ? WhoGrowthData.girlWeightP97 : WhoGrowthData.boyWeightP97;
       rate = WhoGrowthData.weightGrowthRateAfter24Months;
    } else if (_selectedMetricIndex == 1) {
       p3 = isGirl ? WhoGrowthData.girlHeightP3 : WhoGrowthData.boyHeightP3;
       p15 = isGirl ? WhoGrowthData.girlHeightP15 : WhoGrowthData.boyHeightP15;
       p50 = isGirl ? WhoGrowthData.girlHeightP50 : WhoGrowthData.boyHeightP50;
       p85 = isGirl ? WhoGrowthData.girlHeightP85 : WhoGrowthData.boyHeightP85;
       p97 = isGirl ? WhoGrowthData.girlHeightP97 : WhoGrowthData.boyHeightP97;
       rate = WhoGrowthData.heightGrowthRateAfter24Months;
    } else {
       p3 = isGirl ? WhoGrowthData.girlHeadP3 : WhoGrowthData.boyHeadP3;
       p15 = isGirl ? WhoGrowthData.girlHeadP15 : WhoGrowthData.boyHeadP15;
       p50 = isGirl ? WhoGrowthData.girlHeadP50 : WhoGrowthData.boyHeadP50;
       p85 = isGirl ? WhoGrowthData.girlHeadP85 : WhoGrowthData.boyHeadP85;
       p97 = isGirl ? WhoGrowthData.girlHeadP97 : WhoGrowthData.boyHeadP97;
       rate = WhoGrowthData.headCircumferenceGrowthRateAfter24Months;
    }

    // Generate WHO spots for continuous curve from 0 to maxAgeMonths + 2
    final double endMonth = maxAgeMonths + 2.0;
    // Use a step that ensures smooth curves but is efficient
    final double step = endMonth > 24 ? 1.0 : 0.5;
    
    for (double m = 0; m <= endMonth; m += step) {
        final int days = (m * ConversionFactors.daysToMonths).toInt();
        whoSpots3.add(FlSpot(m, _getWhoValue(days, p3, rate)));
        whoSpots15.add(FlSpot(m, _getWhoValue(days, p15, rate)));
        whoSpots50.add(FlSpot(m, _getWhoValue(days, p50, rate)));
        whoSpots85.add(FlSpot(m, _getWhoValue(days, p85, rate)));
        whoSpots97.add(FlSpot(m, _getWhoValue(days, p97, rate)));
    }

    // Create WHO bands using LineChartBarData with areas
    final baseWhoColor = isGirl ? Colors.pink : Colors.blue;

    LineChartBarData buildWhoLine(List<FlSpot> spots, double alpha, {bool dashed = false}) {
      return LineChartBarData(
        spots: spots,
        isCurved: true,
        color: baseWhoColor.withValues(alpha: alpha),
        barWidth: 1.5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        dashArray: dashed ? [4, 4] : null,
      );
    }

    double interval = 1;
    if (endMonth > 20) {
      interval = 6; // Every half year
    } else if (endMonth > 12) {
      interval = 3; // Every quarter
    } else if (endMonth > 6) {
      interval = 2; // Every two months
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                      if (barData.barWidth != 3) {
                        return spotIndexes.map((_) => null).toList();
                      }
                      return spotIndexes.map((index) {
                        return TouchedSpotIndicatorData(
                          FlLine(color: barData.color ?? Colors.blue, strokeWidth: 2),
                          FlDotData(
                            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                              radius: 4,
                              color: barData.color ?? Colors.blue,
                              strokeWidth: 2,
                              strokeColor: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => Theme.of(context).colorScheme.surface,
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((LineBarSpot touchedSpot) {
                          if (touchedSpot.bar.barWidth == 3) {
                            return LineTooltipItem(
                              touchedSpot.y.toStringAsFixed(1),
                              TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black, fontWeight: FontWeight.bold),
                            );
                          }
                          return null;
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    if (whoSpots97.isNotEmpty) buildWhoLine(whoSpots97, 0.3),
                    if (whoSpots85.isNotEmpty) buildWhoLine(whoSpots85, 0.4),
                    if (whoSpots50.isNotEmpty) buildWhoLine(whoSpots50, 0.6, dashed: true),
                    if (whoSpots15.isNotEmpty) buildWhoLine(whoSpots15, 0.4),
                    if (whoSpots3.isNotEmpty) buildWhoLine(whoSpots3, 0.3),
                    if (spots.isNotEmpty)
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
                        barWidth: 3,
                        dotData: const FlDotData(show: true),
                      ),
                  ],
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        interval: interval,
                        getTitlesWidget: (value, meta) {
                          if (value < 0 || value > endMonth) return const SizedBox.shrink();
                          if (value % 1 != 0) return const SizedBox.shrink();
                          
                          return SideTitleWidget(
                            meta: meta,
                            space: 4,
                            child: Text('${value.toInt()}m', style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyMedium?.color)),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true, 
                        reservedSize: 40, 
                        getTitlesWidget: (val, meta) => SideTitleWidget(
                          meta: meta,
                          child: Text(val.toStringAsFixed(1), style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyMedium?.color)),
                        ),
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (val) => FlLine(color: Colors.grey.withValues(alpha: 0.1), strokeWidth: 1)),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (whoSpots50.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 12, height: 2, color: baseWhoColor.withValues(alpha: 0.6)),
                  const SizedBox(width: 4),
                  Text('WHO Percentiles (3rd-97th)', style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyMedium?.color)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.trending_up, color: AppColors.growthTeal),
            const SizedBox(width: 8),
            Text('Growth Trend', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
          ],
        ),
        DropdownButton<int>(
          value: _selectedMetricIndex,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.growthTeal),
          items: const [
            DropdownMenuItem(value: 0, child: Text('Weight')),
            DropdownMenuItem(value: 1, child: Text('Height')),
            DropdownMenuItem(value: 2, child: Text('Head')),
          ],
          onChanged: (val) {
            if (val != null) setState(() => _selectedMetricIndex = val);
          },
        ),
      ],
    );
  }
}
