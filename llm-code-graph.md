# CODE_GRAPH
MISSION: COMPACT PROJECT MAP FOR LLM AGENTS.
PROTOCOL: Follow llm-agent-rules.md
MEMORY: See llm-agent-project-learnings.md

> Legend: * core, (↑out ↓in deps), s: symbols, d: desc

- *lib/app.dart (12↑ 0↓) | d: Contains 2 symbols.
  - s: [@override build [(BuildContext context)], BabyStepsApp [extends StatelessWidget]]
- *lib/main.dart (4↑ 0↓) | d: Initialize Secure Storage
  - s: []
- *linux/runner/main.cc (1↑ 0↓) | d: include "my_application.h"
  - s: []
- *windows/runner/main.cpp (5↑ 0↓) | d: include <flutter/dart_project.h> include <flutter/flutter_view_controller.h> inc
  - s: []
- lib/core/theme/colors.dart (1↑ 10↓) | d: --- Core Design System ---
  - s: [AppColors]
- lib/features/logging/bloc/logging_bloc.dart (5↑ 6↓) | d: --- Events ---
  - s: [@overrid List [<Object?> get props => []], LoggingBloc [--- Bloc ---], LoggingEvent [--- Events ---], LoggingFailure [extends LoggingState], LoggingInitial [extends LoggingState], LoggingLoading [extends LoggingState], LoggingState [--- States ---], LoggingSuccess [extends LoggingState], SaveActivityLogEvent [extends LoggingEvent], SaveDiaperLogEvent [extends LoggingEvent], SaveFeedLogEvent [extends LoggingEvent], SaveGrowthLogEvent [extends LoggingEvent], SaveMedicalLogEvent [extends LoggingEvent], SaveSleepLogEvent [extends LoggingEvent]]
- lib/core/database/app_database.dart (2↑ 4↓) | d: Contains 11 symbols.
  - s: [@DataClassName() Table, @DriftDatabase(tables: [Babies, FeedingLogs, SleepLogs, DiaperLogs, GrowthLogs, ActivityLogs, MedicalLogs]) _ [$AppDatabase], @override schemaVersion [=> 1], ActivityLogs [extends Table], AppDatabase [extends _$AppDatabase], Babies [extends Table], DiaperLogs [extends Table], FeedingLogs [extends Table], GrowthLogs [extends Table], MedicalLogs [extends Table], SleepLogs [extends Table]]
- lib/core/database/repositories/log_repositories.dart (3↑ 3↓) | d: Contains 6 symbols.
  - s: [ActivityLogRepository, DiaperLogRepository, FeedingLogRepository, GrowthLogRepository, MedicalLogRepository, SleepLogRepository]
- lib/core/security/secure_storage.dart (3↑ 2↓) | d: Generate or retrieve encryption key
  - s: [SecureStorage]
- lib/core/database/repositories/baby_repository.dart (3↑ 1↓) | d: Contains 2 symbols.
  - s: [BabyModel, BabyRepository]
- lib/core/network/notification_service.dart (3↑ 1↓) | d: Contains 1 symbols.
  - s: [NotificationService]
- lib/core/network/sync_service.dart (4↑ 1↓) | d: import 'dart:io'; // Removed to avoid web breakage
  - s: [SyncService]
- lib/core/theme/theme_cubit.dart (2↑ 1↓) | d: Contains 2 symbols.
  - s: [ThemeCubit [extends Cubit<ThemeMode>], toggleTheme [()]]
- lib/features/insights/presentation/insights_screen.dart (6↑ 1↓) | d: Contains 2 symbols.
  - s: [@override build [(BuildContext context)], InsightsScreen [extends StatelessWidget]]
- lib/features/logging/presentation/activity_logging_sheet.dart (6↑ 1↓) | d: Contains 8 symbols.
  - s: [@override build [(BuildContext context)], @override createState [()], @override dispose [()], @override initState [()], ActivityLoggingSheet [extends StatefulWidget], _ActivityLoggingSheetState [extends State<ActivityLoggingSheet>], dispose [()], initState [()]]
- lib/features/logging/presentation/diaper_logging_sheet.dart (4↑ 1↓) | d: Contains 4 symbols.
  - s: [@override build [(BuildContext context)], @override createState [()], DiaperLoggingSheet [extends StatefulWidget], _DiaperLoggingSheetState [extends State<DiaperLoggingSheet>]]
- lib/features/logging/presentation/feed_logging_sheet.dart (8↑ 1↓) | d: Contains 8 symbols.
  - s: [@override build [(BuildContext context)], @override createState [()], @override dispose [()], @override initState [()], FeedLoggingSheet [extends StatefulWidget], _FeedLoggingSheetState [extends State<FeedLoggingSheet>], dispose [()], initState [()]]
- lib/features/logging/presentation/growth_logging_sheet.dart (5↑ 1↓) | d: Contains 8 symbols.
  - s: [@override build [(BuildContext context)], @override createState [()], @override dispose [()], @override initState [()], GrowthLoggingSheet [extends StatefulWidget], _GrowthLoggingSheetState [extends State<GrowthLoggingSheet>], dispose [()], initState [()]]
