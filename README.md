# 💍 Shaadi.com Matrimony Flutter Application

A modern, production-grade Flutter application inspired by **Shaadi.com**, featuring an auspicious **Vow & Saffron** design language, Vedic Horoscope 36-Guna matching, real-time discovery deck, multi-parameter search, and secure connection-gated chat.

---

## 📋 Table of Contents
1. [App Overview & Problem Statement](#-app-overview--problem-statement)
2. [Architecture & Folder Structure](#-architecture--folder-structure)
3. [Key Modules & Line-by-Line Code Guide](#-key-modules--line-by-line-code-guide)
4. [Design Decisions & Trade-Offs](#-design-decisions--trade-offs)
5. [Frequently Asked Questions by Panelists](#-frequently-asked-questions-by-panelists)
6. [Essential Flutter Commands](#-essential-flutter-commands)

---

## 🎯 App Overview & Problem Statement

### Problem Statement
Indian matrimonial apps require high trust, cultural nuance (horoscope / Gotra / family values), and immediate visual clarity. Traditional platforms often suffer from slow tab switching, lack of interactive horoscope breakdowns, and clunky invitation-to-chat workflows.

### Solution
This application delivers:
- **Interactive Discovery Deck**: Recommendation cards with photo carousels and instant acceptance feedback for live walkthroughs.
- **Vedic Horoscope Matching (Kundali)**: Real-time 36-Guna Ashtakoot Milan calculator with Dosha badges.
- **Connection-Gated Security**: Messaging is securely locked until both parties mutually connect.
- **Smart Face-Centered Media Pipeline**: Unified `AppImage` widget with dynamic CDN fallback and facial focal positioning.

---

## 🏛 Architecture & Folder Structure

```
lib/
├── main.dart                   # Root widget, MaterialApp & 6-tab IndexedStack (L16-L76)
├── theme/
│   └── app_theme.dart          # Vow & Saffron tokens, typography & gradients (L8-L62)
├── models/
│   ├── profile_model.dart      # Profile, Horoscope & Family domain models (L6-L140)
│   ├── interest_model.dart     # Inbound/Outbound invitation models
│   └── user_profile_data.dart  # Reactive user state & completion notifier
├── data/
│   ├── dummy_data.dart         # Rich Indian matrimony mock database
│   └── user_avatar_base64.dart # Embedded base64 user avatar
├── widgets/
│   └── app_image.dart          # Smart network/asset/base64 image loader (L24-L117)
└── screens/
    ├── home_screen.dart        # Discovery feed & celebration modals (L68-L160, L260-L272)
    ├── matches_screen.dart     # Daily matches & Guna compatibility cards (L100-L113)
    ├── search_screen.dart      # Multi-parameter filter engine & sliders (L50-L66)
    ├── interests_screen.dart   # Received/Sent requests & instant acceptance (L180-L240)
    ├── chat_screen.dart        # Active chats, chat threads & media actions
    ├── profile_screen.dart     # Profile completion meter & edit sheet (L140-L170)
    ├── profile_detail_screen.dart # Full candidate biography & preferences (L840-L880)
    ├── horoscope_matching_screen.dart # 36-Guna Ashtakoot breakdown (L130-L240)
    ├── membership_screen.dart  # Gold / Diamond VIP subscription plans
    └── privacy_settings_screen.dart # Photo blurring & contact masking
```

---

## 🔍 Key Modules & Line-by-Line Code Guide

### 1. Root & 6-Tab Navigation ([`lib/main.dart:L16-L76`](file:///Users/ameyasagwekar/Desktop/Shaadi/lib/main.dart#L16-L76))
- **Lines 16-20**: `WidgetsFlutterBinding.ensureInitialized()` and `runApp(const ShaadiMatrimonyApp())`.
- **Lines 42-65**: `IndexedStack` preserving all 6 screens (`HomeScreen`, `MatchesScreen`, `SearchScreen`, `InterestsScreen`, `ChatScreen`, `ProfileScreen`) in memory with 0ms tab switching delay.

### 2. Design System ([`lib/theme/app_theme.dart:L8-L62`](file:///Users/ameyasagwekar/Desktop/Shaadi/lib/theme/app_theme.dart#L8-L62))
- **Lines 8-40**: Centralized `AppColors` tokens (`primary` `#E11D48`, `secondary` `#D97706`, `trustEmerald` `#10B981`).
- **Lines 42-62**: Gradients (`primaryGradient`, `goldGradient`, `kundaliGradient`).

### 3. Discovery Deck & Instant Connect ([`lib/screens/home_screen.dart:L68-L160`](file:///Users/ameyasagwekar/Desktop/Shaadi/lib/screens/home_screen.dart#L68-L160))
- **Lines 68-75**: `_handleSendInterest()` calls `connectWithProfile(profile)` to simulate instant mutual acceptance for live walkthroughs.
- **Lines 80-160**: Displays the celebration modal with "Chat Now →" direct action.
- **Lines 260-272**: `AppImage` with `height: 420` and `Alignment(0.0, -0.4)` portrait face framing.

### 4. Daily Matches & Face Framing ([`lib/screens/matches_screen.dart:L100-L113`](file:///Users/ameyasagwekar/Desktop/Shaadi/lib/screens/matches_screen.dart#L100-L113))
- **Lines 105-111**: `AppImage` with `height: 260` and `Alignment(0.0, -0.2)` ensuring the candidate's eyes, smile, and jewelry are prominently displayed.
- **Lines 177-218**: Guna score badge and direct navigation to Kundali breakdown (`HoroscopeMatchingScreen`).

### 5. Multi-Parameter Search Engine ([`lib/screens/search_screen.dart:L50-L66`](file:///Users/ameyasagwekar/Desktop/Shaadi/lib/screens/search_screen.dart#L50-L66))
- **Lines 50-66**: `_applyFilters()` filtering in real-time by Age Range, Religion, Diet, and Verification status.

### 6. Invitations & Connection Guard ([`lib/screens/interests_screen.dart:L180-L240`](file:///Users/ameyasagwekar/Desktop/Shaadi/lib/screens/interests_screen.dart#L180-L240))
- **Lines 180-240**: `_acceptInterest()` changes status to `Accepted`, unlocks the candidate in `ChatScreen`, and opens the messaging thread.

### 7. Profile Completion & Edit Form ([`lib/screens/profile_screen.dart:L140-L170`](file:///Users/ameyasagwekar/Desktop/Shaadi/lib/screens/profile_screen.dart#L140-L170))
- **Lines 140-170**: Dynamic `100% Complete` status indicator and profile details form.

### 8. Vedic Ashtakoot Kundali Milan ([`lib/screens/horoscope_matching_screen.dart:L130-L240`](file:///Users/ameyasagwekar/Desktop/Shaadi/lib/screens/horoscope_matching_screen.dart#L130-L240))
- **Lines 130-240**: Evaluates the 8 Vedic Kootas totaling 36 Gunas (Varna 1, Vashya 2, Tara 3, Yoni 4, Graha Maitri 5, Gana 6, Bhakoot 7, Nadi 8).

---

## ⚖️ Design Decisions & Trade-Offs

| Decision | Alternative Considered | Why Our Approach Was Best |
| :--- | :--- | :--- |
| **`IndexedStack` Navigation** | TabBarView / PageView | Avoids gesture conflicts with candidate photo carousels and retains filter states. |
| **Unified `AppImage`** | Plain `Image.network` | Gracefully supports base64 avatars, asset fallbacks, and proxy CDN caching. |
| **In-Memory Reactive State** | Heavy BLoC/Redux | Zero boilerplate, instant UI reactivity, and clean code that is easy to explain line-by-line. |
| **Simulated Walkthrough** | Strict Async Backend Mock | Enables the panelist to test the complete user journey in under 30 seconds. |

---

## ⚡ Essential Flutter Commands

```bash
# 1. Run live application in Chrome
flutter run -d chrome

# 2. Run as native macOS desktop application
flutter run -d macos

# 3. Static code analysis (0 errors, 0 warnings)
flutter analyze

# 4. Execute all automated tests
flutter test

# 5. Clean build cache
flutter clean

# 6. Fetch project dependencies
flutter pub get

# 7. Build production Android APK (Configured with JDK 17)
flutter build apk --release

# 8. Build optimized Web bundle
flutter build web --release
```
