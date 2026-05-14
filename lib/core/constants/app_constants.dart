// App constants for magic numbers and strings
// This file centralizes all hardcoded values for maintainability.

// UI Constants - Padding, spacing, border radius
class UIConstants {
  // Padding values
  static const double paddingSmall = 4.0;
  static const double paddingMedium = 8.0;
  static const double paddingLarge = 12.0;
  static const double paddingXLarge = 16.0;
  static const double paddingXXLarge = 20.0;
  static const double paddingXXXLarge = 24.0;
  static const double paddingHuge = 32.0;
  static const double paddingMassive = 48.0;

  // Spacing values
  static const double spacingTiny = 2.0;
  static const double spacingSmall = 4.0;
  static const double spacingMedium = 8.0;
  static const double spacingLarge = 12.0;
  static const double spacingXLarge = 16.0;
  static const double spacingXXLarge = 20.0;
  static const double spacingXXXLarge = 24.0;
  static const double spacingHuge = 32.0;
  static const double spacingMassive = 48.0;

  // Border radius
  static const double borderRadiusSmall = 2.0;
  static const double borderRadiusMedium = 6.0;
  static const double borderRadiusLarge = 12.0;
  static const double borderRadiusXLarge = 16.0;
  static const double borderRadiusXXLarge = 20.0;
  static const double borderRadiusXXXLarge = 32.0;

  // Container dimensions
  static const double containerWidthSmall = 40.0;
  static const double containerHeightSmall = 4.0;
  static const double avatarRadius = 32.0;
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 20.0;
  static const double iconSizeLarge = 28.0;
  static const double iconSizeXLarge = 32.0;
  static const double iconSizeMassive = 64.0;

  // Chart dimensions
  static const double chartHeight = 200.0;
  static const double chartBarWidthSmall = 6.0;
  static const double chartBarWidthMedium = 8.0;
  static const double chartBarWidthLarge = 12.0;
  static const double chartSideTitleReservedSize = 40.0;
}

// Conversion factors for unit conversions
class ConversionFactors {
  // Weight conversions
  static const double poundsToKilograms = 0.453592;
  static const double kilogramsToPounds = 2.20462;

  // Length conversions
  static const double inchesToCentimeters = 2.54;
  static const double centimetersToInches = 0.393701;

  // Volume conversions (fluid ounces to milliliters)
  static const double ouncesToMilliliters = 29.5735;
  static const double millilitersToOunces = 0.033814;

  // Time conversions
  static const double daysToMonths = 30.44;
  static const double monthsToDays = 30.44;
}

class WhoGrowthData {
  static const List<double> boyWeightP3 = [2.5, 3.4, 4.2, 4.8, 5.2, 5.6, 5.9, 6.2, 6.4, 6.7, 6.9, 7.1, 7.2, 7.4, 7.6, 7.7, 7.9, 8.0, 8.2, 8.3, 8.5, 8.6, 8.9, 9.0, 9.1];
  static const List<double> boyWeightP15 = [2.8, 3.8, 4.8, 5.4, 6.0, 6.4, 6.7, 7.1, 7.3, 7.6, 7.8, 8.0, 8.2, 8.4, 8.6, 8.8, 8.9, 9.1, 9.3, 9.4, 9.6, 9.8, 10.0, 10.2, 10.4];
  static const List<double> boyWeightP50 = [3.3, 4.5, 5.6, 6.4, 7.0, 7.5, 7.9, 8.3, 8.6, 8.9, 9.2, 9.4, 9.6, 9.9, 10.1, 10.3, 10.5, 10.7, 10.9, 11.1, 11.3, 11.5, 11.8, 12.0, 12.2];
  static const List<double> boyWeightP85 = [3.8, 5.2, 6.4, 7.4, 8.0, 8.6, 9.1, 9.5, 9.9, 10.2, 10.6, 10.8, 11.0, 11.4, 11.6, 11.8, 12.1, 12.3, 12.5, 12.8, 13.0, 13.2, 13.6, 13.8, 14.0];
  static const List<double> boyWeightP97 = [4.1, 5.6, 7.0, 8.0, 8.8, 9.4, 9.9, 10.4, 10.8, 11.1, 11.5, 11.8, 12.0, 12.4, 12.6, 12.9, 13.1, 13.4, 13.6, 13.9, 14.1, 14.4, 14.8, 15.0, 15.2];
  
