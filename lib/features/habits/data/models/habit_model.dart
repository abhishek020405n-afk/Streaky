import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';

class TaskModel {
  TaskModel({
    required this.date,
    this.status = TaskStatus.pending,
    this.notes = '',
  });

  final DateTime date;
  final TaskStatus status;
  final String notes;

  TaskModel copyWith({DateTime? date, TaskStatus? status, String? notes}) {
    return TaskModel(
      date: date ?? this.date,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'status': status.name,
      'notes': notes,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      date: DateTime.parse(json['date'] as String),
      status: TaskStatus.values.firstWhere(
        (value) => value.name == json['status'],
        orElse: () => TaskStatus.pending,
      ),
      notes: json['notes'] as String? ?? '',
    );
  }
}

class HabitModel {
  HabitModel({
    required this.id,
    required this.title,
    required this.category,
    this.notes = '',
    this.repeatType = RepeatType.daily,
    this.repeatWeekdays = const [1, 2, 3, 4, 5, 6, 7],
    this.customIntervalDays,
    required this.createdAt,
    this.oneTimeDate,
    this.isActive = true,
    this.reminderMinutes = const [],
    this.history = const [],
    this.xp = 0,
    this.order = 0,
  });

  final String id;
  final String title;
  final String category;
  final String notes;
  final RepeatType repeatType;
  final List<int> repeatWeekdays;
  final int? customIntervalDays;
  final DateTime createdAt;
  final DateTime? oneTimeDate;
  final bool isActive;
  final List<int> reminderMinutes;
  final List<TaskModel> history;
  final int xp;
  final int order;

  HabitModel copyWith({
    String? id,
    String? title,
    String? category,
    String? notes,
    RepeatType? repeatType,
    List<int>? repeatWeekdays,
    int? customIntervalDays,
    DateTime? createdAt,
    DateTime? oneTimeDate,
    bool? isActive,
    List<int>? reminderMinutes,
    List<TaskModel>? history,
    int? xp,
    int? order,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      repeatType: repeatType ?? this.repeatType,
      repeatWeekdays: repeatWeekdays ?? List.from(this.repeatWeekdays),
      customIntervalDays: customIntervalDays ?? this.customIntervalDays,
      createdAt: createdAt ?? this.createdAt,
      oneTimeDate: oneTimeDate ?? this.oneTimeDate,
      isActive: isActive ?? this.isActive,
      reminderMinutes: reminderMinutes ?? List.from(this.reminderMinutes),
      history: history ?? List.from(this.history),
      xp: xp ?? this.xp,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'notes': notes,
      'repeatType': repeatType.name,
      'repeatWeekdays': repeatWeekdays,
      'customIntervalDays': customIntervalDays,
      'createdAt': createdAt.toIso8601String(),
      'oneTimeDate': oneTimeDate?.toIso8601String(),
      'isActive': isActive,
      'reminderMinutes': reminderMinutes,
      'history': history.map((entry) => entry.toJson()).toList(),
      'xp': xp,
      'order': order,
    };
  }

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      notes: json['notes'] as String? ?? '',
      repeatType: RepeatType.values.firstWhere(
        (value) => value.name == json['repeatType'],
        orElse: () => RepeatType.daily,
      ),
      repeatWeekdays: List<int>.from(json['repeatWeekdays'] as List<dynamic>? ?? [1, 2, 3, 4, 5, 6, 7]),
      customIntervalDays: json['customIntervalDays'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      oneTimeDate: json['oneTimeDate'] == null ? null : DateTime.parse(json['oneTimeDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      reminderMinutes: List<int>.from(json['reminderMinutes'] as List<dynamic>? ?? []),
      history: List<Map<String, dynamic>>.from(json['history'] as List<dynamic>? ?? [])
          .map(TaskModel.fromJson)
          .toList(),
      xp: json['xp'] as int? ?? 0,
      order: json['order'] as int? ?? 0,
    );
  }
}

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final date = DateTime.parse(reader.readString());
    final status = TaskStatus.values[reader.readInt()];
    final notes = reader.readString();
    return TaskModel(date: date, status: status, notes: notes);
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.date.toIso8601String());
    writer.writeInt(obj.status.index);
    writer.writeString(obj.notes);
  }
}

class HabitModelAdapter extends TypeAdapter<HabitModel> {
  @override
  final int typeId = 1;

  @override
  HabitModel read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final category = reader.readString();
    final notes = reader.readString();
    final repeatType = RepeatType.values[reader.readInt()];
    final repeatWeekdays = List<int>.from(reader.readList().cast<int>());
    final customIntervalDays = reader.read() as int?;
    final createdAt = DateTime.parse(reader.readString());
    final oneTimeDateString = reader.readString();
    final oneTimeDate = oneTimeDateString.isEmpty ? null : DateTime.parse(oneTimeDateString);
    final isActive = reader.readBool();
    final reminderMinutes = List<int>.from(reader.readList().cast<int>());
    final history = List<TaskModel>.from(reader.readList().cast<TaskModel>());
    final xp = reader.readInt();
    final order = reader.readInt();
    return HabitModel(
      id: id,
      title: title,
      category: category,
      notes: notes,
      repeatType: repeatType,
      repeatWeekdays: repeatWeekdays,
      customIntervalDays: customIntervalDays,
      createdAt: createdAt,
      oneTimeDate: oneTimeDate,
      isActive: isActive,
      reminderMinutes: reminderMinutes,
      history: history,
      xp: xp,
      order: order,
    );
  }

  @override
  void write(BinaryWriter writer, HabitModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.category);
    writer.writeString(obj.notes);
    writer.writeInt(obj.repeatType.index);
    writer.writeList(obj.repeatWeekdays);
    writer.write(obj.customIntervalDays);
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeString(obj.oneTimeDate?.toIso8601String() ?? '');
    writer.writeBool(obj.isActive);
    writer.writeList(obj.reminderMinutes);
    writer.writeList(obj.history);
    writer.writeInt(obj.xp);
    writer.writeInt(obj.order);
  }
}