- lib/features/logging/presentation/medical_logging_sheet.dart (4↑ 1↓) | d: Contains 6 symbols.
  - s: [@override build [(BuildContext context)], @override createState [()], @override dispose [()], MedicalLoggingSheet [extends StatefulWidget], _MedicalLoggingSheetState [extends State<MedicalLoggingSheet>], dispose [()]]
- lib/features/logging/presentation/sleep_logging_sheet.dart (5↑ 1↓) | d: Contains 6 symbols.
  - s: [@override build [(BuildContext context)], @override createState [()], @override initState [()], SleepLoggingSheet [extends StatefulWidget], _SleepLoggingSheetState [extends State<SleepLoggingSheet>], initState [()]]
- .agent/.shared/ui-ux-pro-max/scripts/core.py (5↑ 0↓) | d: -*- coding: utf-8 -*-
  - s: [using [BM25"""], with [auto-domain detection"""]]
- .agent/.shared/ui-ux-pro-max/scripts/design_system.py (7↑ 0↓) | d: -*- coding: utf-8 -*-
  - s: [DesignSystemGenerator [============ DESIGN SYSTEM GENERATOR ============], __init__ [Generates design system recommendations from aggregated searches."""], _apply_reasoning [(self, category: str, search_results: dict)], _extract_results [(self, search_result: dict)], _find_reasoning_rule [(self, category: str)], _generate_intelligent_overrides [(page_name: str, page_query: str, design_system: dict)], _load_reasoning [(self)], _multi_domain_search [(self, query: str, style_priority: list = None)], _select_best_match [(self, results: list, priority_keywords: list)], and [generate intelligent overrides], format_ascii_box [(design_system: dict)], format_markdown [(design_system: dict)], format_master_md [(design_system: dict)], format_page_override_md [(design_system: dict, page_name: str, page_query: str = None)], from [search results or context], generate [(self, query: str, project_name: str = None)], generate_design_system [============ MAIN ENTRY POINT ============], persist_design_system [============ PERSISTENCE FUNCTIONS ============], wrap_text [(text: str, prefix: str, width: int)]]
- .agent/.shared/ui-ux-pro-max/scripts/search.py (2↑ 0↓) | d: -*- coding: utf-8 -*-
  - s: [format_output [(result)]]
- .agent/scripts/auto_preview.py (1↑ 0↓) | d: Contains 5 symbols.
  - s: [get_project_root [()], get_start_command [(root)], is_running [(pid)], main [()], start_server [(port=3000)]]
- .agent/scripts/checklist.py (2↑ 0↓) | d: Contains 10 symbols.
  - s: [Colors [ANSI colors for terminal output], check_script_exists [(script_path: Path)], main [()], print_error [(text: str)], print_header [(text: str)], print_step [(text: str)], print_success [(text: str)], print_summary [(results: List[dict])], print_warning [(text: str)], run_script [(name: str, script_path: Path, project_path: str, url: Optional[str] = None)]]
- .agent/scripts/session_manager.py (2↑ 0↓) | d: Contains 6 symbols.
  - s: [analyze_package_json [(root: Path)], count_files [(root: Path)], detect_features [(root: Path)], get_project_root [(path: str)], main [()], print_status [(root: Path)]]
- .agent/scripts/verify_all.py (3↑ 0↓) | d: Contains 9 symbols.
  - s: [Colors [ANSI colors], main [()], print_error [(text: str)], print_final_report [(results: List[dict], start_time: datetime)], print_header [(text: str)], print_step [(text: str)], print_success [(text: str)], print_warning [(text: str)], run_script [(name: str, script_path: Path, project_path: str, url: Optional[str] = None)]]
- .agent/skills/api-patterns/scripts/api_validator.py (1↑ 0↓) | d: Fix Windows console encoding for Unicode output
  - s: [check_api_code [(file_path: Path)], check_openapi_spec [(file_path: Path)], find_api_files [(project_path: Path)], in [['get', 'post', 'put', 'patch', 'delete']:], main [()]]
- .agent/skills/database-design/scripts/schema_validator.py (2↑ 0↓) | d: Contains 6 symbols.
  - s: [@index foreign_keys [Check for @@index suggestions], @relation relations [- Index recommendations], definitions [enums = re.findall(r'enum\s+(\w+)\s*], find_schema_files [(project_path: Path)], main [()], validate_prisma_schema [(file_path: Path)]]
- .agent/skills/frontend-design/scripts/accessibility_checker.py (2↑ 0↓) | d: Contains 3 symbols.
  - s: [check_accessibility [(file_path: Path)], find_html_files [(project_path: Path)], main [()]]
- .agent/skills/frontend-design/scripts/ux_audit.py (3↑ 0↓) | d: 
  - s: []
- .agent/skills/geo-fundamentals/scripts/geo_checker.py (1↑ 0↓) | d: Contains 5 symbols.
  - s: [@type content [)], check_page [(file_path: Path)], in [AI-generated answers], is_page_file [(file_path: Path)], main [()]]
- .agent/skills/i18n-localization/scripts/i18n_checker.py (1↑ 0↓) | d: Fix Windows console encoding for Unicode output
  - s: [check_hardcoded_strings [(project_path: Path)], check_locale_completeness [(locale_files: list)], find_locale_files [(project_path: Path)], flatten_keys [(d, prefix='')], in [locales.get(base_lang,], main [()]]
- .agent/skills/lint-and-validate/scripts/lint_runner.py (2↑ 0↓) | d: Contains 5 symbols.
  - s: [detect_project_type [(project_path: Path)], main [()], on [project type.], project_info [Detect project type], run_linter [(linter: dict, cwd: Path)]]
- .agent/skills/lint-and-validate/scripts/type_coverage.py (1↑ 0↓) | d: Fix Windows console encoding for Unicode output
  - s: [check_python_coverage [(project_path: Path)], check_typescript_coverage [(project_path: Path)], hints [coverage."""], main [()], name [Find functions without return types], untyped [Find functions without return types function name(params) { - no return type]]
- .agent/skills/mobile-design/scripts/mobile_audit.py (6↑ 0↓) | d: Contains 7 symbols.
  - s: [MobileAuditor [:], __init__ [(self)], audit_directory [(self, directory: str)], audit_file [(self, filepath: str)], get_report [(self)], main [()], scale [. Consider iOS text styles for native feel.")]]
- .agent/skills/nextjs-react-expert/scripts/convert_rules.py (2↑ 0↓) | d: Section metadata from _sections.md
  - s: [generate_section_file [(section_prefix: str, rules: List[Dict], output_dir: Path)], group_rules_by_section [(rules_dir: Path)], main [()], parse_frontmatter [(content: str)], parse_rule_file [(filepath: Path)]]
- .agent/skills/nextjs-react-expert/scripts/react_performance_checker.py (4↑ 0↓) | d: Contains 5 symbols.
  - s: [PerformanceChecker [:], __init__ [(self, project_path: str)], check_barrel_imports [(self)], check_dynamic_imports [(self)], check_waterfalls [(self)]]
- .agent/skills/performance-profiling/scripts/lighthouse_audit.py (0↑ 0↓) | d: Contains 2 symbols.
  - s: [get_summary [(categories: dict)], run_lighthouse [(url: str)]]
- .agent/skills/seo-fundamentals/scripts/seo_checker.py (2↑ 0↓) | d: Contains 2 symbols.
  - s: [find_pages [(project_path: Path)], is_page_file [(file_path: Path)]]
- .agent/skills/testing-patterns/scripts/test_runner.py (2↑ 0↓) | d: Contains 3 symbols.
  - s: [detect_test_framework [(project_path: Path)], main [()], run_tests [(cmd: list, cwd: Path)]]
- .agent/skills/vulnerability-scanner/scripts/security_scan.py (3↑ 0↓) | d: 
  - s: []
- .agent/skills/webapp-testing/scripts/playwright_runner.py (2↑ 0↓) | d: Contains 2 symbols.
  - s: [run_accessibility_check [(url: str)], run_basic_test [(url: str, take_screenshot: bool = False)]]
- android/app/src/main/kotlin/io/github/jabhijeet/MainActivity.kt (0↑ 0↓) | d: Contains 1 symbols.
  - s: [MainActivity [: FlutterActivity()]]
- ios/Flutter/ephemeral/flutter_lldb_helper.py (0↑ 0↓) | d: Generated file, do not edit.
  - s: [__lldb_init_module [(debugger: lldb.SBDebugger, _)], does [Caveat: must use BreakpointCreateByRegEx here and not], handle_new_rx_page [(frame: lldb.SBFrame, bp_loc, extra_args, intern_dict)]]
- ios/Runner/AppDelegate.swift (0↑ 0↓) | d: Contains 4 symbols.
  - s: [@objc AppDelegate [: FlutterAppDelegate, FlutterImplicitEngineDelegate], AppDelegate [: FlutterAppDelegate, FlutterImplicitEngineDelegate], application [(], didInitializeImplicitFlutterEngine [(_ engineBridge: FlutterImplicitEngineBridge)]]
- ios/Runner/GeneratedPluginRegistrant.h (0↑ 0↓) | d: Generated file. Do not edit.
  - s: [@en NS_ASSUME_NONNULL_END [#endif /* GeneratedPluginRegistrant_h */], @interfac GeneratedPluginRegistrant [: NSObject], GeneratedPluginRegistrant [: NSObject]]
- ios/Runner/GeneratedPluginRegistrant.m (1↑ 0↓) | d: Generated file. Do not edit.
  - s: [@implementatio GeneratedPluginRegistrant [Generated file. Do not edit. clang-format off], @impor flutter_local_notifications [Generated file. Do not edit. clang-format off import "GeneratedPluginRegistrant.h"], @impor flutter_secure_storage_darwin [if __has_include(<flutter_local_notifications/FlutterLocalNotificationsPlugin.h>) import <flutter_local_notifications/FlutterLocalNotificationsPlugin.h> else endif], @impor google_sign_in_ios [if __has_include(<flutter_secure_storage_darwin/FlutterSecureStorageDarwinPlugin.h>) import <flutter_secure_storage_darwin/FlutterSecureStorageDarwinPlugin.h> else endif], @impor image_picker_ios [if __has_include(<google_sign_in_ios/FLTGoogleSignInPlugin.h>) import <google_sign_in_ios/FLTGoogleSignInPlugin.h> else endif], @impor shared_preferences_foundation [if __has_include(<image_picker_ios/FLTImagePickerPlugin.h>) import <image_picker_ios/FLTImagePickerPlugin.h> else endif]]
- ios/Runner/Runner-Bridging-Header.h (1↑ 0↓) | d: import "GeneratedPluginRegistrant.h"
  - s: []
- ios/Runner/SceneDelegate.swift (0↑ 0↓) | d: Contains 1 symbols.
  - s: [SceneDelegate [: FlutterSceneDelegate]]
- ios/RunnerTests/RunnerTests.swift (0↑ 0↓) | d: If you add code to the Runner application, consider adding tests here. See https
  - s: [RunnerTests [: XCTestCase], testExample [()]]
- lib/core/database/app_database.g.dart (0↑ 0↓) | d: GENERATED CODE - DO NOT MODIFY BY HAND
  - s: [@overrid Iterable [<TableInfo<Table, Object?>> get allTables =>], @overrid Map [<String, dynamic> data,], @override actualTableName [=> $name], @override aliasedName [=> _alias ?? actualTableName], @override allSchemaEntities [=> [], @override attachedDatabase, @override babyId [= GeneratedColumn<int>(], @override breastSide [= GeneratedColumn<String>(], @override color [= GeneratedColumn<String>(], @override consistency [= GeneratedColumn<String>(], @override date [= GeneratedColumn<DateTime>(], @override dosage [= GeneratedColumn<String>(], @override encryptedDateOfBirth [=], @override encryptedGender [= GeneratedColumn<String>(], @override encryptedName [= GeneratedColumn<String>(], @override endTime [= GeneratedColumn<DateTime>(], @override formulaBrand [= GeneratedColumn<String>(], @override formulaTemp [= GeneratedColumn<double>(], @override get [$columns => [], @override hashCode [=>], @override headCircumference [=], @override height [= GeneratedColumn<double>(], @override id [= GeneratedColumn<int>(], @override leftDurationSeconds [= GeneratedColumn<int>(], @override map [= <String, Expression>], @override milestones [= GeneratedColumn<String>(], @override name [= GeneratedColumn<String>(], @override notes [= GeneratedColumn<String>(], @override operator [==(Object other) =>], @override reminderTime [= GeneratedColumn<DateTime>(], @override rightDurationSeconds [= GeneratedColumn<int>(], @override solidFoodReaction [=], @override solidFoodReactionPhotoPath [=], @override startTime [= GeneratedColumn<DateTime>(], @override time [= GeneratedColumn<DateTime>(], @override toString [()], @override type [= GeneratedColumn<String>(], @override validateIntegrity [(], @override volumeAmount [= GeneratedColumn<double>(], @override volumeUnit [= GeneratedColumn<String>(], @override weight [= GeneratedColumn<double>(], ActivityLog [extends DataClass implements Insertable<ActivityLog>], ActivityLogsCompanion [extends UpdateCompanion<ActivityLog>], BabiesCompanion [extends UpdateCompanion<Baby>], Baby [extends DataClass implements Insertable<Baby>], DiaperLog [extends DataClass implements Insertable<DiaperLog>], DiaperLogsCompanion [extends UpdateCompanion<DiaperLog>], FeedingLog [extends DataClass implements Insertable<FeedingLog>], FeedingLogsCompanion [extends UpdateCompanion<FeedingLog>], GrowthLog [extends DataClass implements Insertable<GrowthLog>], GrowthLogsCompanion [extends UpdateCompanion<GrowthLog>], MedicalLog [extends DataClass implements Insertable<MedicalLog>], MedicalLogsCompanion [extends UpdateCompanion<MedicalLog>], SleepLog [extends DataClass implements Insertable<SleepLog>], SleepLogsCompanion [extends UpdateCompanion<SleepLog>], _ [$AppDatabase extends GeneratedDatabase], custom [(]]
- lib/core/database/connection/connection.dart (2↑ 0↓) | d: 
  - s: []
- lib/core/database/connection/native.dart (2↑ 0↓) | d: 
  - s: []
- lib/core/database/connection/web.dart (2↑ 0↓) | d: 
  - s: []
- lib/core/theme/app_theme.dart (2↑ 0↓) | d: Contains 1 symbols.
  - s: [AppTheme]
- lib/features/home/presentation/home_screen.dart (13↑ 0↓) | d: Contains 5 symbols.
  - s: [@override build [(BuildContext context)], @override createState [()], HomeScreen [extends StatefulWidget], _HomeScreenState [extends State<HomeScreen>], _showAddLogBottomSheet [()]]
- lib/features/home/presentation/widgets/dashboard_view.dart (8↑ 0↓) | d: Contains 2 symbols.
  - s: [@override build [(BuildContext context)], DashboardView [extends StatelessWidget]]
- lib/features/home/presentation/widgets/settings_drawer.dart (4↑ 0↓) | d: Contains 6 symbols.
  - s: [@override build [(BuildContext context)], @override createState [()], @override dispose [()], SettingsDrawer [extends StatefulWidget], _SettingsDrawerState [extends State<SettingsDrawer>], dispose [()]]
- lib/features/home/presentation/widgets/timeline_event.dart (1↑ 0↓) | d: Contains 2 symbols.
  - s: [TimelineEvent, TimelineEventType]
- linux/flutter/generated_plugin_registrant.cc (3↑ 0↓) | d: Generated file. Do not edit.
  - s: [fl_register_plugins [include <file_selector_linux/file_selector_plugin.h> include <flutter_secure_storage_linux/flutter_secure_storage_linux_plugin.h>]]
- linux/flutter/generated_plugin_registrant.h (1↑ 0↓) | d: Generated file. Do not edit.
  - s: [fl_register_plugins [define GENERATED_PLUGIN_REGISTRANT_ include <flutter_linux/flutter_linux.h> Registers Flutter plugins.]]
- linux/runner/my_application.cc (4↑ 0↓) | d: include "my_application.h"
  - s: [_MyApplication [include <flutter_linux/flutter_linux.h> ifdef GDK_WINDOWING_X11 include <gdk/gdkx.h> endif include "flutter/generated_plugin_registrant.h"], first_frame_cb [Called when first Flutter frame received.], my_application_activate [Implements GApplication::activate.], my_application_class_init [(MyApplicationClass* klass)], my_application_dispose [Implements GObject::dispose.], my_application_init [(MyApplication* self)], my_application_local_command_line [Implements GApplication::local_command_line.], my_application_shutdown [Implements GApplication::shutdown.], my_application_startup [Implements GApplication::startup.]]
- linux/runner/my_application.h (1↑ 0↓) | d: ifndef FLUTTER_MY_APPLICATION_H_ define FLUTTER_MY_APPLICATION_H_
  - s: []
- macos/Flutter/GeneratedPluginRegistrant.swift (0↑ 0↓) | d: Generated file. Do not edit.
  - s: [RegisterGeneratedPlugins [(registry: FlutterPluginRegistry)]]
- macos/Runner/AppDelegate.swift (0↑ 0↓) | d: Contains 4 symbols.
  - s: [@main AppDelegate [: FlutterAppDelegate], AppDelegate [: FlutterAppDelegate], applicationShouldTerminateAfterLastWindowClosed [(_ sender: NSApplication)], applicationSupportsSecureRestorableState [(_ app: NSApplication)]]
- macos/Runner/MainFlutterWindow.swift (0↑ 0↓) | d: Contains 2 symbols.
  - s: [MainFlutterWindow [: NSWindow], awakeFromNib [()]]
- macos/RunnerTests/RunnerTests.swift (0↑ 0↓) | d: If you add code to the Runner application, consider adding tests here. See https
  - s: [RunnerTests [: XCTestCase], testExample [()]]
- test/core/network/notification_service_test.dart (6↑ 0↓) | d: Contains 2 symbols.
  - s: [MockFlutterLocalNotificationsPlugin [extends Mock implements FlutterLocalNotificationsPlugin], main [()]]
- test/core/network/sync_service_test.dart (4↑ 0↓) | d: Contains 3 symbols.
  - s: [MockGoogleSignIn [extends Mock implements GoogleSignIn], MockGoogleSignInAccount [extends Mock implements GoogleSignInAccount], main [()]]
- test/widget_test.dart (1↑ 0↓) | d: Contains 1 symbols.
  - s: [main [()]]
- windows/flutter/generated_plugin_registrant.cc (3↑ 0↓) | d: Generated file. Do not edit.
  - s: [RegisterPlugins [include <file_selector_windows/file_selector_windows.h> include <flutter_secure_storage_windows/flutter_secure_storage_windows_plugin.h>]]
- windows/flutter/generated_plugin_registrant.h (1↑ 0↓) | d: Generated file. Do not edit.
  - s: [RegisterPlugins [ifndef GENERATED_PLUGIN_REGISTRANT_ define GENERATED_PLUGIN_REGISTRANT_ include <flutter/plugin_registry.h> Registers Flutter plugins.]]
- windows/runner/flutter_window.cpp (3↑ 0↓) | d: include "flutter_window.h"
  - s: []
- windows/runner/flutter_window.h (4↑ 0↓) | d: ifndef RUNNER_FLUTTER_WINDOW_H_ define RUNNER_FLUTTER_WINDOW_H_
  - s: [FlutterWindow [include <flutter/flutter_view_controller.h> include <memory> include "win32_window.h" A window that does nothing but host a Flutter view.]]
- windows/runner/resource.h (0↑ 0↓) | d: {{NO_DEPENDENCIES}} Microsoft Visual C++ generated include file. Used by Runner.
  - s: []
- windows/runner/utils.cpp (6↑ 0↓) | d: include "utils.h"
  - s: [CreateAndAttachConsole [include "utils.h" include <flutter_windows.h> include <io.h> include <stdio.h> include <windows.h> include <iostream>]]
- windows/runner/utils.h (2↑ 0↓) | d: ifndef RUNNER_UTILS_H_ define RUNNER_UTILS_H_
  - s: [CreateAndAttachConsole [Creates a console for the process, and redirects stdout and stderr to it for both the runner and the Flutter library.]]
- windows/runner/win32_window.cpp (5↑ 0↓) | d: include "win32_window.h"
  - s: [EnableFullDpiSupportIfAvailable [Dynamically loads the |EnableNonClientDpiScaling| from the User32 module. This API is only needed for PerMonitor V1 awareness mode.], UnregisterWindowClass [Unregisters the window class. Should only be called if there are no instances of the window.], WindowClassRegistrar [Manages the Win32Window's window class registration.]]
- windows/runner/win32_window.h (4↑ 0↓) | d: ifndef RUNNER_WIN32_WINDOW_H_ define RUNNER_WIN32_WINDOW_H_
  - s: [Destroy [Release OS resources associated with window.], OnDestroy [Called when Destroy is called.], Point, SetChildContent [Inserts |content| into the window tree.], SetQuitOnClose [If true, closing this window will quit the application.], Size, UpdateTheme [Update the window frame's theme to match the system theme.], Win32Window [A class abstraction for a high DPI-aware Win32 Window. Intended to be inherited from by classes that wish to specialize with custom rendering and input handling], WindowClassRegistrar]

## EDGES
[.agent/.shared/ui-ux-pro-max/scripts/core.py] -> [, , BM25, collections, math, pathlib]
[.agent/.shared/ui-ux-pro-max/scripts/design_system.py] -> [Master, core, datetime, design_system, layered, pathlib, priority]
[.agent/.shared/ui-ux-pro-max/scripts/search.py] -> [core, design_system]
[.agent/scripts/auto_preview.py] -> [pathlib]
[.agent/scripts/checklist.py] -> [pathlib, typing]
[.agent/scripts/session_manager.py] -> [pathlib, typing]
[.agent/scripts/verify_all.py] -> [datetime, pathlib, typing]
[.agent/skills/api-patterns/scripts/api_validator.py] -> [pathlib]
[.agent/skills/database-design/scripts/schema_validator.py] -> [datetime, pathlib]
[.agent/skills/frontend-design/scripts/accessibility_checker.py] -> [datetime, pathlib]
[.agent/skills/frontend-design/scripts/ux_audit.py] -> [HSL, expensive, pathlib]
[.agent/skills/geo-fundamentals/scripts/geo_checker.py] -> [pathlib]
[.agent/skills/i18n-localization/scripts/i18n_checker.py] -> [pathlib]
[.agent/skills/lint-and-validate/scripts/lint_runner.py] -> [datetime, pathlib]
[.agent/skills/lint-and-validate/scripts/type_coverage.py] -> [pathlib]
[.agent/skills/mobile-design/scripts/mobile_audit.py] -> [Hermes, light, pathlib, responsive, sp, typed]
[.agent/skills/nextjs-react-expert/scripts/convert_rules.py] -> [pathlib, typing]
[.agent/skills/nextjs-react-expert/scripts/react_performance_checker.py] -> [React.memo, SWR, pathlib, typing]
[.agent/skills/seo-fundamentals/scripts/seo_checker.py] -> [datetime, pathlib]
[.agent/skills/testing-patterns/scripts/test_runner.py] -> [datetime, pathlib]
[.agent/skills/vulnerability-scanner/scripts/security_scan.py] -> [datetime, pathlib, typing]
[.agent/skills/webapp-testing/scripts/playwright_runner.py] -> [datetime, playwright.sync_api]
[ActivityLog] -> [inherits] -> [DataClass]
[ActivityLoggingSheet] -> [inherits] -> [StatefulWidget]
[ActivityLogsCompanion] -> [inherits] -> [UpdateCompanion]
[ActivityLogs] -> [inherits] -> [Table]
[AppDatabase] -> [inherits] -> [_]
[AppDelegate] -> [inherits] -> [FlutterAppDelegate]
[AppDelegate] -> [inherits] -> [FlutterAppDelegate]
[AppDelegate] -> [inherits] -> [FlutterImplicitEngineDelegate]
[BabiesCompanion] -> [inherits] -> [UpdateCompanion]
[Babies] -> [inherits] -> [Table]
[BabyStepsApp] -> [inherits] -> [StatelessWidget]
[Baby] -> [inherits] -> [DataClass]
[DashboardView] -> [inherits] -> [StatelessWidget]
[DiaperLog] -> [inherits] -> [DataClass]
[DiaperLoggingSheet] -> [inherits] -> [StatefulWidget]
[DiaperLogsCompanion] -> [inherits] -> [UpdateCompanion]
[DiaperLogs] -> [inherits] -> [Table]
[FeedLoggingSheet] -> [inherits] -> [StatefulWidget]
[FeedingLog] -> [inherits] -> [DataClass]
[FeedingLogsCompanion] -> [inherits] -> [UpdateCompanion]
[FeedingLogs] -> [inherits] -> [Table]
[FlutterWindow] -> [inherits] -> [public]
[GeneratedPluginRegistrant] -> [inherits] -> [NSObject]
[GrowthLog] -> [inherits] -> [DataClass]
[GrowthLoggingSheet] -> [inherits] -> [StatefulWidget]
[GrowthLogsCompanion] -> [inherits] -> [UpdateCompanion]
[GrowthLogs] -> [inherits] -> [Table]
[HomeScreen] -> [inherits] -> [StatefulWidget]
[InsightsScreen] -> [inherits] -> [StatelessWidget]
[LoggingBloc] -> [inherits] -> [Bloc]
[LoggingEvent] -> [inherits] -> [Equatable]
[LoggingFailure] -> [inherits] -> [LoggingState]
[LoggingInitial] -> [inherits] -> [LoggingState]
[LoggingLoading] -> [inherits] -> [LoggingState]
[LoggingState] -> [inherits] -> [Equatable]
[LoggingSuccess] -> [inherits] -> [LoggingState]
[MainActivity] -> [inherits] -> [FlutterActivity]
[MainFlutterWindow] -> [inherits] -> [NSWindow]
[MedicalLog] -> [inherits] -> [DataClass]
[MedicalLoggingSheet] -> [inherits] -> [StatefulWidget]
[MedicalLogsCompanion] -> [inherits] -> [UpdateCompanion]
[MedicalLogs] -> [inherits] -> [Table]
[MockFlutterLocalNotificationsPlugin] -> [inherits] -> [Mock]
[MockGoogleSignInAccount] -> [inherits] -> [Mock]
[MockGoogleSignIn] -> [inherits] -> [Mock]
[RunnerTests] -> [inherits] -> [XCTestCase]
[RunnerTests] -> [inherits] -> [XCTestCase]
[SaveActivityLogEvent] -> [inherits] -> [LoggingEvent]
[SaveDiaperLogEvent] -> [inherits] -> [LoggingEvent]
[SaveFeedLogEvent] -> [inherits] -> [LoggingEvent]
[SaveGrowthLogEvent] -> [inherits] -> [LoggingEvent]
[SaveMedicalLogEvent] -> [inherits] -> [LoggingEvent]
[SaveSleepLogEvent] -> [inherits] -> [LoggingEvent]
[SceneDelegate] -> [inherits] -> [FlutterSceneDelegate]
[SettingsDrawer] -> [inherits] -> [StatefulWidget]
[SleepLog] -> [inherits] -> [DataClass]
[SleepLoggingSheet] -> [inherits] -> [StatefulWidget]
[SleepLogsCompanion] -> [inherits] -> [UpdateCompanion]
[SleepLogs] -> [inherits] -> [Table]
[ThemeCubit] -> [inherits] -> [Cubit]
[_ActivityLoggingSheetState] -> [inherits] -> [State]
[_DiaperLoggingSheetState] -> [inherits] -> [State]
[_FeedLoggingSheetState] -> [inherits] -> [State]
[_GrowthLoggingSheetState] -> [inherits] -> [State]
[_HomeScreenState] -> [inherits] -> [State]
[_MedicalLoggingSheetState] -> [inherits] -> [State]
[_SettingsDrawerState] -> [inherits] -> [State]
[_SleepLoggingSheetState] -> [inherits] -> [State]
[ios/Runner/GeneratedPluginRegistrant.m] -> [GeneratedPluginRegistrant.h]
[ios/Runner/Runner-Bridging-Header.h] -> [GeneratedPluginRegistrant.h]
[lib/app.dart] -> [core/database/app_database.dart, core/database/repositories/baby_repository.dart, core/database/repositories/log_repositories.dart, core/network/notification_service.dart, core/network/sync_service.dart, core/security/secure_storage.dart, core/theme/app_theme.dart, core/theme/theme_cubit.dart, features/home/presentation/home_screen.dart, features/logging/bloc/logging_bloc.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart]
[lib/core/database/app_database.dart] -> [connection/connection.dart, package:drift/drift.dart]
[lib/core/database/connection/connection.dart] -> [native.dart, package:drift/drift.dart]
[lib/core/database/connection/native.dart] -> [package:drift/drift.dart, package:drift_flutter/drift_flutter.dart]
[lib/core/database/connection/web.dart] -> [package:drift/drift.dart, package:drift_flutter/drift_flutter.dart]
[lib/core/database/repositories/baby_repository.dart] -> [lib/core/security/secure_storage.dart, lib/core/database/app_database.dart, package:drift/drift.dart]
[lib/core/database/repositories/log_repositories.dart] -> [lib/core/security/secure_storage.dart, lib/core/database/app_database.dart, package:drift/drift.dart]
[lib/core/network/notification_service.dart] -> [package:flutter_local_notifications/flutter_local_notifications.dart, package:timezone/data/latest_all.dart, package:timezone/timezone.dart]
[lib/core/network/sync_service.dart] -> [dart:convert, package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart, package:google_sign_in/google_sign_in.dart, package:googleapis/drive/v3.dart]
[lib/core/security/secure_storage.dart] -> [dart:convert, package:encrypt/encrypt.dart, package:flutter_secure_storage/flutter_secure_storage.dart]
[lib/core/theme/app_theme.dart] -> [colors.dart, package:flutter/material.dart]
[lib/core/theme/colors.dart] -> [package:flutter/material.dart]
[lib/core/theme/theme_cubit.dart] -> [package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart]
[lib/features/home/presentation/home_screen.dart] -> [lib/core/theme/colors.dart, lib/core/theme/theme_cubit.dart, lib/features/insights/presentation/insights_screen.dart, lib/features/logging/presentation/activity_logging_sheet.dart, lib/features/logging/presentation/diaper_logging_sheet.dart, lib/features/logging/presentation/feed_logging_sheet.dart, lib/features/logging/presentation/growth_logging_sheet.dart, lib/features/logging/presentation/medical_logging_sheet.dart, lib/features/logging/presentation/sleep_logging_sheet.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart, widgets/dashboard_view.dart, widgets/settings_drawer.dart]
[lib/features/home/presentation/widgets/dashboard_view.dart] -> [lib/core/database/app_database.dart, lib/core/database/repositories/log_repositories.dart, lib/core/theme/colors.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart, package:intl/intl.dart, package:rxdart/rxdart.dart, timeline_event.dart]
[lib/features/home/presentation/widgets/settings_drawer.dart] -> [lib/core/network/sync_service.dart, lib/core/theme/colors.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart]
[lib/features/home/presentation/widgets/timeline_event.dart] -> [package:flutter/material.dart]
[lib/features/insights/presentation/insights_screen.dart] -> [lib/core/database/app_database.dart, lib/core/database/repositories/log_repositories.dart, lib/core/theme/colors.dart, package:fl_chart/fl_chart.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart]
[lib/features/logging/bloc/logging_bloc.dart] -> [lib/core/database/repositories/baby_repository.dart, lib/core/database/repositories/log_repositories.dart, lib/core/network/notification_service.dart, package:equatable/equatable.dart, package:flutter_bloc/flutter_bloc.dart]
[lib/features/logging/presentation/activity_logging_sheet.dart] -> [lib/core/theme/colors.dart, lib/features/logging/bloc/logging_bloc.dart, dart:async, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart, package:shared_preferences/shared_preferences.dart]
[lib/features/logging/presentation/diaper_logging_sheet.dart] -> [lib/core/theme/colors.dart, lib/features/logging/bloc/logging_bloc.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart]
[lib/features/logging/presentation/feed_logging_sheet.dart] -> [lib/core/theme/colors.dart, lib/features/logging/bloc/logging_bloc.dart, dart:async, package:flutter/foundation.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart, package:image_picker/image_picker.dart, package:shared_preferences/shared_preferences.dart]
[lib/features/logging/presentation/growth_logging_sheet.dart] -> [lib/core/theme/colors.dart, lib/features/logging/bloc/logging_bloc.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart, package:shared_preferences/shared_preferences.dart]
[lib/features/logging/presentation/medical_logging_sheet.dart] -> [lib/core/theme/colors.dart, lib/features/logging/bloc/logging_bloc.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart]
[lib/features/logging/presentation/sleep_logging_sheet.dart] -> [lib/core/theme/colors.dart, lib/features/logging/bloc/logging_bloc.dart, package:flutter/material.dart, package:flutter_bloc/flutter_bloc.dart, package:shared_preferences/shared_preferences.dart]
[lib/main.dart] -> [app.dart, core/database/app_database.dart, core/security/secure_storage.dart, package:flutter/material.dart]
[linux/flutter/generated_plugin_registrant.cc] -> [file_selector_linux/file_selector_plugin.h, flutter_secure_storage_linux/flutter_secure_storage_linux_plugin.h, generated_plugin_registrant.h]
[linux/flutter/generated_plugin_registrant.h] -> [flutter_linux/flutter_linux.h]
[linux/runner/main.cc] -> [my_application.h]
[linux/runner/my_application.cc] -> [flutter/generated_plugin_registrant.h, flutter_linux/flutter_linux.h, gdk/gdkx.h, my_application.h]
[linux/runner/my_application.h] -> [gtk/gtk.h]
[test/core/network/notification_service_test.dart] -> [package:babysteps/core/network/notification_service.dart, package:flutter_local_notifications/flutter_local_notifications.dart, package:flutter_test/flutter_test.dart, package:mocktail/mocktail.dart, package:timezone/data/latest_all.dart, package:timezone/timezone.dart]
[test/core/network/sync_service_test.dart] -> [package:babysteps/core/network/sync_service.dart, package:flutter_test/flutter_test.dart, package:google_sign_in/google_sign_in.dart, package:mocktail/mocktail.dart]
[test/widget_test.dart] -> [package:flutter_test/flutter_test.dart]
[windows/flutter/generated_plugin_registrant.cc] -> [file_selector_windows/file_selector_windows.h, flutter_secure_storage_windows/flutter_secure_storage_windows_plugin.h, generated_plugin_registrant.h]
[windows/flutter/generated_plugin_registrant.h] -> [flutter/plugin_registry.h]
[windows/runner/flutter_window.cpp] -> [flutter/generated_plugin_registrant.h, flutter_window.h, optional]
[windows/runner/flutter_window.h] -> [flutter/dart_project.h, flutter/flutter_view_controller.h, memory, win32_window.h]
[windows/runner/main.cpp] -> [flutter/dart_project.h, flutter/flutter_view_controller.h, flutter_window.h, utils.h, windows.h]
[windows/runner/utils.cpp] -> [flutter_windows.h, io.h, iostream, stdio.h, utils.h, windows.h]
[windows/runner/utils.h] -> [string, vector]
[windows/runner/win32_window.cpp] -> [EnableNonClientDpiScaling, dwmapi.h, flutter_windows.h, resource.h, win32_window.h]
[windows/runner/win32_window.h] -> [functional, memory, string, windows.h]