  static const List<double> girlWeightP3 = [2.4, 3.2, 4.0, 4.6, 5.0, 5.3, 5.6, 5.9, 6.1, 6.3, 6.6, 6.7, 6.8, 7.1, 7.2, 7.3, 7.5, 7.6, 7.8, 7.9, 8.1, 8.2, 8.4, 8.5, 8.7];
  static const List<double> girlWeightP15 = [2.7, 3.6, 4.5, 5.2, 5.7, 6.1, 6.4, 6.7, 6.9, 7.2, 7.4, 7.6, 7.8, 8.0, 8.2, 8.3, 8.5, 8.6, 8.8, 9.0, 9.1, 9.3, 9.5, 9.7, 9.9];
  static const List<double> girlWeightP50 = [3.1, 4.3, 5.3, 6.1, 6.6, 7.1, 7.5, 7.9, 8.2, 8.5, 8.7, 8.9, 9.1, 9.4, 9.6, 9.8, 10.0, 10.2, 10.4, 10.5, 10.7, 10.9, 11.2, 11.4, 11.6];
  static const List<double> girlWeightP85 = [3.6, 4.9, 6.1, 7.0, 7.6, 8.2, 8.6, 9.1, 9.4, 9.7, 10.1, 10.3, 10.5, 10.8, 11.0, 11.3, 11.5, 11.7, 11.9, 12.1, 12.3, 12.6, 12.9, 13.1, 13.3];
  static const List<double> girlWeightP97 = [3.9, 5.3, 6.6, 7.6, 8.3, 8.9, 9.4, 9.9, 10.2, 10.6, 10.9, 11.2, 11.4, 11.8, 12.0, 12.2, 12.5, 12.7, 12.9, 13.2, 13.4, 13.7, 14.0, 14.2, 14.5];
  
  static const List<double> boyHeightP3 = [46.5, 50.7, 54.4, 57.4, 59.9, 61.9, 63.6, 65.2, 66.6, 68.0, 69.3, 70.5, 71.7, 72.9, 74.0, 75.1, 76.2, 77.2, 78.3, 79.2, 80.2, 81.1, 82.0, 82.9, 83.8];
  static const List<double> boyHeightP15 = [48.5, 52.7, 56.4, 59.4, 61.9, 63.9, 65.6, 67.2, 68.6, 70.0, 71.3, 72.5, 73.7, 74.9, 76.0, 77.1, 78.2, 79.2, 80.3, 81.2, 82.2, 83.1, 84.0, 84.9, 85.8];
  static const List<double> boyHeightP50 = [50.5, 54.7, 58.4, 61.4, 63.9, 65.9, 67.6, 69.2, 70.6, 72.0, 73.3, 74.5, 75.7, 76.9, 78.0, 79.1, 80.2, 81.2, 82.3, 83.2, 84.2, 85.1, 86.0, 86.9, 87.8];
  static const List<double> boyHeightP85 = [52.5, 56.7, 60.4, 63.4, 65.9, 67.9, 69.6, 71.2, 72.6, 74.0, 75.3, 76.5, 77.7, 78.9, 80.0, 81.1, 82.2, 83.2, 84.3, 85.2, 86.2, 87.1, 88.0, 88.9, 89.8];
  static const List<double> boyHeightP97 = [54.5, 58.7, 62.4, 65.4, 67.9, 69.9, 71.6, 73.2, 74.6, 76.0, 77.3, 78.5, 79.7, 80.9, 82.0, 83.1, 84.2, 85.2, 86.3, 87.2, 88.2, 89.1, 90.0, 90.9, 91.8];
  
