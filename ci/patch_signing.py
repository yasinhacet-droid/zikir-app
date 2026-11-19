"""Stellt die Release-Signatur im von `flutter create` erzeugten Gradle-File ein.

Erwartet die Umgebungsvariable UPLOAD_KEYSTORE_FILE (Pfad zum entschlüsselten Upload-Keystore).
"""
import os
import re
import sys
from pathlib import Path

kts = Path("android/app/build.gradle.kts")
groovy = Path("android/app/build.gradle")
keystore = os.environ["UPLOAD_KEYSTORE_FILE"]

if kts.exists():
    path = kts
    block = f'''    signingConfigs {{
        create("upload") {{
            storeFile = file("{keystore}")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }}
    }}

'''
    pattern = r'signingConfig\s*=\s*signingConfigs\.getByName\("debug"\)'
    replacement = 'signingConfig = signingConfigs.getByName("upload")'
elif groovy.exists():
    path = groovy
    block = f'''    signingConfigs {{
        upload {{
            storeFile file("{keystore}")
            storePassword "android"
            keyAlias "androiddebugkey"
            keyPassword "android"
        }}
    }}

'''
    pattern = r'signingConfig\s*=?\s*signingConfigs\.debug'
    replacement = 'signingConfig signingConfigs.upload'
else:
    sys.exit("Kein android/app/build.gradle(.kts) gefunden")

text = path.read_text()
new_text, count = re.subn(pattern, replacement, text)
if count == 0:
    print(text)
    sys.exit("Release-Signatur-Zeile nicht gefunden – Template hat sich geändert")

marker = "    buildTypes {"
if marker not in new_text:
    print(new_text)
    sys.exit("buildTypes-Block nicht gefunden")
new_text = new_text.replace(marker, block + marker, 1)
path.write_text(new_text)
print(f"Release-Signatur in {path} eingetragen ({count} Stelle).")
