# Appium Flutter Lab

Demo profesional en Flutter pensada para aprender y demostrar automatización E2E con Appium. El proyecto incluye una app con flujo completo (login → home → operaciones → transferencia → confirmación), keys estables y accessibility labels para localizar elementos en pruebas automatizadas.

## Objetivo del lab

Construir un entorno reproducible para:

- Practicar automatización mobile E2E en apps Flutter
- Mostrar buenas prácticas de estructura de código y testabilidad
- Documentar el proceso para GitHub y LinkedIn
- Usar el proyecto como referencia en entrevistas técnicas

## Stack

| Tecnología            | Uso                                           |
| --------------------- | --------------------------------------------- |
| Flutter 3.38.1        | App demo multiplataforma                      |
| FVM                   | Gestión de versión de Flutter                 |
| Appium 3              | Servidor de automatización mobile             |
| UiAutomator2          | Driver Appium para Android                    |
| XCUITest              | Driver Appium para iOS                        |
| Semantics / Accessibility | Labels estables expuestos a Appium        |
| WebdriverIO           | Cliente de pruebas E2E                        |
| Android Emulator / iOS Simulator | Dispositivos virtuales para pruebas |

## Appium Strategy

Se evaluó **Appium Flutter Driver** (conexión vía Dart Observatory / VM Service). La sesión podía establecerse, pero aparecieron incompatibilidades con comandos y finders del driver en Flutter 3.38+.

**Decisión:** usar **Appium + UiAutomator2 + Semantics/Accessibility**.

| Aspecto              | UiAutomator2 + Semantics                          |
| -------------------- | ------------------------------------------------- |
| Estabilidad          | Driver maduro, ampliamente usado en producción    |
| CI/CD                | Compatible con pipelines estándar de Android      |
| Dispositivos reales  | Funciona en emuladores y hardware físico          |
| Locators             | Accessibility id (`~login_email_input`)           |
| Requisito en Flutter | `Semantics(label: '...')` en widgets clave        |

Los widgets importantes exponen labels en `lib/core/constants/app_semantics.dart`. Las `ValueKey` de `app_keys.dart` se mantienen para widget tests de Flutter, pero **Appium estándar (UiAutomator2) localiza por accessibility id** (`~label`), no por `ValueKey`.

> **Importante:** No uses `enableFlutterDriverExtension()` en `main.dart` cuando automatizás con UiAutomator2. Esa extensión interfiere con la sincronización de texto en campos Flutter y rompe `setValue` / login.

> **Text fields en Flutter:** los wrappers `Semantics` no son nodos editables en Android. En los tests, hacé click en el accessibility id y escribí con `mobile: type` (Android) o `setValue` (iOS) — ver `e2e/utils/input.helper.js`.

## Estructura del proyecto

```
flutter_appium_lab/
├── README.md
├── .vscode/
│   └── launch.json               # Run / Debug desde Cursor
└── appium_flutter_demo/
    ├── lib/
    │   ├── main.dart             # Sin enableFlutterDriverExtension (UiAutomator2)
    │   ├── app/                  # Configuración global
    │   ├── core/                 # Widgets, keys y semantics
    │   └── features/             # Pantallas por feature
    └── e2e/
        ├── wdio.conf.js              # UiAutomator2 (Android)
        ├── wdio.ios.conf.js          # XCUITest (iOS)
        ├── utils/
        │   ├── screenshot.helper.js  # Capturas reutilizables
        │   └── input.helper.js       # Input multiplataforma
        ├── screenshots/              # Evidencia visual (generada en runtime)
        └── test/
            └── specs/
                └── login.e2e.js      # Test E2E compartido Android + iOS
```

## Usuario demo

| Campo    | Valor              |
| -------- | ------------------ |
| Email    | `demo@appium.com`  |
| Password | `123456`           |

## Flujo de la app

1. **Login** — Validación de credenciales demo
2. **Home** — Bienvenida y acceso a operaciones
3. **Lista de operaciones** — 3 items mockeados
4. **Detalle** — Información de la operación seleccionada
5. **Formulario de transferencia** — Nombre, monto y descripción
6. **Confirmación** — Resumen y vuelta al inicio

## Locators para Appium

**Accessibility labels** (UiAutomator2 — selector `~label`):

- `login_email_input`, `login_password_input`, `login_button`, `login_error_text`
- `home_title`, `home_items_button`

Definidos en `lib/core/constants/app_semantics.dart`.

**ValueKeys** (referencia / widget tests) en `lib/core/constants/app_keys.dart`:

- `home_items_button`, `items_list_title`, `item_card_1`, `item_card_2`, `item_card_3`
- `detail_title`, `detail_continue_button`
- `form_name_input`, `form_amount_input`, `form_description_input`, `form_submit_button`, `form_error_text`
- `confirmation_title`, `confirmation_summary`, `confirmation_back_home_button`

## Ejecutar la app

```bash
cd appium_flutter_demo
fvm flutter pub get
fvm flutter run
```

Desde Cursor/VS Code, usar **Run and Debug** con las configuraciones en `.vscode/launch.json`.

## Appium Setup

### Requisitos previos

| Herramienta           | Descripción                                   |
| --------------------- | --------------------------------------------- |
| **Appium 3**          | Servidor WebDriver                            |
| **UiAutomator2**      | Driver Android (incluido con Appium)          |
| **WebdriverIO**       | Cliente JS para tests E2E                     |
| **Android Emulator**  | Emulador con la app instalada                 |
| **Node.js 18+**       | Runtime para Appium y WebdriverIO             |

### 1. Instalar Appium y UiAutomator2

```bash
npm install -g appium
appium driver install uiautomator2
appium driver list --installed
```

### 2. Preparar el emulador Android

```bash
adb devices
```

### 3. Compilar el APK debug

```bash
cd appium_flutter_demo
fvm flutter clean
fvm flutter pub get
fvm flutter build apk --debug
```

**App ID:** `com.example.appium_flutter_demo`

### 4. Levantar Appium

En una terminal separada:

```bash
appium
```

Appium escucha por defecto en `http://127.0.0.1:4723`.

### Capabilities de referencia (UiAutomator2 + Android)

```javascript
{
  platformName: 'Android',
  'appium:automationName': 'UiAutomator2',
  'appium:deviceName': 'emulator-5554',
  'appium:platformVersion': '16',
  'appium:app': '../build/app/outputs/flutter-apk/app-debug.apk',
  'appium:noReset': false,
  'appium:fullReset': true,
}
```

### Localizar elementos

Usar accessibility id con el label definido en `Semantics`:

```javascript
const emailField = await $('~login_email_input');
await emailField.setValue('demo@appium.com');
```

## Running E2E Tests

Flujo completo para correr el test de login automatizado.

### Prerrequisitos

- Emulador Android iniciado (`adb devices` muestra `emulator-5554`)
- Appium 3 + driver `uiautomator2` instalados
- Dependencias E2E instaladas (`npm install` en `e2e/`)

### Pasos

**1. Compilar la app**

```bash
cd appium_flutter_demo
fvm flutter clean
fvm flutter pub get
fvm flutter build apk --debug
```

**2. Levantar Appium** (terminal separada)

```bash
appium
```

**3. Ejecutar el test de login**

```bash
cd appium_flutter_demo/e2e
npm install
npm run test:login
```

> `wdio.conf.js` usa `services: []` — Appium debe estar corriendo manualmente en el puerto 4723.

### Resultado esperado

El spec `test/specs/login.e2e.js` automatiza:

1. Abrir la app (instala el APK vía capabilities)
2. Capturar screenshot de la pantalla de login
3. Ingresar `demo@appium.com` / `123456`
4. Tocar **Ingresar**
5. Verificar que `home_title` esté visible en Home
6. Capturar screenshot de Home

## Screenshots automáticos

Los tests E2E generan evidencia visual del emulador Android durante la ejecución. Las capturas se guardan en `appium_flutter_demo/e2e/screenshots/` y son útiles para debugging local, pipelines CI/CD y reportes QA.

| Archivo | Cuándo se genera |
| ------- | ---------------- |
| `login-screen.png` | Al abrir la pantalla de login |
| `home-screen.png` | Tras un login exitoso |
| `login-failed-{timestamp}.png` | Si falla el test de login |
| `failed-{timestamp}.png` | Si falla cualquier test (hook global en `wdio.conf.js`) |

El helper `e2e/utils/screenshot.helper.js` centraliza la lógica con `browser.saveScreenshot()` y crea la carpeta automáticamente si no existe.

```javascript
const { takeScreenshot } = require('../../utils/screenshot.helper');

await takeScreenshot('login-screen');
```

Los archivos `.png` no se versionan en Git (ver `screenshots/.gitignore`); la carpeta se mantiene con `.gitkeep`.

### Notas de automatización

- Los tests E2E usan **Appium + UiAutomator2** con locators `~accessibility_id`.
- Los widgets deben exponer **`Semantics(label: ...)`** estables en `app_semantics.dart`.
- **`ValueKey`** sirve para widget tests; Appium estándar usa **accessibility id**.
- Para inputs Flutter, usar `input.helper.js`: click + `mobile: type` (Android) o `setValue` (iOS).