  static const List<double> girlHeightP3 = [45.5, 49.6, 53.2, 56.2, 58.6, 60.6, 62.2, 63.8, 65.2, 66.6, 67.8, 69.0, 70.2, 71.4, 72.4, 73.5, 74.6, 75.6, 76.7, 77.5, 78.5, 79.4, 80.3, 81.2, 82.0];
  static const List<double> girlHeightP15 = [47.5, 51.6, 55.2, 58.2, 60.6, 62.6, 64.2, 65.8, 67.2, 68.6, 69.8, 71.0, 72.2, 73.4, 74.4, 75.5, 76.6, 77.6, 78.7, 79.5, 80.5, 81.4, 82.3, 83.2, 84.0];
  static const List<double> girlHeightP50 = [49.5, 53.6, 57.2, 60.2, 62.6, 64.6, 66.2, 67.8, 69.2, 70.6, 71.8, 73.0, 74.2, 75.4, 76.4, 77.5, 78.6, 79.6, 80.7, 81.5, 82.5, 83.4, 84.3, 85.2, 86.0];
  static const List<double> girlHeightP85 = [51.5, 55.6, 59.2, 62.2, 64.6, 66.6, 68.2, 69.8, 71.2, 72.6, 73.8, 75.0, 76.2, 77.4, 78.4, 79.5, 80.6, 81.6, 82.7, 83.5, 84.5, 85.4, 86.3, 87.2, 88.0];
  static const List<double> girlHeightP97 = [53.5, 57.6, 61.2, 64.2, 66.6, 68.6, 70.2, 71.8, 73.2, 74.6, 75.8, 77.0, 78.2, 79.4, 80.4, 81.5, 82.6, 83.6, 84.7, 85.5, 86.5, 87.4, 88.3, 89.2, 90.0];
  
  static const List<double> boyHeadP3 = [32.5, 35.3, 37.1, 38.5, 39.5, 40.4, 41.2, 41.8, 42.3, 42.8, 43.3, 43.7, 44.1, 44.4, 44.7, 45.0, 45.2, 45.5, 45.7, 45.9, 46.1, 46.3, 46.5, 46.7, 46.9];
  static const List<double> boyHeadP15 = [33.5, 36.3, 38.1, 39.5, 40.5, 41.4, 42.2, 42.8, 43.3, 43.8, 44.3, 44.7, 45.1, 45.4, 45.7, 46.0, 46.2, 46.5, 46.7, 46.9, 47.1, 47.3, 47.5, 47.7, 47.9];
  static const List<double> boyHeadP50 = [34.5, 37.3, 39.1, 40.5, 41.5, 42.4, 43.2, 43.8, 44.3, 44.8, 45.3, 45.7, 46.1, 46.4, 46.7, 47.0, 47.2, 47.5, 47.7, 47.9, 48.1, 48.3, 48.5, 48.7, 48.9];
  static const List<double> boyHeadP85 = [35.5, 38.3, 40.1, 41.5, 42.5, 43.4, 44.2, 44.8, 45.3, 45.8, 46.3, 46.7, 47.1, 47.4, 47.7, 48.0, 48.2, 48.5, 48.7, 48.9, 49.1, 49.3, 49.5, 49.7, 49.9];
  static const List<double> boyHeadP97 = [36.5, 39.3, 41.1, 42.5, 43.5, 44.4, 45.2, 45.8, 46.3, 46.8, 47.3, 47.7, 48.1, 48.4, 48.7, 49.0, 49.2, 49.5, 49.7, 49.9, 50.1, 50.3, 50.5, 50.7, 50.9];
  
  static const List<double> girlHeadP3 = [31.8, 34.6, 36.3, 37.7, 38.7, 39.6, 40.3, 40.9, 41.4, 41.9, 42.4, 42.8, 43.2, 43.5, 43.8, 44.1, 44.3, 44.5, 44.7, 44.9, 45.1, 45.3, 45.5, 45.7, 45.9];
  static const List<double> girlHeadP15 = [32.8, 35.6, 37.3, 38.7, 39.7, 40.6, 41.3, 41.9, 42.4, 42.9, 43.4, 43.8, 44.2, 44.5, 44.8, 45.1, 45.3, 45.5, 45.7, 45.9, 46.1, 46.3, 46.5, 46.7, 46.9];
  static const List<double> girlHeadP50 = [33.8, 36.6, 38.3, 39.7, 40.7, 41.6, 42.3, 42.9, 43.4, 43.9, 44.4, 44.8, 45.2, 45.5, 45.8, 46.1, 46.3, 46.5, 46.7, 46.9, 47.1, 47.3, 47.5, 47.7, 47.9];
  static const List<double> girlHeadP85 = [34.8, 37.6, 39.3, 40.7, 41.7, 42.6, 43.3, 43.9, 44.4, 44.9, 45.4, 45.8, 46.2, 46.5, 46.8, 47.1, 47.3, 47.5, 47.7, 47.9, 48.1, 48.3, 48.5, 48.7, 48.9];
  static const List<double> girlHeadP97 = [35.8, 38.6, 40.3, 41.7, 42.7, 43.6, 44.3, 44.9, 45.4, 45.9, 46.4, 46.8, 47.2, 47.5, 47.8, 48.1, 48.3, 48.5, 48.7, 48.9, 49.1, 49.3, 49.5, 49.7, 49.9];

