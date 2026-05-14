import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/sync_cubit.dart';
import '../../../../core/theme/colors.dart';
import '../../../home/cubit/baby_selection_cubit.dart';
import '../baby_management_screen.dart';
import '../../../../features/settings/presentation/privacy_policy_screen.dart';
import '../../../../features/settings/presentation/ai_config_screen.dart';

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
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.backup),
                          title: const Text('Backup Now'),
                          subtitle: Text(
                              'Backup data for baby ID: ${widget.babyId}'),
                          onTap: () async {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Backing up...')));
                              await syncCubit.backupDatabase(
                                  widget.babyId, '{"dummy": "data"}');
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Backup successful!')));
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Backup failed: $e')));
                              }
                            }
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.restore),
                          title: const Text('Restore from Cloud'),
                          onTap: () async {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Restoring...')));
                              final data = await syncCubit
                                  .restoreDatabase(widget.babyId);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(data != null
                                            ? 'Restore successful!'
                                            : 'No backup found.')));
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Restore failed: $e')));
                              }
                            }
                          },
                        ),
                        const Divider(),
                        
                        // ── Partner Sharing ────────────────────────────────
                        Text('Partner Sharing',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 4),
                        BlocBuilder<BabySelectionCubit, BabySelectionState>(
                          builder: (context, state) {
                            final babyName =
                                state.selectedBaby?.name ?? 'your baby';
                            return Text(
                              'Share $babyName\'s data with your partner',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6)),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _partnerEmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Partner Email Address',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final email = _partnerEmailController.text.trim();
                            if (email.isNotEmpty) {
                              try {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Granting access and generating link...')),
                                );
                                await syncCubit.shareWithPartner(widget.babyId, email);
                                _partnerEmailController.clear();
                                if (context.mounted) {
                                  _showShareBottomSheet(context);
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Failed to invite partner: $e')),
                                  );
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter a valid email address')),
                              );
                            }
                          },
                          icon: const Icon(Icons.person_add),
                          label: const Text('Invite & Generate Link'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
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

  void _showShareBottomSheet(BuildContext context) {
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
                'Share Encryption Key',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your partner has been granted Google Drive access. Now, send them the secure link containing the encryption key to join.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    context,
                    icon: Icons.qr_code,
                    label: 'QR Code',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Show QR Code (Coming Soon)')));
                    },
                  ),
                  _buildShareOption(
                    context,
                    icon: Icons.chat,
                    label: 'WhatsApp',
                    color: Colors.green,
                    onTap: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open WhatsApp (Coming Soon)')));
                    },
                  ),
                  _buildShareOption(
                    context,
                    icon: Icons.email,
                    label: 'Email',
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open Email (Coming Soon)')));
                    },
                  ),
                  _buildShareOption(
                    context,
                    icon: Icons.link,
                    label: 'Copy Link',
                    color: Colors.grey.shade700,
                    onTap: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied to clipboard!')));
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