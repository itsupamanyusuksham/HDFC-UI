# HDFC Insurance Dashboard - Flutter UI

A pixel-perfect Flutter implementation of the HDFC Bank insurance dashboard, featuring Material 3 design with custom HDFC branding.

## 🎨 Features

- **Pixel-perfect UI** matching the reference design
- **Material 3** with custom HDFC theme
- **Responsive layout** - adapts to desktop/tablet/mobile
- **Reusable widgets** - clean, modular architecture
- **Category filtering** - filter policies by type
- **Dynamic status badges** - Active (green) / Due (yellow)
- **Indian currency formatting** - proper ₹ symbol and number formatting
- **Null safety** enabled

## 📁 Folder Structure

```
lib/
├── main.dart                    # App entry point
├── screens/
│   └── dashboard_screen.dart    # Main dashboard screen
├── widgets/
│   ├── custom_appbar.dart       # HDFC branded AppBar
│   ├── summary_card.dart        # Metric summary cards
│   ├── category_filter.dart     # Filter pill buttons
│   └── policy_card.dart         # Policy information cards
├── models/
│   └── policy_model.dart        # Policy data model
└── theme/
    └── app_theme.dart           # Theme configuration
```

## 🚀 How to Run

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation Steps

1. **Navigate to the project directory:**
   ```bash
   cd "/Users/sukshamupamanyu/Desktop/VS Code/user"
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

   For web:
   ```bash
   flutter run -d chrome
   ```

   For specific device:
   ```bash
   flutter devices  # List available devices
   flutter run -d <device-id>
   ```

## 🎯 Design Specifications

### Colors
- **Primary Blue**: `#2E5AAC` - HDFC brand color
- **Background Grey**: `#F3F4F6` - Page background
- **Status Active**: `#10B981` - Green for active policies
- **Status Due**: `#FBF24` - Yellow for due policies

### Typography
- **Font Family**: Poppins (via Google Fonts)
- **Welcome Text**: 28px, Bold
- **Card Titles**: 16px, Semi-bold
- **Body Text**: 13px, Regular

### Spacing System
- 4px, 8px, 12px, 16px, 20px, 24px, 32px

### Border Radius
- Small: 12px
- Medium: 16px
- Large: 20px
- Pill: 30px

## 📦 Dependencies

- **google_fonts** (^6.1.0) - Poppins font family
- **intl** (^0.19.0) - Indian currency formatting

## 🎨 Assets

The app uses a placeholder for the HDFC logo. To add the actual logo:

1. Create an `assets/images/` directory
2. Add your `hdfc_logo.png` file
3. Uncomment the assets section in `pubspec.yaml`
4. Update `custom_appbar.dart` to use the image asset

## 🔧 Customization

### Adding More Policies
Edit `lib/models/policy_model.dart` and add entries to `PolicyData.getSamplePolicies()`.

### Changing Theme Colors
Edit `lib/theme/app_theme.dart` to modify colors, spacing, or typography.

### Modifying Layout
- **Summary Cards**: Edit `lib/widgets/summary_card.dart`
- **Policy Cards**: Edit `lib/widgets/policy_card.dart`
- **Grid Layout**: Modify `_buildPolicyGrid()` in `dashboard_screen.dart`

## 📱 Responsive Design

The app automatically adapts:
- **Desktop/Tablet**: 3-column policy grid
- **Mobile**: 2-column policy grid
- **Summary cards**: Horizontally scrollable on all devices

## ✨ Key Components

### CustomAppBar
- HDFC logo with blue background
- Customer name and ID
- Avatar with initials
- Logout button

### SummaryCard
- Icon with background
- Title and value
- Optional subtitle
- Soft shadow and border

### CategoryFilter
- Pill-shaped buttons
- Active/inactive states
- Smooth selection animation

### PolicyCard
- Shield icon
- Status badge (Active/Due)
- Policy details
- Premium and sum insured
- Arrow indicator

## 🧪 Testing

The UI has been designed to match the reference image pixel-perfectly. Test on different screen sizes to verify responsiveness.

## 📝 Code Quality

- ✅ Null safety enabled
- ✅ No deprecated widgets
- ✅ Reusable components
- ✅ Clean architecture
- ✅ Commented code
- ✅ No hardcoded duplications

## 🐛 Troubleshooting

**Issue**: Fonts not loading
- **Solution**: Run `flutter pub get` and restart the app

**Issue**: Overflow errors
- **Solution**: The layout is responsive and should handle various screen sizes. If you encounter overflow, ensure you're testing on a reasonable screen size.

**Issue**: Colors don't match exactly
- **Solution**: Colors are defined in `app_theme.dart` and can be adjusted to match your exact requirements.

## 📄 License

This is a demonstration project for UI replication purposes.
# User_Dashboard
