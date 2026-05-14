import 'package:flutter/material.dart';

class AppColors {
  // --- Core Design System ---
  
  // Premium Pastel Tones (HSL Tailored)
  static const Color sleepBlue = Color(0xFFD4E4FF);
  static const Color feedingGreen = Color(0xFFE2F3E5);
  static const Color breastPink = Color(0xFFFCE4EC);
  static const Color formulaBlue = Color(0xFFE3F2FD);
  static const Color expressedGold = Color(0xFFFFF8E1);
  static const Color pumpingPurple = Color(0xFFF3E5F5);
  static const Color solidOrange = Color(0xFFFFF3E0);
  static const Color diaperYellow = Color(0xFFFFF9DB);
  static const Color activityOrange = Color(0xFFFFF3E0);
  static const Color medicalRed = Color(0xFFFFEBEE);
  static const Color growthTeal = Color(0xFFE0F2F1);
  
  // Diaper Sub-types
  static const Color wetBlue = Color(0xFFE1F5FE);
  static const Color dirtyBrown = Color(0xFFEFEBE9);
  static const Color bothMixed = Color(0xFFF3E5F5);

  // Activity Sub-types
  static const Color tummyTimeGreen = Color(0xFFE8F5E9);
  static const Color playYellow = Color(0xFFFFFDE7);
  static const Color bathCyan = Color(0xFFE0F7FA);
  static const Color otherGrey = Color(0xFFF5F5F5);

  // Medical Sub-types
  static const Color medicationRed = Color(0xFFFFEBEE);
  static const Color vaccinationPurple = Color(0xFFF3E5F5);

  // Vibrant Accents (for interaction)
  static const Color accentBlue = Color(0xFF4A90E2);
  static const Color accentGreen = Color(0xFF66BB6A);
  static const Color accentBreast = Color(0xFFF06292);
  static const Color accentFormula = Color(0xFF64B5F6);
  static const Color accentExpressed = Color(0xFFFFD54F);
  static const Color accentPumping = Color(0xFFBA68C8);
  static const Color accentSolid = Color(0xFFFF8A65);
  static const Color accentYellow = Color(0xFFFFD54F);
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentRed = Color(0xFFEF5350);
  static const Color accentTeal = Color(0xFF26A69A);
  
  // Diaper Accents
  static const Color accentWet = Color(0xFF29B6F6);
  static const Color accentDirty = Color(0xFF8D6E63);
  static const Color accentBoth = Color(0xFFAB47BC);

  // Activity Accents
  static const Color accentTummyTime = Color(0xFF66BB6A);
  static const Color accentPlay = Color(0xFFFFD54F);
  static const Color accentBath = Color(0xFF26C6DA);
  static const Color accentOther = Color(0xFF9E9E9E);

  // Medical Accents
  static const Color accentMedication = Color(0xFFEF5350);
  static const Color accentVaccination = Color(0xFF9C27B0);

  static const Color accentPrimary = Color(0xFF4A90E2);

  // Surface & Backgrounds (Light Mode)
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textLightPrimary = Color(0xFF2C3E50);
  static const Color textLightSecondary = Color(0xFF7F8C8D);

  // Surface & Backgrounds (Dark Mode / Custom Deep Blue)
  static const Color backgroundDark = Color(0xFF2C3947);
  static const Color surfaceDark = Color(0xFF364554);
  static const Color textDarkPrimary = Color(0xFFECEFF1);
  static const Color textDarkSecondary = Color(0xFFB0BEC5);

  // Midnight Feed / Melatonin Friendly
  static const Color primaryNight = Color(0xFFFF5252); // Red-filtered for night
  static const Color amberNight = Color(0xFFFFB74D);

