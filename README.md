# 🌟 InspireMe – Daily Motivation App

InspireMe is a beautifully designed Flutter application that delivers motivational quotes with animations, theme switching, sound effects, and favorite quote management. It's built using **Flutter** and **GetX** for clean state management and reactive UI.

---

## 🎯 Features

✅ **Random Quotes**  
✅ **Beautiful Day & Night Theme Switcher**  
✅ **Favorite Quotes** (with heart icon toggle)  
✅ **Local Persistence using SharedPreferences**  
✅ **Quote Sharing** (via share_plus)  
✅ **Smooth Quote Transition Animation**  
✅ **Sound Chime on Button Press**

---

## 🖥️ Screens

### 🏠 Home Screen
- Displays a beautifully styled motivational quote
- “Inspire Me” button fetches a new random quote
- Heart icon toggles favorite state
- Quote share button
- Day/Night theme toggle
- Subtle animation and chime sound

### ❤️ Favorites Screen
- Shows list of all favorited quotes
- Delete quotes from favorites

---

## 🛠️ Tech Stack

- **Flutter**
- **GetX** for state management
- **SharedPreferences** for local storage
- **audioplayers** for sound effects
- **share_plus** for quote sharing

---

## 📦 Packages Used

```yaml
get: ^4.6.5
shared_preferences: ^2.2.0
audioplayers: ^5.2.1
share_plus: ^7.2.1

Folder Structure
lib/
├── main.dart
├── controllers/
│   └── quote_controller.dart
├── models/
│   └── quote_model.dart
├── views/
│   ├── home_screen.dart
│   └── favorites_screen.dart
├── themes/
│   └── theme_controller.dart
├── data/
│   └── quotes.dart

How to run
git clone https://github.com/your-username/inspireme-app.git
cd inspireme-app
