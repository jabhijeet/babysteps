import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/sync_cubit.dart';
import '../../../../core/theme/colors.dart';
import '../../../home/cubit/baby_selection_cubit.dart';
import '../baby_management_screen.dart';
import '../../../../features/settings/presentation/privacy_policy_screen.dart';
import '../../../../features/settings/presentation/ai_config_screen.dart';
import '../../../../core/security/secure_storage.dart';
import 'package:share_plus/share_plus.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key, required this.babyId});

  final int babyId;

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  bool _isSigningIn = false;
  final TextEditingController _partnerEmailController = TextEditingController();

  @override
  void dispose() {
    _partnerEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncCubit, SyncState>(
      builder: (context, syncState) {
        final user = syncState.currentUser;
        final syncCubit = context.read<SyncCubit>();

        return Drawer(
          child: SafeArea(
            child: Column(
              children: [
                // ── Header ────────────────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.backgroundGradientDark
                        : AppColors.sleepGradient,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.settings,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 16),
                      Text('Settings',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontSize: 24)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // ── Babies Section ─────────────────────────────────────
                      Text('Babies',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      BlocBuilder<BabySelectionCubit, BabySelectionState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              ...state.babies.map((baby) {
                                final isSelected = baby.id == state.selectedBabyId;
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    backgroundColor: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                                    child: Icon(
                                      Icons.child_care,
                                      color: isSelected
                                          ? Colors.white
                                          : Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                  title: Text(
                                    baby.name,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  trailing: isSelected
                                      ? Icon(Icons.check,
                                          color: Theme.of(context).colorScheme.primary)
                                      : null,
                                  onTap: () {
                                    if (!isSelected) {
                                      context.read<BabySelectionCubit>().selectBaby(baby.id);
                                    }
                                    Navigator.pop(context);
                                  },
                                );
                              }),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest
                                      .withValues(alpha: 0.5),
                                  child: const Icon(Icons.add),
                                ),
                                title: const Text('Manage Babies'),
                                onTap: () {
                                  Navigator.pop(context);
                                  unawaited(Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<BabySelectionCubit>(),
                                        child: const BabyManagementScreen(),
                                      ),
                                    ),
                                  ));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const Divider(),

                      // ── Cloud Sync Section ─────────────────────────────────
                      Text('Cloud Sync',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      if (user == null)
                        ElevatedButton.icon(
                          onPressed: _isSigningIn
                              ? null
                              : () async {
                                  setState(() => _isSigningIn = true);
                                  try {
                                    await syncCubit.signIn();
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Sign in failed: $e')));
                                    }
                                  } finally {
                                    if (context.mounted) {
                                      setState(() => _isSigningIn = false);
                                    }
                                  }
                                },
                          icon: _isSigningIn
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.cloud_upload),
                          label: const Text('Sign in with Google'),
                        )
                      else ...[
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                              backgroundImage: user.photoUrl != null
                                  ? NetworkImage(user.photoUrl!)
                                  : null,
                              child: user.photoUrl == null
                                  ? const Icon(Icons.person)
                                  : null),
                          title: Text(user.displayName ?? 'Signed In'),
                          subtitle: Text(user.email),
                          trailing: IconButton(
                            icon: const Icon(Icons.logout),
                            onPressed: syncCubit.signOut,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 16),
                        _buildSyncButton(
                          context,
                          icon: Icons.backup_outlined,
                          label: 'Backup Now',
                          onPressed: () async {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Backing up...')));
                              // In a real app, we'd get the actual DB content here
                              await syncCubit.backupDatabase(widget.babyId, '{"dummy": "data"}');
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Backup successful!')));
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Backup failed: $e')));
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildSyncButton(
                          context,
                          icon: Icons.restore_outlined,
                          label: 'Restore from Cloud',
                          onPressed: () async {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Restoring...')));
                              final data = await syncCubit.restoreDatabase(widget.babyId);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(data != null
                                        ? 'Restore successful!'
                                        : 'No backup found.')));
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Restore failed: $e')));
                              }
                            }
                          },
                        ),
                        const Divider(height: 32),
                        
                        // ── Partner Sharing ────────────────────────────────
                        Text('Partner Sharing',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        _buildSyncButton(
                          context,
                          icon: Icons.group_add_outlined,
                          label: 'Join Baby profile',
                          onPressed: () => _showJoinBabySheet(context),
                        ),
                        const SizedBox(height: 12),
                        _buildSyncButton(
                          context,
                          icon: Icons.person_add_outlined,
                          label: 'Invite Partner',
                          onPressed: () => _showInvitePartnerSheet(context),
                        ),
                      ],
                      const Divider(),
                      
                      // ── Privacy & Security ─────────────────────────────
                      Text('Privacy & Security',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.shield_outlined, color: Colors.green),
                        title: const Text('Privacy Policy'),
                        subtitle: const Text('Encryption first, zero tracking'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(context); // Close drawer
                          unawaited(Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const PrivacyPolicyScreen(),
                            ),
                          ));
                        },
                      ),
                      const Divider(),
                      
                      // ── AI & Voice Configuration ───────────────────────
                      Text('AI & Voice',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.smart_toy, color: Colors.blue),
                        title: const Text('AI & Voice Configuration'),
                        subtitle: const Text('Configure LLM provider and voice input'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(context); // Close drawer
                          unawaited(Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const AiConfigScreen(),
                            ),
                          ));
                        },
                      ),
                      const Divider(),
                      
                      // ── Advanced Settings ──────────────────────────────
                      ExpansionTile(
                        title: const Text('Advanced Settings'),
                        leading: const Icon(Icons.build_circle),
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: const EdgeInsets.only(left: 16),
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.vpn_key),
                            title: const Text('Configure Client ID'),
                            subtitle: const Text('Custom OAuth Client ID'),
                            onTap: () => _showClientIdDialog(context, syncCubit),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showJoinBabySheet(BuildContext context) {
    final folderIdController = TextEditingController();
    final keyController = TextEditingController();
    bool isStep2 = false;
    Map<String, dynamic>? metadata;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 24,
            right: 24,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isStep2 ? 'Confirm Baby' : 'Join Baby',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                isStep2
                    ? 'Found a baby profile. Do you want to join?'
                    : 'Enter the details shared by your partner.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (!isStep2) ...[
                TextField(
                  controller: folderIdController,
                  decoration: InputDecoration(
                    labelText: 'Folder ID',
                    prefixIcon: const Icon(Icons.folder_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: keyController,
                  decoration: InputDecoration(
                    labelText: 'Encryption Key',
                    prefixIcon: const Icon(Icons.vpn_key_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        metadata?['name'] ?? 'Unknown',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Born: ${metadata?['dob'] ?? 'Unknown'}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (!isStep2) {
                    if (folderIdController.text.isEmpty || keyController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }

                    try {
                      final syncCubit = context.read<SyncCubit>();
                      if (!syncCubit.state.isSignedIn) {
                        await syncCubit.signIn();
                      }

                      final foundMetadata = await syncCubit.getBabyMetadata(folderIdController.text);
                      if (foundMetadata != null) {
                        setModalState(() {
                          metadata = foundMetadata;
                          isStep2 = true;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not find baby metadata in that folder.')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  } else {
                    try {
                      final secureStorage = context.read<SecureStorage>();
                      final babyRepository = context.read<BabyRepository>();

                      await secureStorage.saveEncryptionKey(keyController.text);

                      await babyRepository.joinBaby(
                        metadata!['name'],
                        DateTime.parse(metadata!['dob']),
                        metadata!['gender'],
                        folderIdController.text,
                      );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully joined baby!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Join failed: $e')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(isStep2 ? 'Confirm & Join' : 'Fetch Details'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showInvitePartnerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 24,
          left: 24,
          right: 24,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Invite Partner',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter your partner\'s email to grant them access to the baby\'s data folder.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _partnerEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Partner Email Address',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final email = _partnerEmailController.text.trim();
                if (email.isNotEmpty) {
                  try {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Granting access...')),
                    );
                    
                    final syncCubit = context.read<SyncCubit>();
                    await syncCubit.shareWithPartner(widget.babyId, email);
                    final folderId = await syncCubit.getBabyFolderId(widget.babyId);
                    final encryptionKey = await context.read<SecureStorage>().getEncryptionKey();
                    
                    _partnerEmailController.clear();
                    if (context.mounted) {
                      _showShareBottomSheet(context, folderId, encryptionKey);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to invite partner: $e')),
                      );
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Send Invitation'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context, String folderId, String encryptionKey) {
    final babySelection = context.read<BabySelectionCubit>().state;
    final babyName = babySelection.selectedBaby?.name ?? 'Baby';
    
    // Generate a deep link or shareable text
    // Format: BabySteps Invite | Name: [Name] | Folder: [ID] | Key: [Key]
    final shareText = 'Join me on BabySteps to track $babyName\'s routine!\n\n'
        '1. Install BabySteps\n'
        '2. Go to Settings > Cloud Sync > Join Baby\n'
        '3. Use these details:\n'
        'Folder ID: $folderId\n'
        'Encryption Key: $encryptionKey';

    unawaited(showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Share Invitation',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Your partner has been granted access to the Google Drive folder. Now share these credentials securely.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    context,
                    icon: Icons.share,
                    label: 'Share All',
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      Navigator.pop(ctx);
                      unawaited(Share.share(shareText, subject: 'BabySteps Invitation for $babyName'));
                    },
                  ),
                  _buildShareOption(
                    context,
                    icon: Icons.vpn_key,
                    label: 'Copy Key',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pop(ctx);
                      // Use Share.share for simple copy if needed, or clipboard
                      unawaited(Share.share(encryptionKey));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Encryption key shared!')));
                    },
                  ),
                  _buildShareOption(
                    context,
                    icon: Icons.folder,
                    label: 'Copy ID',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pop(ctx);
                      unawaited(Share.share(folderId));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Folder ID shared!')));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildShareOption(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Future<void> _showClientIdDialog(
      BuildContext context, SyncCubit syncCubit) async {
    final currentId = await syncCubit.getCurrentClientId();
    final controller = TextEditingController(text: currentId);

    if (!context.mounted) return;

    unawaited(showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Configure Client ID'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Enter your Google OAuth Client ID for this platform. Leave blank to use the default ID.'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Client ID',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await syncCubit.updateClientId(controller.text);
              if (ctx.mounted) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Client ID updated')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ));
  }
}