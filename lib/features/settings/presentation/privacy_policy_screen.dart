import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(Theme.of(context).brightness),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildSection(
              context,
              icon: Icons.lock_outline,
              title: '1. Encryption First',
              content:
                  'BabySteps was designed with an "Encryption First" philosophy. All sensitive health and routine data (such as notes, measurements, and feeding logs) are encrypted locally on your device using military-grade AES-256 encryption BEFORE they are ever saved to your cloud storage. We cannot read your baby\'s data, and neither can anyone else without your specific decryption key.',
            ),
            _buildSection(
              context,
              icon: Icons.cloud_off,
              title: '2. You Own Your Data',
              content:
                  'We do not host your data on our servers. All synchronization happens through your own personal Google Drive account. The app creates a specific folder in your Google Drive where encrypted files are stored. This means you have ultimate control over your data and can delete it permanently at any time directly from your cloud provider.',
            ),
            _buildSection(
              context,
              icon: Icons.people_outline,
              title: '3. Secure Sharing',
              content:
                  'When you share a baby\'s profile with a partner or relative, the app securely grants them access to the specific folder on your Google Drive. The encryption key is shared directly between your devices via a secure Deep Link or QR Code. At no point is this key transmitted to any centralized server.',
            ),
            _buildSection(
              context,
              icon: Icons.analytics_outlined,
              title: '4. Zero Tracking',
              content:
                  'BabySteps does not use third-party analytics trackers, advertising identifiers, or telemetry that profiles your behavior. The only network requests made are directly to Google Drive for synchronization purposes.',
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                'Last Updated: April 2026\nBabySteps - Ultimate Privacy-First Tracker',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.shield_moon,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          'Your Baby\'s Data is Private.',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'We believe that parents should never have to compromise between convenience and privacy. Here is how we protect your family.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context,
      {required IconData icon,
      required String title,
      required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