  // --- Gradients ---
  static const LinearGradient sleepGradient = LinearGradient(
    colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient feedingGradient = LinearGradient(
    colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient breastGradient = LinearGradient(
    colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient formulaGradient = LinearGradient(
    colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient expressedGradient = LinearGradient(
    colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pumpingGradient = LinearGradient(
    colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient solidGradient = LinearGradient(
    colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Diaper Gradients
  static const LinearGradient wetGradient = LinearGradient(
    colors: [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient dirtyGradient = LinearGradient(
    colors: [Color(0xFFEFEBE9), Color(0xFFD7CCC8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient bothDiaperGradient = LinearGradient(
    colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Activity Gradients
  static const LinearGradient tummyTimeGradient = LinearGradient(
    colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient playGradient = LinearGradient(
    colors: [Color(0xFFFFFDE7), Color(0xFFFFF9C4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient bathGradient = LinearGradient(
    colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient otherActivityGradient = LinearGradient(
    colors: [Color(0xFFF5F5F5), Color(0xFFEEEEEE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Medical Gradients
  static const LinearGradient medicationGradient = LinearGradient(
    colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient vaccinationGradient = LinearGradient(
    colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient backgroundGradientDark = LinearGradient(
    colors: [Color(0xFF2C3947), Color(0xFF1B242D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient diaperGradient = LinearGradient(
    colors: [Color(0xFFFFF9DB), Color(0xFFFFF176)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient activityGradient = LinearGradient(
    colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient medicalGradient = LinearGradient(
    colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient growthGradient = LinearGradient(
    colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Color getFeedingColor(String type) {
    switch (type.toLowerCase()) {
      case 'breast': return breastPink;
      case 'formula': return formulaBlue;
      case 'expressed': return expressedGold;
      case 'pumping': return pumpingPurple;
      case 'solid': return solidOrange;
      default: return feedingGreen;
    }
  }

  static Color getFeedingAccentColor(String type) {
    switch (type.toLowerCase()) {
      case 'breast': return accentBreast;
      case 'formula': return accentFormula;
      case 'expressed': return accentExpressed;
      case 'pumping': return accentPumping;
      case 'solid': return accentSolid;
      default: return accentGreen;
    }
  }

  static LinearGradient getFeedingGradient(String type) {
    switch (type.toLowerCase()) {
      case 'breast': return breastGradient;
      case 'formula': return formulaGradient;
      case 'expressed': return expressedGradient;
      case 'pumping': return pumpingGradient;
      case 'solid': return solidGradient;
      default: return feedingGradient;
    }
  }

  // --- Diaper Helpers ---
  static Color getDiaperColor(String type) {
    switch (type.toLowerCase()) {
      case 'wet': return wetBlue;
      case 'dirty': return dirtyBrown;
      case 'both': return bothMixed;
      default: return diaperYellow;
    }
  }

  static Color getDiaperAccentColor(String type) {
    switch (type.toLowerCase()) {
      case 'wet': return accentWet;
      case 'dirty': return accentDirty;
      case 'both': return accentBoth;
      default: return accentYellow;
    }
  }

  static LinearGradient getDiaperGradient(String type) {
    switch (type.toLowerCase()) {
      case 'wet': return wetGradient;
      case 'dirty': return dirtyGradient;
      case 'both': return bothDiaperGradient;
      default: return diaperGradient;
    }
  }

  // --- Activity Helpers ---
  static Color getActivityColor(String type) {
    switch (type.toLowerCase()) {
      case 'tummy time': return tummyTimeGreen;
      case 'play': return playYellow;
      case 'bath': return bathCyan;
      default: return otherGrey;
    }
  }

  static Color getActivityAccentColor(String type) {
    switch (type.toLowerCase()) {
      case 'tummy time': return accentTummyTime;
      case 'play': return accentPlay;
      case 'bath': return accentBath;
      default: return accentOther;
    }
  }

  static LinearGradient getActivityGradient(String type) {
    switch (type.toLowerCase()) {
      case 'tummy time': return tummyTimeGradient;
      case 'play': return playGradient;
      case 'bath': return bathGradient;
      default: return otherActivityGradient;
    }
  }

  // --- Medical Helpers ---
  static Color getMedicalColor(String type) {
    switch (type.toLowerCase()) {
      case 'medication': return medicationRed;
      case 'vaccination': return vaccinationPurple;
      default: return medicalRed;
    }
  }

  static Color getMedicalAccentColor(String type) {
    switch (type.toLowerCase()) {
      case 'medication': return accentMedication;
      case 'vaccination': return accentVaccination;
      default: return accentRed;
    }
  }

  static LinearGradient getMedicalGradient(String type) {
    switch (type.toLowerCase()) {
      case 'medication': return medicationGradient;
      case 'vaccination': return vaccinationGradient;
      default: return medicalGradient;
    }
  }
}
