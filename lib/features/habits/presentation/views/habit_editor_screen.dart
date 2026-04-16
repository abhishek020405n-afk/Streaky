import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/speech_service.dart';
import '../../data/models/habit_model.dart';
import '../providers/habit_providers.dart';

class HabitEditorScreen extends ConsumerStatefulWidget {
  const HabitEditorScreen({super.key, this.habit});

  final HabitModel? habit;

  @override
  ConsumerState<HabitEditorScreen> createState() => _HabitEditorScreenState();
}

class _HabitEditorScreenState extends ConsumerState<HabitEditorScreen> {
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  late HabitCategory _category;
  late RepeatType _repeatType;
  late List<int> _repeatWeekdays;
  late int? _customIntervalDays;
  late DateTime? _oneTimeDate;
  List<TimeOfDay> _reminders = [];
  final _speechService = SpeechService();
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    final habit = widget.habit;
    if (habit != null) {
      _titleController.text = habit.title;
      _notesController.text = habit.notes;
      _category = HabitCategory.values.firstWhere((value) => value.displayName == habit.category, orElse: () => HabitCategory.other);
      _repeatType = habit.repeatType;
      _repeatWeekdays = List.from(habit.repeatWeekdays);
      _customIntervalDays = habit.customIntervalDays;
      _oneTimeDate = habit.oneTimeDate;
      _reminders = habit.reminderMinutes.map((minutes) => TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60)).toList();
    } else {
      _titleController.text = '';
      _notesController.text = '';
      _category = HabitCategory.other;
      _repeatType = RepeatType.daily;
      _repeatWeekdays = [1, 2, 3, 4, 5, 6, 7];
      _customIntervalDays = 1;
      _oneTimeDate = DateTime.now();
      _reminders = [];
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickReminder() async {
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null && !_reminders.contains(time)) {
      setState(() => _reminders = [..._reminders, time]);
    }
  }

  Future<void> _pickOneTimeDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _oneTimeDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _oneTimeDate = picked);
    }
  }

  Future<void> _listenForVoice() async {
    setState(() => _isRecording = true);
    final result = await _speechService.listen();
    setState(() => _isRecording = false);
    if (result != null && result.isNotEmpty) {
      _titleController.text = result;
    }
  }

  Future<void> _saveHabit() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a habit name.')));
      return;
    }

    final habit = HabitModel(
      id: widget.habit?.id ?? const Uuid().v4(),
      title: title,
      category: _category.displayName,
      notes: _notesController.text.trim(),
      repeatType: _repeatType,
      repeatWeekdays: _repeatType == RepeatType.weekly ? _repeatWeekdays : const [1, 2, 3, 4, 5, 6, 7],
      customIntervalDays: _repeatType == RepeatType.custom ? _customIntervalDays : null,
      createdAt: widget.habit?.createdAt ?? DateTime.now(),
      oneTimeDate: _repeatType == RepeatType.once ? _oneTimeDate : null,
      reminderMinutes: _reminders.map((time) => time.hour * 60 + time.minute).toList(),
      history: widget.habit?.history ?? [],
      xp: widget.habit?.xp ?? 0,
      order: widget.habit?.order ?? 0,
    );

    await ref.read(habitActionsProvider).saveHabit(habit);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.habit == null ? 'New Habit' : 'Edit Habit')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Habit or Task',
                  suffixIcon: IconButton(
                    icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
                    onPressed: _listenForVoice,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Category', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: HabitCategory.values.map((category) {
                  final selected = category == _category;
                  return ChoiceChip(
                    label: Text('${category.emoji} ${category.displayName}'),
                    selected: selected,
                    onSelected: (_) => setState(() => _category = category),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<RepeatType>(
                initialValue: _repeatType,
                items: RepeatType.values.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type.name.toUpperCase()));
                }).toList(),
                decoration: const InputDecoration(labelText: 'Repeat schedule'),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _repeatType = value);
                  }
                },
              ),
              if (_repeatType == RepeatType.weekly) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: List.generate(7, (index) {
                    final weekday = index + 1;
                    final selected = _repeatWeekdays.contains(weekday);
                    return FilterChip(
                      label: Text(DateFormat.E().format(DateTime(2024, 1, weekday + 1))),
                      selected: selected,
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            _repeatWeekdays = [..._repeatWeekdays, weekday];
                          } else {
                            _repeatWeekdays = _repeatWeekdays.where((day) => day != weekday).toList();
                          }
                        });
                      },
                    );
                  }),
                ),
              ],
              if (_repeatType == RepeatType.custom) ...[
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: _customIntervalDays?.toString(),
                  decoration: const InputDecoration(labelText: 'Repeat every N days'),
                  onChanged: (value) => _customIntervalDays = int.tryParse(value) ?? 1,
                ),
              ],
              if (_repeatType == RepeatType.once) ...[
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('One-time date'),
                  subtitle: Text(_oneTimeDate != null ? DateFormat.yMMMd().format(_oneTimeDate!) : 'Select date'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: _pickOneTimeDate,
                ),
              ],
              const SizedBox(height: 16),
              TextField(
                controller: _notesController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              const SizedBox(height: 16),
              Text('Reminders', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _reminders
                    .map((time) => Chip(label: Text(time.format(context)), onDeleted: () => setState(() => _reminders.remove(time))))
                    .toList(),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  icon: const Icon(Icons.add_alert),
                  label: const Text('Add reminder'),
                  onPressed: _pickReminder,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveHabit,
                child: Text(widget.habit == null ? 'Create habit' : 'Save changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
