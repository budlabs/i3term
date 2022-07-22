### typisktstart

This is just a wrapper script around [typiskt]. It is
convenient to change properties in its own script.
![typiskt](https://user-images.githubusercontent.com/2143465/180494963-6053eddb-6bc8-4493-a75f-e64179344df0.png)

```bash
#!/bin/bash

# aur/ttf-go-mono-git
# aur/typiskt
i3term --font "Go Mono" --font-size "16" \
       --palette clrs-light              \
       --geometry 50x12                  \
  -- typiskt --corpus english --lines 3
```
