'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "8ff7c4502a8a6aef33ca36fd259dcdcb",
"database/schema.sql": "6627bdb9693070014e2e30c22b87abda",
"database/seeds.sql": "88babd5011a892447a9933615d3834f1",
"database/README.md": "0b53100272a120d301348de0f3da3dcb",
"version.json": "5b13e1b1ab2139a56d0799e75b858702",
"index.html": "b6d378058658fc4229aff7afc28a8402",
"/": "b6d378058658fc4229aff7afc28a8402",
"frontend/run-android.sh": "df6e3f9fd7379ed67a04fc91f112edd3",
"frontend/macos/Runner.xcworkspace/contents.xcworkspacedata": "944eaa608d997672ac0dfcbfb00da3a3",
"frontend/macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"frontend/macos/RunnerTests/RunnerTests.swift": "97d3a20fd20a063c192e886d1822b4a8",
"frontend/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png": "8bf511604bc6ed0a6aeb380c5113fdcf",
"frontend/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png": "c9becc9105f8cabce934d20c7bfb6aac",
"frontend/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png": "dfe2c93d1536ae02f085cc63faa3430e",
"frontend/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png": "04e7b6ef05346c70b663ca1d97de3ad5",
"frontend/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png": "0ad44039155424738917502c69667699",
"frontend/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png": "3ded30823804caaa5ccc944067c54a36",
"frontend/macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json": "5bd47c3ef1d1a261037c87fb3ddb9cfd",
"frontend/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png": "8e0ae58e362a6636bdfccbc04da2c58c",
"frontend/macos/Runner/DebugProfile.entitlements": "6e164fc6ed6acb30c71fe12e29e49642",
"frontend/macos/Runner/Base.lproj/MainMenu.xib": "a41bc20792a7e771d7901124cdb8c835",
"frontend/macos/Runner/MainFlutterWindow.swift": "4a747b1f256d62a2bbb79bd976891eb5",
"frontend/macos/Runner/Configs/AppInfo.xcconfig": "2426af2c83d324d913686e2cf5fd8fda",
"frontend/macos/Runner/Configs/Debug.xcconfig": "763df8fe38448779b15dfa8244adcd95",
"frontend/macos/Runner/Configs/Release.xcconfig": "f78d2f57bc0b68e009ac727293534706",
"frontend/macos/Runner/Configs/Warnings.xcconfig": "e19c2368cf97e5f3eaf8de37cff2b341",
"frontend/macos/Runner/AppDelegate.swift": "2a7411ae3e7c6715525b94b6f8d2e80b",
"frontend/macos/Runner/Info.plist": "b945a5051bb1cca2d906ac0be98b629a",
"frontend/macos/Runner/Release.entitlements": "e6fde05dec64f9856d3978a4a5e4bf48",
"frontend/macos/Runner.xcodeproj/project.pbxproj": "f8583705158e51bec16f72b794817c49",
"frontend/macos/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"frontend/macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme": "bc68529ad752d3972dcb7810ad060146",
"frontend/macos/Flutter/Flutter-Debug.xcconfig": "5699404db81f3897cb3d40ce86ee8a1c",
"frontend/macos/Flutter/GeneratedPluginRegistrant.swift": "16e9397de01df036272e37d643c2ee7e",
"frontend/macos/Flutter/Flutter-Release.xcconfig": "d77c83fba1179be363f387359a9ed946",
"frontend/macos/Podfile": "dd2835afa466d6e23722980f1da0e88c",
"frontend/test/widget_test.dart": "fa35826ce8246ff963922e3c038ac776",
"frontend/web/index.html": "83b31dc0a0cd79d9966c98c7abef5998",
"frontend/web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"frontend/web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"frontend/web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"frontend/web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"frontend/web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"frontend/web/manifest.json": "28308bcdb31583badc8b2ebc2aefdec4",
"frontend/hot-reload-all.sh": "6d9abc683a6afb7586f228427367b329",
"frontend/ios/Runner.xcworkspace/contents.xcworkspacedata": "944eaa608d997672ac0dfcbfb00da3a3",
"frontend/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"frontend/ios/Runner.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings": "56b1e4b1f6b3b790f471044c301e69ea",
"frontend/ios/RunnerTests/RunnerTests.swift": "a225a382d14d7b16b6f602a5c1d49331",
"frontend/ios/Runner/Runner-Bridging-Header.h": "e07862ac930ed4d8479185d52c6cc66d",
"frontend/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png": "978c1bee49d7ad5fc1a4d81099b13e18",
"frontend/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png": "978c1bee49d7ad5fc1a4d81099b13e18",
"frontend/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md": "e175e436acacf76c814d83532d0b662c",
"frontend/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json": "770f4f65e02ca2fc57f46f4f4148d15d",
"frontend/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png": "978c1bee49d7ad5fc1a4d81099b13e18",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png": "643842917530acf4c5159ae851b0baf2",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png": "be8887071dd7ec39cb754d236aa9584f",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png": "2247a840b6ee72b8a069208af170e5b1",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png": "a2f8558fb1d42514111fbbb19fb67314",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png": "c785f8932297af4acd5f5ccb7630f01c",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png": "665cb5e3c5729da6d639d26eff47a503",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png": "1b3b1538136316263c7092951e923e9d",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json": "c3cdf9688b604d14f2e76a8287e16167",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png": "2247a840b6ee72b8a069208af170e5b1",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png": "2b1452c4c1bda6177b4fbbb832df217f",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png": "8245359312aea1b0d2412f79a07b0ca5",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png": "e419d22a37bc40ba185aca1acb6d4ac6",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png": "5b3c0902200ce596e9848f22e1f0fe0e",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png": "36c0d7a7132bdde18898ffdfcfcdc4d2",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png": "5b3c0902200ce596e9848f22e1f0fe0e",
"frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png": "043119ef4faa026ff82bd03f241e5338",
"frontend/ios/Runner/Base.lproj/LaunchScreen.storyboard": "89e8363b3b781ee4977c3c9422b88a37",
"frontend/ios/Runner/Base.lproj/Main.storyboard": "0e0faca0bc5766e8640496223a31706a",
"frontend/ios/Runner/AppDelegate.swift": "303ca46dbd58544be7b816861d70a27c",
"frontend/ios/Runner/Info.plist": "a1f0551ce02b95be0c3ae6878151df11",
"frontend/ios/Runner.xcodeproj/project.pbxproj": "6f63ac39f35f3a8631ec22b762714064",
"frontend/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata": "a54b6450d65c401d48911394f6a65bd2",
"frontend/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"frontend/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings": "56b1e4b1f6b3b790f471044c301e69ea",
"frontend/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme": "8908ab6700ba930c7dd60ea027f74eaa",
"frontend/ios/Flutter/Debug.xcconfig": "46d49915c32600030d79cd085ab92cf9",
"frontend/ios/Flutter/Release.xcconfig": "b60ff1c5444e52fc259cf0169dfbe87d",
"frontend/ios/Flutter/AppFrameworkInfo.plist": "3e84ffd77b8e1d46de0dec59f05dfec4",
"frontend/ios/Podfile": "4b6e6a073385fbc5cf2f2c70abc34cda",
"frontend/README.md": "38e28e21f678a856d687b1c93d3c3e2d",
"frontend/run-web.sh": "140faf490644b7dc9a0be42df6801fb5",
"frontend/run-ios.sh": "9c52937d61472dcfbf076191d62da930",
"frontend/pubspec.yaml": "53198075d0d52eca7b5d6bd9342d6cc1",
"frontend/linux/CMakeLists.txt": "4afd262edc82f76a888f53e3068e2084",
"frontend/linux/runner/main.cc": "0643b8609698e96b3abd63c210361a87",
"frontend/linux/runner/CMakeLists.txt": "6d75431dc21756981b53a7494c836311",
"frontend/linux/runner/my_application.h": "7bd839b67ebee22174be9f4da4521b6f",
"frontend/linux/runner/my_application.cc": "274269ffb24a5a53e7d80e0b5cdbfd92",
"frontend/linux/flutter/generated_plugin_registrant.cc": "d07afe003d5837167bdd357d593f20a0",
"frontend/linux/flutter/CMakeLists.txt": "46690fb8ffaf7d227d8bc4713f31140d",
"frontend/linux/flutter/generated_plugins.cmake": "e973b0a9c4bf1b7cba923da57b4fbf45",
"frontend/linux/flutter/generated_plugin_registrant.h": "d295462c9da9f7fef22dc86c34492318",
"frontend/android/app/build.gradle.kts": "9842fff978e87e1cfd60744c75d0730b",
"frontend/android/app/google-services.json": "87c1bc4baf9799cfc6419ebc13362951",
"frontend/android/app/src/profile/AndroidManifest.xml": "ac1dad6fec40014c3c6cbbd849a880dc",
"frontend/android/app/src/main/res/mipmap-mdpi/ic_launcher.png": "6270344430679711b81476e29878caa7",
"frontend/android/app/src/main/res/mipmap-hdpi/ic_launcher.png": "13e9c72ec37fac220397aa819fa1ef2d",
"frontend/android/app/src/main/res/drawable/launch_background.xml": "79c59c987bd2e693cd741ec3035ef383",
"frontend/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png": "57838d52c318faff743130c3fcfae0c6",
"frontend/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png": "afe1b655b9f32da22f9a4301bb8e6ba8",
"frontend/android/app/src/main/res/values-night/styles.xml": "feddd27a2f77ef486e2b7a420b1de43d",
"frontend/android/app/src/main/res/values/styles.xml": "58b48ec178bde5aad76063577172ad24",
"frontend/android/app/src/main/res/drawable-v21/launch_background.xml": "ab00f2bfdce1a5187d1ba31e9e68b921",
"frontend/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png": "a0a8db5985280b3679d99a820ae2db79",
"frontend/android/app/src/main/AndroidManifest.xml": "b05a16c34a0030b51a715fdaf1a1d568",
"frontend/android/app/src/main/kotlin/com/fantasyleague/fantasy_league/MainActivity.kt": "d0a327e82e6a8c86da58a0dd1d37bfe1",
"frontend/android/app/src/debug/AndroidManifest.xml": "ac1dad6fec40014c3c6cbbd849a880dc",
"frontend/android/gradle/wrapper/gradle-wrapper.properties": "2dd6a9f89c59b26c2da03cefe9fd7ae8",
"frontend/android/build.gradle.kts": "f11f360aed44d4f6871b398346af14f0",
"frontend/android/settings.gradle.kts": "16e2fa36a3875eb757511a8b0857c121",
"frontend/android/gradle.properties": "c19bdeb5872a06c05c5f9697f1e82954",
"frontend/lib/providers/scorebat_provider.dart.backup": "36300daad77c8666092411b6b92a5458",
"frontend/lib/models/scorebat_match.dart.backup": "bff17c33bd321cd17cddc61495b5f989",
"frontend/lib/screens/injured_the_week.dart": "94074c22dea22d8e286434c633fc6a33",
"frontend/lib/screens/game_the_week.dart": "11a3cc35a051f36914f4338ce29d9c6d",
"frontend/lib/screens/highlights_screen.dart": "e1c48c3585c134db1b68eb36f911ab8f",
"frontend/lib/screens/monte_league.dart": "1f68dd21608bc42f300f02964fd57476",
"frontend/lib/screens/home_screen.dart": "3fce29d8556561a308209ef1d0624bc2",
"frontend/lib/main.dart": "1bbec4bc8be8b70144c718cf50866f50",
"frontend/lib/theme/app_theme.dart": "abc936a18cfa7f4b202bed54c8e7b8b2",
"frontend/lib/app.dart": "a5029c4ca15f8da60e0bc6d0594d75ea",
"frontend/lib/widgets/scorebat_embed_widget.dart": "8d9de734106f4f8580f35b33d5f15214",
"frontend/lib/widgets/hero.dart": "24bb1e049bba7a1aa03dc3bbc4336cee",
"frontend/lib/widgets/scorebat_embed_widget_web.dart": "290c479b877a565003c30a8db02f5846",
"frontend/lib/widgets/custom_drawer.dart": "60ebb52633fbe9266c025c13e45e9d34",
"frontend/lib/widgets/campo.dart": "9f7fd39c163fe611deef05449a08d5b8",
"frontend/lib/widgets/scorebat_embed_widget_stub.dart": "bbcf13c19da53e8503062955a391a1a6",
"frontend/lib/widgets/highlights_widget.dart": "b18ba3f41353e12ce9188b31ccfc77c7",
"frontend/lib/widgets/campo_web.dart": "fb4ee9870e8b1ba36e734346231ac0f4",
"frontend/lib/widgets/buttom_home.dart": "85288caf538b59bb117000841e4a8ac8",
"frontend/lib/widgets/footer.dart": "9a0313b0d35de577642bc6c9f93917bc",
"frontend/lib/widgets/appbar.dart": "f6e682c24d04599b6c0386f8dfadf602",
"frontend/analysis_options.yaml": "66d03d7647c8e438164feaf5b922d44a",
"frontend/build/web/flutter_bootstrap.js": "cecc1a1d92f79e2fd3a2fc6c8bc9d962",
"frontend/build/web/version.json": "5b13e1b1ab2139a56d0799e75b858702",
"frontend/build/web/index.html": "b6d378058658fc4229aff7afc28a8402",
"frontend/build/web/main.dart.js": "c07da22519141e6ea669750dd29f2660",
"frontend/build/web/flutter.js": "888483df48293866f9f41d3d9274a779",
"frontend/build/web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"frontend/build/web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"frontend/build/web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"frontend/build/web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"frontend/build/web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"frontend/build/web/manifest.json": "28308bcdb31583badc8b2ebc2aefdec4",
"frontend/build/web/assets/AssetManifest.json": "6f3dec751c73cedc42a1892beadd9255",
"frontend/build/web/assets/NOTICES": "1603ec6cdc3583a36bded15e4f2d67f3",
"frontend/build/web/assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"frontend/build/web/assets/AssetManifest.bin.json": "61081cd38b5e6df19b9b752767627c57",
"frontend/build/web/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"frontend/build/web/assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"frontend/build/web/assets/AssetManifest.bin": "1314cce5b455d32a8b1f44bec544aaa0",
"frontend/build/web/assets/fonts/MaterialIcons-Regular.otf": "17587c1f1e78eda476494c78d82ed946",
"frontend/build/web/assets/assets/imagem2.jpg": "0c22ba380f61302ffb4f56b43ab142bf",
"frontend/build/web/assets/assets/shirt_white.svg": "b5632217e6f589bcb13f36d2c261fd33",
"frontend/build/web/assets/assets/imagem1.jpg": "f0e66be41c63b32dacc748d26edab565",
"frontend/build/web/assets/assets/shirt_selected.svg": "1bc7d9145abf269b970eb2b8e624321a",
"frontend/build/web/assets/assets/pitch_texture.jpg": "d41d8cd98f00b204e9800998ecf8427e",
"frontend/build/web/assets/assets/logo3.png": "0f712d5854c5966640a4ebc6b6e5c0bf",
"frontend/build/web/assets/assets/logo.png": "e4c35790cd60ad9d38fa953d56bccc95",
"frontend/build/web/assets/assets/logo2.png": "32cbf53b78ef4d44720a4059a1d9a2b6",
"frontend/build/web/canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"frontend/build/web/canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"frontend/build/web/canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"frontend/build/web/canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"frontend/build/web/canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"frontend/build/web/canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"frontend/build/web/canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"frontend/build/web/canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"frontend/build/web/canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"frontend/build/web/canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"frontend/build/web/canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"frontend/build/web/canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"frontend/start-all-3.sh": "bf37b2a031d34f75f08dd5bbfc63a230",
"frontend/assets/imagem2.jpg": "0c22ba380f61302ffb4f56b43ab142bf",
"frontend/assets/shirt_white.svg": "b5632217e6f589bcb13f36d2c261fd33",
"frontend/assets/imagem1.jpg": "f0e66be41c63b32dacc748d26edab565",
"frontend/assets/hero.png": "c382dad9f7881013218b47a3a0b038d8",
"frontend/assets/shirt_selected.svg": "1bc7d9145abf269b970eb2b8e624321a",
"frontend/assets/pitch_texture.jpg": "d41d8cd98f00b204e9800998ecf8427e",
"frontend/assets/logo3.png": "0f712d5854c5966640a4ebc6b6e5c0bf",
"frontend/assets/logo.png": "e4c35790cd60ad9d38fa953d56bccc95",
"frontend/assets/logo2.png": "32cbf53b78ef4d44720a4059a1d9a2b6",
"frontend/run-all-devices.sh": "888f6f1d414f54d125f97ec58ecf1a5c",
"SCOREBAT_INTEGRATION_REPORT.md": "52640265c735a496e42bae72334f3d1c",
"main.dart.js": "c07da22519141e6ea669750dd29f2660",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"RELATORIO_MONTE_LIGA.md": "e48053641a0a05474d635da0af66c9b8",
"backend/config/database.php": "0984a7eb841d1b673ed8ef7959d114d8",
"backend/config/cors.php": "8e30dc9f008a28e050f75f9af50ae7eb",
"backend/utils/Response.php": "233c352bfa8d8ae798f0e81d8db6906d",
"backend/models/User.php": "dc4173270229f1627bb86ab46aa7fc67",
"backend/README.md": "4ffddb916d95e5165a40060d44943367",
"backend/api/index.php": "1f518f1b8a065543973bd314de341a2b",
"backend/controllers/AuthController.php": "aa00b75d659e69da018f065f8370baa0",
"README.md": "12106ebf38c3bb78aa20bb94d6d44809",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"start-devices.sh": "50744e4b027df0cb78be1264e5a1bc79",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "28308bcdb31583badc8b2ebc2aefdec4",
"deploy_web.sh": "773258dc2b5a44ae789b29ae5f9ffe05",
".git/ORIG_HEAD": "d96fce1bb4d2fb42a8b1959897b24e9f",
".git/config": "7be64f22af61aebef179611d2739922e",
".git/objects/61/0db1ab246295c6a28de55710cc5968bd21da4c": "d7f5823385cc8f1ff2e98b77e49c9935",
".git/objects/0d/1333ae7fa15e9e55d226030e5eff4e7cbf115b": "bbe83853a2dd709cd285bb578447502c",
".git/objects/9b/3ef5f169177a64f91eafe11e52b58c60db3df2": "91d370e4f73d42e0a622f3e44af9e7b1",
".git/objects/9e/3b4630b3b8461ff43c272714e00bb47942263e": "accf36d08c0545fa02199021e5902d52",
".git/objects/60/fbfca38957313faee3429ac50ca0e893734554": "ca4c24a00297de693af86140b8eb3469",
".git/objects/34/0ac0c4d868a024d632c752c99f99ca6b57d64c": "1c7303d51facb1bd5a2e6263939d304e",
".git/objects/33/d9ebb58ae0d8fe1706195c3c23705de6927e78": "6e087d5d30d7cea3ec3968615a82a21b",
".git/objects/05/3a4c2411b9f433d663bac51ced02a2462a80d7": "a158b9116c16c09dbd2768bce65510d7",
".git/objects/ad/974ec02ae5592206c9f0a5c23362b7aba4f84b": "baa4794777dd3d86b7bd1885985164b6",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/be/10de85f545e2065ffea51247bfb594a77744b6": "e03b83d8c099f0393c60767431158db4",
".git/objects/da/0d5aa44a8c93eda469f7a99ed8feac32d5b19d": "25d25e93b491abda0b2b909e7485f4d1",
".git/objects/a5/9fb8f0db3ca04c0223129aa993e077353b20c7": "af39879ae1916466e9017f90603f2540",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d8/8128adaad90d2fd7cdabe7b36eaaaed0d3a25b": "3d15963af0d77c1cd40702fb7c18fa93",
".git/objects/e5/6ddf26a01c6a6a89c6e9482f46f7222098d947": "26f3c4d84ec833ace971a9fcb999bb28",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/ca/3bba02c77c467ef18cffe2d4c857e003ad6d5d": "316e3d817e75cf7b1fd9b0226c088a43",
".git/objects/fe/3b987e61ed346808d9aa023ce3073530ad7426": "dc7db10bf25046b27091222383ede515",
".git/objects/ed/b55d4deb8363b6afa65df71d1f9fd8c7787f22": "886ebb77561ff26a755e09883903891d",
".git/objects/4e/b0c5d555395cef9c9ca5865c08dca9ea894e68": "25a713fe569de5ce72b6ad072884347f",
".git/objects/20/3a3ff5cc524ede7e585dff54454bd63a1b0f36": "4b23a88a964550066839c18c1b5c461e",
".git/objects/pack/pack-00cfde673c7dec8b8d379c01a491eb4db8878436.rev": "730f05c4b5bcad8591a54627d8223b90",
".git/objects/pack/pack-00cfde673c7dec8b8d379c01a491eb4db8878436.idx": "cb59b1f3105e668ffb7a501bd3ddac6a",
".git/objects/pack/pack-00cfde673c7dec8b8d379c01a491eb4db8878436.pack": "458ba1da6801b6cf761fee2cf88840a0",
".git/objects/29/f22f56f0c9903bf90b2a78ef505b36d89a9725": "e85914d97d264694217ae7558d414e81",
".git/objects/42/faeebba2bfb430d08121a1baf9ae7596b88ff8": "e4e8767323277443195e39d825854477",
".git/objects/1a/3fb3231c0019b864ba85333c03bf1ff52e8d7f": "a635ec896b9f8c65a642334bd7ba6097",
".git/objects/8a/dba50912a75c0106ce99270aec94c38ad3e696": "fb15e9a40e9e1d9297199df60054cd21",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/4c/1f456c2e2438f89bb995593d6e551f688bc933": "27faf78e44ca750260df2b05364fa392",
".git/objects/21/3af7988987fa3494563bea1c4054cf8bc28792": "60158c872ab68bb6eb1bdef50d3add73",
".git/objects/4d/bf9da7bcce5387354fe394985b98ebae39df43": "534c022f4a0845274cbd61ff6c9c9c33",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/54/407342956d723f74271f6a67c936103c810332": "eeba28ac0067e33416ff73e3158a85af",
".git/objects/98/0d49437042d93ffa850a60d02cef584a35a85c": "8e18e4c1b6c83800103ff097cc222444",
".git/objects/5b/dc2a47dc306491de7d871901b1b83be9627932": "0ed61988ef17c9857802e96fb497e119",
".git/objects/01/fa0e315d7028edb47eb2e154b914a32cfb57c8": "16f8bf4fedfddf04730320e18d5f03c7",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/a0/1957f5855f874bf4896c6ed4e2a56bfccdbac1": "39d9ccde2380b6fff8b01c5ea2ca93b7",
".git/objects/a7/87669fdc2b8ae5c4e696489e98432a86204697": "8e8f73d3f058d84869cc192f5a24852f",
".git/objects/b6/b8806f5f9d33389d53c2868e6ea1aca7445229": "b14016efdbcda10804235f3a45562bbf",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/c3/f9200407e04ba8843a01e9db2c8ff4f8989179": "d78507b4fdf94d7ef743293ccd7c860b",
".git/objects/c4/016f7d68c0d70816a0c784867168ffa8f419e1": "fdf8b8a8484741e7a3a558ed9d22f21d",
".git/objects/ea/df4f43783e7a1b297cbc43ff0b29d8fb8299d4": "054229b65efe7ecd5b2d236c53354e04",
".git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391": "c70c34cbeefd40e7c0149b7a0c2c64c2",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/f8/737cbff80e84339328b2fcfd46c251cd5b9347": "04ea5947f0d318115e26e0f3d15e589b",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4f/fbe6ec4693664cb4ff395edf3d949bd4607391": "2beb9ca6c799e0ff64e0ad79f9e55e69",
".git/objects/8c/a3368ba8d9a1a28cf01ec8232c4b290fd098f7": "234127a557e1d91f2755b44bb538f833",
".git/objects/78/b63137711e34ede4cc6188a58194f59865955b": "a9800862338cd1e6dadb85afdca7df8a",
".git/objects/78/c162dc3e6cb42bdb090376e63ba589720c9a23": "ec576d7d9fe68a9b21e24a9ad57f333e",
".git/objects/7a/6c1911dddaea52e2dbffc15e45e428ec9a9915": "f1dee6885dc6f71f357a8e825bda0286",
".git/objects/8e/7bab2dcec16f470216bf5234571ac8662c0f65": "6cfe788eb93f66fadbe28c266026ff95",
".git/objects/22/d54f54970fb13f9d6dc5e59369c7b1bd0fd679": "b8dc4bb984be7718cf771699f1ca4d4f",
".git/objects/25/c4b675f7b830cdf2ea4b3d69674ba3576eca22": "4c70f326404d46fc15608d713c6bdc23",
".git/HEAD": "f01ada5d23bdfc8d97a8a8b3d70490c2",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "a068b668216303357b4448421e7d2ffe",
".git/logs/refs/heads/dev": "d56b99f847006f9257c3dd4a635b872e",
".git/logs/refs/remotes/origin/dev": "32129b3a75a6e0962bee870e035a9490",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/dev": "1b19b017da30e0c15f813055bc7bb5d5",
".git/refs/remotes/origin/dev": "1b19b017da30e0c15f813055bc7bb5d5",
".git/index": "9bcd9983b6e2559385ab35c94ad5d670",
".git/COMMIT_EDITMSG": "053459faaaf4c74942ed029448ddeada",
".git/FETCH_HEAD": "18b83cde04f685cdf29d3052e6a8cabb",
"assets/AssetManifest.json": "6f3dec751c73cedc42a1892beadd9255",
"assets/NOTICES": "1603ec6cdc3583a36bded15e4f2d67f3",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "61081cd38b5e6df19b9b752767627c57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "1314cce5b455d32a8b1f44bec544aaa0",
"assets/fonts/MaterialIcons-Regular.otf": "17587c1f1e78eda476494c78d82ed946",
"assets/assets/imagem2.jpg": "0c22ba380f61302ffb4f56b43ab142bf",
"assets/assets/shirt_white.svg": "b5632217e6f589bcb13f36d2c261fd33",
"assets/assets/imagem1.jpg": "f0e66be41c63b32dacc748d26edab565",
"assets/assets/hero.png": "c382dad9f7881013218b47a3a0b038d8",
"assets/assets/shirt_selected.svg": "1bc7d9145abf269b970eb2b8e624321a",
"assets/assets/pitch_texture.jpg": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/logo3.png": "0f712d5854c5966640a4ebc6b6e5c0bf",
"assets/assets/logo.png": "e4c35790cd60ad9d38fa953d56bccc95",
"assets/assets/logo2.png": "32cbf53b78ef4d44720a4059a1d9a2b6",
"DEPLOY_VERCEL.md": "6b2d8307f4126f74e4881679b7e4e03a",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
