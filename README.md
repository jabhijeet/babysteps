# BabySteps 🍼

**Privacy-First Newborn Routine & Health Tracker**

BabySteps is a secure, offline-first application designed to simplify tracking newborn routines while providing meaningful insights through high-performance data visualization. Built with privacy at its core, it ensures that your baby's most sensitive data stays under your control.

---

## ✨ Key Features

### 🍼 Feeding Module
*   **Breastfeeding**: Dual-timer interface for Left/Right sides with pause functionality.
*   **Formula & Expressed Milk**: Volume tracking (ml/oz) with brand and temperature metadata.
*   **Solid Food**: Catalog food types and track allergic reactions or preferences.

### 💤 Sleep & Activity
*   **Sleep Engine**: One-tap nap tracking with automated "Wake Window" calculations.
*   **Developmental Support**: Tummy time timers and milestone logging.
*   **Medical Log**: Track vaccinations, medication dosages, and clinic appointments.

### 🧷 Hygiene & Growth
*   **Diaper Changes**: Detailed tracking for wet/dirty diapers with stool consistency and color analysis.
*   **Growth Metrics**: Monitor Weight, Height, and Head Circumference.
*   **WHO Percentiles**: Visualize growth against official WHO/CDC curves with interactive charts.

### 🎙️ Agentic AI & Voice (Beta)
*   **Voice Logging**: Log feedings, diapers, and sleep using natural language voice commands.
*   **On-Device Processing**: Utilizes Whisper for secure, local speech-to-text.
*   **Proactive Insights**: AI-driven analysis of feeding patterns and sleep cycles.

---

## 🔒 Privacy & Security

*   **Local-First Architecture**: Your data is stored directly on your device, not on our servers.
*   **AES-256 Encryption**: All personal health data and notes are encrypted at rest.
*   **Secure Key Storage**: Encryption keys are managed by the platform's secure enclave (iOS Keychain / Android Keystore).
*   **Private Cloud Sync**: Optional backup via your own Google Drive account using a restricted app-data folder.
*   **Zero Third-Party Tracking**: No analytics, no ads, no telemetry.

---

## 🛠️ Technology Stack

*   **Framework**: [Flutter](https://flutter.dev)
*   **Database**: [Drift (SQLite)](https://drift.simonbinder.eu/)
*   **State Management**: [Flutter BLoC](https://bloclibrary.dev/)
*   **Encryption**: [Encrypt](https://pub.dev/packages/encrypt) & [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
*   **AI/ML**: Whisper (on-device), Speech-to-Text, Flutter TTS

---

## 🚀 Getting Started

1.  **Prerequisites**: Ensure you have [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
2.  **Setup**:
    ```bash
    flutter pub get
    dart run build_runner build  # Generate database code
    flutter run
    ```

---

## 📄 License & Privacy

*   [Privacy Policy](PRIVACY_POLICY.md)
*   [Terms of Service](TERMS_OF_SERVICE.md)

---
*BabySteps - Growing together, one step at a time.*
