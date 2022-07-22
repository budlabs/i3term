### sidopen

This script can be used to open *.sid* files (C64 music files).
With [sidplayfp] in a terminal using the C64 font and colors.
![sidplay](https://user-images.githubusercontent.com/2143465/180494442-8d05be72-7ece-4b72-ba9d-02096316c622.png)

```bash
#!/bin/bash

# aur/ttf-c64
# extra/libsidplayfp
i3term --instance sidplayfp          \
       --bg '#2E2C9B' --fg '#706DEB' \
       --font ' C64 Pro Mono'        \
       --geometry 56x16              \
  -- sidplayfp -q "$1"
```
