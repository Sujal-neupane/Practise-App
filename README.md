# Practise App

Flutter application structured according to the team's Clean Architecture standards (`common/` + `features/`).

---

## 📁 Project Structure

### `lib/common/`
Shared modules, configurations, and core utilities used across all features:
- `config/`: Environment and application configurations
- `constants/`: Global constants
- `cubit/`: Shared state cubits
- `http/`: Network clients and HTTP interceptors
- `logger/`: Logging utilities
- `model/`: Global models and DTOs
- `permissions/`: App permission handling
- `storage/`: Local storage / preferences
- `system_ui/`: System overlay and status bar styling
- `theme/`: Theme definitions and color palettes
- `utils/`: Helpers and formatters
- `widgets/`: Reusable cross-feature UI widgets
- `wrapper/`: Root wrappers and guards

### `lib/features/`
Feature-specific modules (each containing `bloc`, `constants`, `model`, `resource`, `service`, `ui`, and `utils`):
- `splash/`: Initial launch screen
- `onboard/`: Welcome & onboarding flow
