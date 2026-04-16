# HabitFlow - Privacy-First Habit Tracker

A 100% FREE, privacy-first habit and task tracker app with offline-first architecture. Track habits, build streaks, and stay motivated - all without tracking YOU.

[![F-Droid](https://img.shields.io/f-droid/v/com.habitflow.app?logo=f-droid)](https://f-droid.org/packages/com.habitflow.app)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🎯 Key Features

### Habit Management
- ✅ Create, edit, and delete habits with ease
- 📅 Flexible scheduling: daily, weekly, monthly, or custom intervals
- 📝 Add rich notes to each habit for context and motivation
- 🎯 Mark tasks as completed, skipped, or failed
- 🔄 Drag-and-drop reordering of your habit list

### Streaks & Motivation
- 🔥 Real-time current streak tracking
- 🏆 Longest streak achievements
- 🎉 Milestone celebrations at 7, 30, and 100 day streaks
- ⭐ XP points and level progression system

### Analytics & Insights
- 📊 Beautiful line charts and bar graphs
- 🗓️ Calendar heatmap view (GitHub style)
- 📈 Weekly and monthly completion reports
- 📉 Completion percentage per habit

### Privacy & Security
- 🔒 **Zero tracking** - No analytics or user profiling
- 🌐 **Offline-first** - Works without internet
- 🔐 **Local storage** - Your data never leaves your device
- 🎁 **Free forever** - No ads, no subscriptions, no paywalls
- 📖 **Open source** - MIT licensed, fully auditable code

### Smart Features
- 🔔 Local notifications with custom reminder times
- 🎤 Voice input for quick habit logging
- 💾 Backup & restore as JSON files
- 🌓 Dark and light mode support
- ⚡ Lightning-fast performance

## 🚀 Quick Start

### Building from Source
```bash
# Install Flutter (if not already installed)
# https://flutter.dev/docs/get-started/install

# Clone the repo
git clone https://github.com/abhishek020405n-afk/Streaky.git
cd Streaky

# Get dependencies
flutter pub get

# Run the app
flutter run

# Build release APK
flutter build apk --release
```

### Requirements
- Flutter SDK >=3.0.0
- Android API 21+
- Dart 3.0+

## 📱 Download

- **F-Droid** (Recommended): [Add link after F-Droid approval]
- **GitHub Releases**: Check releases page for APK downloads

## 🔐 Privacy & Security

Streaky is built with privacy as a core principle:
- ✅ No tracking or analytics
- ✅ No ads or in-app purchases
- ✅ No cloud synchronization (unless you enable)
- ✅ Data stored locally on device
- ✅ No permissions required except storage & notifications
- ✅ Open source - code is auditable

## 📦 Tech Stack

- **Framework**: Flutter
- **State Management**: Riverpod
- **Database**: Hive (local-first)
- **UI**: Material Design
- **Charts**: FL Chart
- **Notifications**: Flutter Local Notifications

## 🛠️ Development

### Project Structure
```
Streaky/
├── lib/
│   ├── core/          # Constants, services, utilities
│   ├── features/      # Feature modules
│   └── main.dart      # Entry point
├── android/           # Android native code
├── ios/              # iOS native code
└── test/             # Unit & widget tests
```

### Key Dependencies
- `riverpod`: State management
- `hive_flutter`: Local database
- `flutter_local_notifications`: Push notifications
- `fl_chart`: Chart generation
- `speech_to_text`: Voice input

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🐛 Bug Reports & Feedback

Found a bug? Have a feature request?
- Issues: [GitHub Issues](https://github.com/abhishek020405n-afk/Streaky/issues)
- Discussions: [GitHub Discussions](https://github.com/abhishek020405n-afk/Streaky/discussions)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

- **Abhishek Kumar** - [GitHub](https://github.com/abhishek020405n-afk)

## ⭐ Show Your Support

If you like Streaky, please:
- ⭐ Star this repository
- 📦 Install from F-Droid
- 🐛 Help improve by reporting issues
- 💬 Share suggestions

## 🙏 Acknowledgments

- Flutter community
- F-Droid team
- Contributors and testers

---

**Built with ❤️ for privacy-conscious users**