## Running E2E Tests — iOS (XCUITest)

Flujo para correr el mismo test de login en simulador iOS.

### Prerrequisitos

| Herramienta | Descripción |
| ----------- | ----------- |
| **Xcode** | Instalado con Command Line Tools |
| **Appium 3 + xcuitest** | `appium driver install xcuitest` |
| **Simulador iOS** | Mismo `deviceName` / `platformVersion` que `wdio.ios.conf.js` |
| **Runner.app** | Compilado para simulador |

### Setup Xcode (una sola vez)

```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license accept
```

Verificar simuladores disponibles (ajustar `platformVersion` en `wdio.ios.conf.js` si hace falta):

```bash
xcrun simctl list devices available
```

> **WebDriverAgent:** Appium compila e instala WDA automáticamente la primera vez vía el driver `xcuitest`. Ese paso puede tardar **5–10 minutos**; revisá los logs de Appium con `showXcodeLog: true`.

### Compilar la app iOS

Desde `e2e/`:

```bash
npm run ios:prepare
```

O manualmente:

```bash
cd appium_flutter_demo
fvm flutter clean
fvm flutter pub get
fvm flutter build ios --simulator
```

**Bundle ID:** `com.example.appiumFlutterDemo`

### Pasos para ejecutar

**Terminal 1 — Abrir Simulator** (dejá que termine de bootear antes del test):

```bash
open -a Simulator
```

**Terminal 2 — Appium:**

```bash
appium
```

**Terminal 3 — Test iOS:**

```bash
cd appium_flutter_demo/e2e
npm install
npm run test:login:ios
```

> `wdio.ios.conf.js` usa `services: []` — Appium debe estar corriendo en `http://localhost:4723`. El timeout de conexión es 10 min para tolerar la compilación inicial de WDA.

### Fast iOS Local Execution

Para acelerar el loop de desarrollo, `wdio.ios.conf.js` está optimizado para **reutilizar** el entorno local:

| Capability | Valor | Efecto |
| ---------- | ----- | ------ |
| `noReset` | `true` | No borra datos ni reinstala la app en cada sesión |
| `fullReset` | `false` | No desinstala la app ni reinicia el simulador |
| `useNewWDA` | `false` | Reutiliza WebDriverAgent ya compilado |
| `enforceAppInstall` | `false` | No fuerza reinstalación del `.app` |

**Flujo recomendado:**

1. Abrí Simulator **una vez** y dejalo abierto (`open -a Simulator`)
2. Levantá Appium **una vez** (`appium`)
3. Ejecutá `npm run test:login:ios` repetidamente — cada corrida debería ser mucho más rápida

| Ejecución | Tiempo esperado |
| --------- | --------------- |
| Primera (compila WDA) | 5–10 min |
| Siguientes (WDA + Simulator reutilizados) | ~15–30 s |

> Si cambiaste código Flutter, recompilá con `npm run ios:prepare` antes del test. Para un reset completo (reinstalar app + simulador limpio), cambiá temporalmente `fullReset: true` / `noReset: false` en `wdio.ios.conf.js`.

### Troubleshooting iOS

| Síntoma | Solución |
| ------- | -------- |
| `'18.0' does not exist in simctl SDKs` | Actualizar `platformVersion` en `wdio.ios.conf.js` al SDK instalado (`xcrun simctl list devices available`) |
| `timeout` al crear sesión (~2 min) | Abrí Simulator **antes** del test; la primera vez WDA tarda más — esperá hasta 10 min |
| Simulador se reinicia en cada test | Verificar `noReset: true` y `fullReset: false` en `wdio.ios.conf.js` |
| `failed to finish booting after 120s` | Dejá que el simulador termine de bootear; `simulatorStartupTimeout` está en 300 s |
| `Method is not implemented` en input | iOS no soporta `mobile: type`; el helper usa `setValue` automáticamente |
| WDA build falla | Verificar Xcode: `xcode-select -p` debe apuntar a `/Applications/Xcode.app/Contents/Developer` |

```bash
# Diagnóstico rápido
xcode-select -p
appium driver list --installed
xcrun simctl list devices available | grep Booted
ls ../build/ios/iphonesimulator/Runner.app
```

## Roadmap

1. ✅ Crear app Flutter demo
2. ✅ Agregar Appium (estructura E2E + login automatizado)
3. ✅ Migrar a UiAutomator2 + Semantics
4. ✅ Soporte iOS (XCUITest)
5. ⬜ Automatizar flujo completo
6. ⬜ Preparar publicación LinkedIn

## Licencia

Proyecto educativo — libre para usar como referencia y aprendizaje.
