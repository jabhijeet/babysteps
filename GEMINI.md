# GEMINI.md: Newborn Routine & Health Tracker
## Project Specification & Implementation Blueprint

### 1. Product Vision
To provide parents with a secure, offline-first utility that simplifies the tracking of complex newborn routines while offering meaningful insights through high-performance data visualization.

---

### 2. Refined Feature Specifications

#### 2.1 Feeding Module (Nutritional Intake)
* **Milk Tracking:**
    * **Breastfeeding:** Dual-timer interface for Left/Right sides with "Pause" functionality. Manual entry fallback for historical data.
    * **Formula:** Volume input with unit toggle (ml/oz). Metadata fields for brand and temperature.
    * **Expressed Milk:** Bottle-based volume input; tracks inventory levels if integrated with a pumping log.
* **Solid Food:** * Cataloging of food types (Purees, Cereals, Finger foods).
    * **Reaction Logger:** Flag for "Allergy," "Dislike," or "Neutral" with photo upload support for rashes/reactions.

#### 2.2 Hygiene & Health Tracking
* **Diaper Changes:** * Quick-toggle: `Wet`, `Dirty`, or `Both`.
    * **Stool Analysis:** Selector for Consistency (Hard, Soft, Watery) and Color (Yellow, Green, Brown, Bloody) to monitor digestive health.
* **Growth Metrics:** * Persistence of Height, Weight, and Head Circumference.
    * Unit conversion (Metric/Imperial) handled at the UI layer.

#### 2.3 Sleep & Activity
* **Sleep Engine:** One-tap start/stop for naps. Automated calculation of "Wake Windows" to help parents predict the next sleep cycle.
* **Developmental Support:** * **Tummy Time:** Duration timer with milestone notes.
    * **Medication/Vaccination:** Scheduled logging for dosages (e.g., Vitamin D, Paracetamol) and a clinic appointment reminder system.

---

### 3. UI/UX Design Principles

* **The "One-Handed" Rule:**
    * Primary "Add" button (Floating Action Button or Bottom Bar) positioned at the bottom-center.
    * Nested radial menus or bottom sheets for category selection (Feed/Sleep/Diaper).
* **Visual Hierarchy:**
    * Soft pastel color coding: *Blue for Sleep, Green for Feeding, Yellow for Diaper.*
    * High-contrast iconography for quick identification.
* **Night Mode (Midnight Feedings):**
    * True-black background (OLED optimized).
    * Filtered red/amber light themes to minimize melatonin disruption for both parent and baby.

---

### 4. Technical Architecture & Security

#### 4.1 Local Secure Storage
* **Persistence Layer:** `drift` (SQLite) for structured routine data; `shared_preferences` for non-sensitive UI settings.
* **Encryption Strategy:** * Utilize `flutter_secure_storage` to manage AES-256 keys.
    * Encrypt PII fields (Name, DOB) and health notes before disk write.
* **Multi-Profile Partitioning:** Data is scoped by `baby_id`. The database schema uses a relational model to allow seamless switching between profiles without data leakage.

#### 4.2 Data Visualization
* **Growth Percentiles:** Plotting user data against WHO/CDC growth curves using `fl_chart`.
* **Trend Analysis:** Interactive bar charts showing "Volume vs. Day" and "Sleep Duration vs. Night."

