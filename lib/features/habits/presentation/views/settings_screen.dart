import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/backup_service.dart';
import 'privacy_policy_page.dart';
import '../providers/habit_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.watch(habitActionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings & Privacy')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Data & backup', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              _settingsCard(
                context,
                title: 'Export data',
                subtitle: 'Save your habits, streaks, and reminders as a JSON backup.',
                icon: Icons.upload_file,
                onPressed: () async {
                  final habits = await ref.read(habitStreamProvider.future);
                  final success = await BackupService.exportHabits(habits);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Backup exported successfully.' : 'Backup export cancelled.')));
                },
              ),
              _settingsCard(
                context,
                title: 'Import data',
                subtitle: 'Restore your saved habits from a JSON backup file.',
                icon: Icons.download,
                onPressed: () async {
                  final payload = await BackupService.importHabits();
                  if (payload != null) {
                    await actions.importHabits(payload);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backup imported successfully.')));
                  }
                },
              ),
              const SizedBox(height: 20),
              Text('Privacy', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              _settingsCard(
                context,
                title: 'Privacy policy',
                subtitle: 'Your data stays on your device. No tracking, no login, no cloud sync.',
                icon: Icons.privacy_tip,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrivacyPolicyPage())),
              ),
              const SizedBox(height: 20),
              Text('Support', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              _settingsCard(
                context,
                title: 'Support developer',
                subtitle: 'Share the app or donate to keep HabitFlow free and offline-first.',
                icon: Icons.favorite,
                onPressed: () {
                  SharePlus.instance.share(ShareParams(text: 'I use HabitFlow for offline habit tracking. Support the developer if you like the app!'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsCard(BuildContext context,
      {required String title, required String subtitle, required IconData icon, required VoidCallback onPressed}) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onPressed,
      ),
    );
  }
}
