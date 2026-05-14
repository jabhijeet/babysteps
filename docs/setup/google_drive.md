# Google Drive API Integration Guide

This document provides step-by-step instructions for obtaining and configuring Google OAuth 2.0 Client IDs required for the Google Drive synchronization feature in **BabySteps**.

## Overview

BabySteps uses the Google Drive API to:
- Backup and restore baby logs (structured JSON data).
- Store and share reaction photos.
- Facilitate partner synchronization via shared folders.

To enable this, you need to create a project in the [Google Cloud Console](https://console.cloud.google.com/) and generate platform-specific Client IDs.

---

## Step 1: Create a Google Cloud Project

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Click the project dropdown at the top and select **New Project**.
3. Name it `BabySteps` and click **Create**.

## Step 2: Enable Google Drive API

1. In the sidebar, go to **APIs & Services** > **Library**.
2. Search for `Google Drive API`.
3. Click on it and select **Enable**.

## Step 3: Configure OAuth Consent Screen

1. Go to **APIs & Services** > **OAuth consent screen**.
2. Select **External** (unless you have a Google Workspace organization).
3. Fill in the required fields:
   - **App name**: `BabySteps`
   - **User support email**: Your email.
   - **Developer contact information**: Your email.
4. In the **Scopes** step, click **Add or Remove Scopes**.
5. Manually add this scope: `https://www.googleapis.com/auth/drive.file`
   - *Note: This scope only gives the app access to files it creates, maximizing user privacy.*
6. Add your email as a **Test User** (since the app is in "Testing" mode).

---

## Step 4: Create Client IDs

Go to **APIs & Services** > **Credentials** > **Create Credentials** > **OAuth client ID**.

### 📱 Android (Critical)
1. **Application type**: `Android`
2. **Name**: `BabySteps Android Client`
3. **Package name**: `io.github.jabhijeet` (Verify in `android/app/build.gradle.kts`)
4. **SHA-1 certificate fingerprint**:
   - Run `./gradlew signingReport` in the `android` folder to get your debug/release SHA-1.
5. Click **Create**.

### 🍎 iOS
1. **Application type**: `iOS`
2. **Name**: `BabySteps iOS Client`
3. **Bundle ID**: `io.github.jabhijeet` (Verify in Xcode project settings)
4. Click **Create**.

### 💻 Desktop (Windows, macOS, Linux)
1. **Application type**: `Desktop app`
2. **Name**: `BabySteps Desktop Client`
3. Click **Create**.

### 🌐 Web (Optional)
1. **Application type**: `Web application`
2. **Name**: `BabySteps Web Client`
3. **Authorized JavaScript origins**: `http://localhost:[PORT]`
4. **Authorized redirect URIs**: `http://localhost:[PORT]`
5. Click **Create**.

---

## Step 5: Configure the Flutter App

Once you have the Client IDs, you need to pass them to the app during the build process or at runtime.

### Option A: Build-time Configuration (Recommended)
Pass the IDs using `--dart-define` flags:

```bash
flutter run \
  --dart-define=GOOGLE_OAUTH_WEB_CLIENT_ID=your-web-id \
  --dart-define=GOOGLE_OAUTH_DESKTOP_CLIENT_ID=your-desktop-id \
  --dart-define=GOOGLE_OAUTH_IOS_CLIENT_ID=your-ios-id \
  --dart-define=GOOGLE_OAUTH_ANDROID_CLIENT_ID=your-android-id
```

### Option B: Runtime Configuration
1. Open the **Settings Drawer** in the app.
2. Go to **AI & Voice Configuration** (or the Sync section).
3. Enter the Client ID manually in the provided field. This value will be persisted to `SharedPreferences` and override the build-time defaults.

---

## Troubleshooting

- **Developer Error**: This usually means the SHA-1 or Package Name doesn't match what is registered in the console.
- **Access Blocked**: Ensure your email is added to the "Test Users" list in the OAuth Consent Screen.
- **Scope Error**: Ensure `drive.file` is explicitly added to the project scopes.

---

## Current Project Configuration (Reference)

For the current **BabySteps** project, the following settings were used in the Google Cloud Console:

- **Project Name**: `BabySteps`
- **Package Name**: `io.github.jabhijeet.babysteps`
- **SHA-1 Fingerprint**: `ED:51:51:BF:FE:33:70:26:B2:1B:46:25:82:77:9B:61:03:69:2B:E1`

### Configured Client IDs:
- **Web**: `536929186027-1754bsjdb10c8iqjjo22fge1umpo7vu1.apps.googleusercontent.com`
- **Android**: `536929186027-r5jnjvusonhqfi518m4fg6qv5e6koej4.apps.googleusercontent.com`
- **Desktop**: `536929186027-8jc73ucgmk5ckintahro8ro94mk0p67n.apps.googleusercontent.com`