#### 4.3 Cloud Sync & Collaboration
* **Provider:** Google Drive API via `googleapis` and `google_sign_in`.
* **App Data Folder:** Files are stored in the `appDataFolder` (hidden from the user's main drive) as encrypted JSON or SQLite snapshots.
* **Conflict Resolution:** Last-write-wins strategy based on UTC timestamps for multi-parent synchronization.

---

### 5. Implementation Roadmap (Flutter)

| Phase | Focus | Key Packages |
| :--- | :--- | :--- |
| **Phase 1** | Offline Core & Secure Storage | `drift`, `flutter_secure_storage`, `encrypt` |
| **Phase 2** | One-Handed UI & Timers | `flutter_bloc` (State Management), `intl` |
| **Phase 3** | Charts & Insights | `fl_chart`, `provider` |
| **Phase 4** | Drive Sync & Notifications | `googleapis`, `flutter_local_notifications` |
| **Phase 5** | Agentic AI & Orchestration | `speech_to_text`, `flutter_tts`, `openai`, `ollama`, `langchain` (optional), `vector_store` |
| **Phase 6** | Non-Functional Requirements & Hardening | `workmanager`, `background_fetch`, `sentry`, `firebase_performance` |

---
## 6. Agentic AI & Orchestration (Text/Voice Centric)

### 6.1 Architecture Overview
* **Modular AI Layer:** Separate AI module that interacts with the existing database and UI via a clean API.
* **Offline-First AI:** Support for both cloud-based LLMs (OpenAI, OpenRouter) and local LLMs (Ollama) with configurable providers.
* **Secure Context Isolation:** All AI processing occurs in a sandboxed environment; sensitive data is anonymized before being sent to external models.

### 6.2 Natural Language Interface (NLI)
* **Voice/Text Input:**
    * **Packages:** `speech_to_text` for on-device speech recognition, `flutter_tts` for text-to-speech feedback.
    * **UI:** Dedicated FAB that expands to a voice recording interface with real-time transcription.
* **Intent Parsing Engine:**
    * **LLM Tool-Calling:** Use OpenAI's function calling or Ollama's tool‑calling to map natural language to structured log entries.
    * **Prompt Engineering:** System prompt defines the available log types (feeding, sleep, diaper, etc.) and their fields.
    * **Fallback Mechanism:** If confidence is low, present a confirmation dialog with parsed fields for manual adjustment.
* **Local Processing Pipeline:**
    * Voice‑to‑text runs entirely on‑device (via `speech_to_text`).
    * Intent parsing can be performed locally if Ollama is configured, otherwise uses configured cloud API.
    * All network requests are encrypted and respect user‑defined privacy settings.

### 6.3 Proactive Routine Engine
* **Autonomous Analysis Agent:**
    * **RAG‑lite Retrieval:** Embeddings of recent logs + WHO/CDC guidelines stored in a local vector database (e.g., `vector_store` or SQLite with `sqlite_vss`).
    * **Reasoning Loop:** The agent periodically scans the SQLite database for patterns (e.g., feeding frequency, sleep duration) using predefined heuristics.
* **Agentic Actions:**
    * **Trend Detection:** Monitor key metrics (volume, sleep, diaper counts) over sliding windows; generate alerts when deviations exceed thresholds.
    * **Schedule Adjustment:** Compute optimal wake windows based on historical sleep data; push notifications with suggested nap times.
    * **Pediatric Summary Drafting:** Compile a concise report for healthcare visits, highlighting trends and potential concerns.

### 6.4 Local Knowledge Retrieval (RAG)
* **Curated Knowledge Base:**
    * Bundle a sanitized, offline‑friendly subset of WHO/CDC growth and development guidelines as JSON/vector embeddings.
    * Update mechanism via secure, versioned downloads (optional).
* **Question‑Answering Pipeline:**
    * User queries are embedded and matched against the local vector store.
    * Retrieved context is fed to a small local LLM (Ollama) or a cloud LLM (if permitted) to generate safe, evidence‑based answers.
* **Security & Privacy:**
    * No personal data leaves the device unless the user explicitly opts into cloud‑based AI.
    * All external API calls are anonymized and encrypted.

### 6.5 Implementation Steps (Phase 5)
1. **Add AI configuration screen** in settings for LLM provider, API key, model selection.
2. **Integrate `speech_to_text` and `flutter_tts`** for voice interaction.
3. **Build intent‑parsing service** that connects to configured LLM and returns structured log data.
4. **Create vector storage** for local guidelines and log embeddings.
5. **Implement proactive agent** as a background isolate that runs periodic analysis.
6. **Add “AI‑assisted log” UI** with undo snackbar and confirmation flow.

### 6.6 Key Packages
* `speech_to_text` – on‑device speech recognition.
* `flutter_tts` – text‑to‑speech feedback.
* `openai` / `ollama` – LLM client libraries.
* `vector_store` or `sqlite_vss` – local vector similarity search.
* `flutter_bloc` – state management for AI features.
* `shared_preferences` – storing AI configuration.



### 7. Non-Functional Requirements

#### 7.1 Security by Design
* **Data Encryption:**
    * **Field‑Level Encryption:** PII fields (baby name, date of birth, health notes) are encrypted before being written to SQLite using AES‑256‑CBC via the `encrypt` package.
    * **Database‑Level Encryption:** Optionally use `sqlcipher` for full‑database encryption (requires additional setup).
* **Key Management:**
    * Keys are generated using a cryptographically secure random generator and stored in the platform’s secure storage (`flutter_secure_storage`).
    * Keys are never transmitted over the network; they remain exclusively on the device.
* **Authentication & Authorization:**
    * Google Sign‑In is used only for Drive sync; no authentication is required for local usage.
    * Partner sharing uses Google Drive’s permission system; the app never handles user passwords.
* **Privacy by Default:**
    * No analytics or tracking libraries are included.
    * All AI features can be configured to run entirely on‑device (Ollama) or with user‑approved cloud APIs.

#### 7.2 Offline‑First Architecture
* **Local Database as Source of Truth:** All CRUD operations are performed against the local SQLite database (`drift`).
* **Sync as Background Enhancement:** Cloud sync (Google Drive) is an optional feature that works as a periodic background job.
* **Conflict Resolution:** Last‑write‑wins based on UTC timestamps; conflicts are logged and can be reviewed by the user.
* **Network Resilience:** The app remains fully functional without any network connection; sync failures are queued and retried with exponential backoff.

#### 7.3 Performance
* **Database Optimization:**
    * All frequently queried columns (baby_id, start_time, type) are indexed.
    * Complex queries (e.g., aggregations for charts) are performed in background isolates to avoid UI jank.
* **UI Performance:**
    * Chart rendering (`fl_chart`) uses hardware‑accelerated canvases and is capped at 60 fps.
    * List views employ `ListView.builder` with item‑extent caching and keep‑alive where appropriate.
* **Memory Management:**
    * Large datasets (e.g., years of logs) are paginated; only the visible time window is loaded into memory.
    * Images (reaction photos) are cached and resized before display.

#### 7.4 Reliability & Robustness
* **Background Task Handling:**
    * Timers (feeding, sleep) are managed by a dedicated service that survives app pauses using `workmanager` or `background_fetch`.
    * Timer state is periodically persisted to disk; on app restart, timers are restored with corrected durations.
* **Error Recovery:**
    * Database corruptions trigger an automatic recovery routine (restore from latest Drive backup, if available).
    * Unhandled exceptions are caught by a global error boundary and logged locally; optional crash reporting via `sentry`.
* **Notification Reliability:**
    * Notifications are categorized (reminders, alerts, sync status) and each category has its own channel with user‑configurable importance.
    * Scheduled notifications use `flutter_local_notifications` with exact alarm permission on Android; fallback to inexact scheduling on restrictive platforms.

#### 7.5 Maintainability & Testability
* **Modular Architecture:**
    * Clear separation between data layer (`drift` repositories), business logic (BLoC cubits), and UI (widgets).
    * Dependency injection is performed manually (via constructors) or with `provider` for simplicity.
* **Testing Strategy:**
    * Unit tests for all repositories and business logic (using `mocktail`).
    * Widget tests for critical UI flows (feeding timer, chart interactions).
    * Integration tests for end‑to‑end scenarios (adding a baby, logging a feed, syncing).
* **Code Quality:**
    * Enforced via `flutter_lints` and custom analysis options.
    * Continuous integration runs tests, linting, and format checks on every commit.

#### 7.6 Implementation Steps (Phase 6)
1. **Security Hardening:** Audit encryption implementation; add SQLCipher option; perform penetration‑testing checklist.
2. **Performance Profiling:** Use Dart DevTools to identify and eliminate UI jank; add database indexes where missing.
3. **Background Task Integration:** Integrate `workmanager` for reliable timer persistence and sync scheduling.
4. **Error‑Handling Layer:** Implement global error catcher and crash‑reporting (optional Sentry integration).
5. **Notification Channel Segregation:** Define distinct notification channels for reminders, alerts, and sync events.
6. **Comprehensive Testing:** Increase test coverage to >80%; add integration tests for critical user journeys.
7. **App Store Compliance:** Ensure the app meets Google Play and Apple App Store guidelines for health‑data applications.

#### 7.7 Key Packages
* `encrypt` – AES‑256 encryption.
* `flutter_secure_storage` – secure key storage.
* `workmanager` / `background_fetch` – background task scheduling.
* `sentry` – crash reporting (optional).
* `flutter_local_notifications` – reliable notifications.
* `mocktail` – unit testing.
* `flutter_driver` / `integration_test` – integration testing.