  // Monthly growth rates after 24 months
  static const double weightGrowthRateAfter24Months = 0.2; // kg per month
  static const double heightGrowthRateAfter24Months = 0.8; // cm per month
  static const double headCircumferenceGrowthRateAfter24Months = 0.1; // cm per month
}

/// String literals for dropdowns, labels, and UI text
class StringLiterals {
  // Unit strings
  static const String unitKilograms = 'kg';
  static const String unitPounds = 'lbs';
  static const String unitCentimeters = 'cm';
  static const String unitInches = 'in';
  static const String unitMilliliters = 'ml';
  static const String unitOunces = 'oz';

  // Feeding types
  static const String feedTypeBreast = 'Breast';
  static const String feedTypeFormula = 'Formula';
  static const String feedTypeExpressed = 'Expressed';
  static const String feedTypePumping = 'Pumping';
  static const String feedTypeSolid = 'Solid';

  // Diaper types
  static const String diaperTypeWet = 'Wet';
  static const String diaperTypeDirty = 'Dirty';
  static const String diaperTypeBoth = 'Both';

  // Medical types
  static const String medicalTypeMedication = 'Medication';
  static const String medicalTypeVaccination = 'Vaccination';

  // Activity types
  static const String activityTypeTummyTime = 'Tummy Time';
  static const String activityTypePlay = 'Play';
  static const String activityTypeBath = 'Bath';
  static const String activityTypeOther = 'Other';

  // Whisper model sizes
  static const String whisperModelTiny = 'tiny';
  static const String whisperModelBase = 'base';
  static const String whisperModelSmall = 'small';
  static const String whisperModelMedium = 'medium';

  // LLM providers
  static const String llmProviderOpenRouter = 'openrouter';
  static const String llmProviderGemini = 'gemini';
  static const String llmProviderOllama = 'ollama';

  // Diaper consistency options
  static const List<String> diaperConsistencyOptions = [
    'Soft',
    'Firm',
    'Watery',
    'Pasty',
    'Seedy',
  ];

  // Diaper color options
  static const List<String> diaperColorOptions = [
    'Yellow',
    'Green',
    'Brown',
    'Black',
    'Red',
  ];

  // Baby reaction options
  static const List<String> babyReactionOptions = [
    'Loved it!',
    'Ate some',
    'Refused',
    'Gagged',
    'Allergic',
  ];
}

/// Validation limits for user input
class ValidationLimits {
  // Weight limits (kg)
  static const double maxWeightKg = 50.0;
  static const double maxWeightLbs = 110.0;

  // Height limits (cm)
  static const double maxHeightCm = 200.0;
  static const double maxHeightIn = 78.0;

  // Head circumference limits (cm)
  static const double maxHeadCircumferenceCm = 60.0;
  static const double maxHeadCircumferenceIn = 24.0;

  // Minimum positive values
  static const double minPositiveValue = 0.0;
}

/// Duration constants for time periods
class DurationConstants {
  // Common durations
  static const int daysOne = 1;
  static const int daysThree = 3;
  static const int daysSeven = 7;
  static const int daysFifteen = 15;
  static const int daysThirty = 30;
  static const int daysThreeHundredSixtyFive = 365;

  // Time durations in minutes
  static const int minutesFifteen = 15;
  static const int minutesThirty = 30;
  static const int minutesSixty = 60;

  // Chart period options
  static const List<int> chartPeriodOptions = [3, 7, 15, 30];

  // Growth chart period options (in days)
  static const List<int> growthChartPeriodOptions = [91, 182, 365, 547, 730];
}

/// Other magic numbers used throughout the app
class MagicNumbers {
  // ID generation multipliers
  static const int notificationIdMultiplier = 1000;
  static const int notificationSleepCategory = 1;
  static const int notificationFeedingCategory = 2;
  static const int notificationMedicalCategory = 2;

  // Default values
  static const double defaultTemperature = 37.0;
  static const int defaultWakeWindowMinutes = 90;

  // Chart calculations
  static const int chartLabelIntervalSmall = 3;
  static const int chartLabelIntervalLarge = 5;

  // WHO calculation constants
  static const int whoMonthsInYear = 12;
}
