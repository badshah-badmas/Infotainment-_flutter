# Raspberry Pi IR Remote Setup with GPIO

This guide explains how to set up Raspberry Pi OS Lite, enable SSH, and configure an IR remote using `ir-keytable`.

---

## 1. Install Raspberry Pi OS Lite

1. Download and flash **Raspberry Pi OS Lite** using [Raspberry Pi Imager](https://www.raspberrypi.com/software/).
2. Insert the SD card into your Raspberry Pi.

---

## 2. Enable SSH and Set Up Your SSH Key

On your Raspberry Pi:

```bash
# Enable SSH
sudo systemctl enable ssh
sudo systemctl start ssh
```

Copy your system’s SSH key to the Raspberry Pi:

```bash
ssh-copy-id pi@<raspberry-pi-ip>
```

---

## 3. Configure IR Receiver

### Enable GPIO IR Overlay

Edit `/boot/config.txt`:

```bash
dtoverlay=gpio-ir,gpio_pin=17
```

Reboot your Raspberry Pi:

```bash
sudo reboot
```

---

## 4. Install Required Packages

Update your system and install `ir-keytable`:

```bash
sudo apt update
sudo apt install ir-keytable

sudo ir-keytable -p nec,rc-5,rc-6
```

---

## 5. Create Custom Keymap

Create a keymap file:

```bash
sudo nano /etc/rc_keymaps/withHard.toml
```

Paste the following:

```toml
[[protocols]]
name = "myremote"
protocol = "nec"

[protocols.scancodes]
0x8001 = "KEY_PLAYPAUSE"
0x8002 = "KEY_PREVIOUS"
0x8003 = "KEY_NEXT"
0x801e = "KEY_MUTE"
0x8012 = "KEY_POWER"
0x8005 = "KEY_VOLUMEDOWN"
0x8006 = "KEY_VOLUMEUP"
0x801a = "KEY_MODE"
```

---

## 6. Load Keymap

Write the keymap:

```bash
sudo ir-keytable -w /etc/rc_keymaps/withHard.toml
```

Update keymap configuration:

```bash
sudo nano /etc/rc_maps.cfg
```

Add the line:

```
*       /etc/rc_keymaps/withHard.toml
```

---

## 7. Create Udev Rule for Auto-Loading

Create a udev rule file:

```bash
sudo nano /etc/udev/rules.d/99-com.rules
```

Add:

```
ACTION=="add", SUBSYSTEM=="rc", DRIVERS=="gpio_ir_recv", RUN+="/usr/bin/ir-keytable -w /etc/rc_keymaps/withHard.toml"
```

Reload udev rules:

```bash
sudo udevadm control --reload-rules
```

---

## 8. Reboot and Test

```bash
sudo reboot
```

Test your remote:

```bash
ir-keytable -t
```

You should see button presses mapped to your defined keys.

---

### Notes

- Make sure your IR receiver is connected to **GPIO 17**.
- If the keymap doesn’t load at boot, double-check `/etc/rc_maps.cfg` and udev rules.

install Flutter-pi

Install cmake, graphics, system libraries and fonts:

sudo apt install cmake libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev libdrm-dev libgbm-dev ttf-mscorefonts-installer fontconfig libsystemd-dev libinput-dev libudev-dev libxkbcommon-dev

sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-alsa

sudo fc-cache

sudo apt -y install rpd-plym-splash // splash screen
