# Rpi4UsbHid

This is a proof-of-concept of using the USB-C port from the RPi 4 in Gadget mode
(in this case for HID Keyboard emulation).

## How to run the Proof of Concept:

Set your environment for building the firmware for the RPi4:

```
export MIX_TARGET=rpi4
export MIX_ENV=prod

# WiFi credentials:
export NERVES_NETWORK_SSID='my-wifi-ssid'
export NERVES_NETWORK_PSK='my-wifi-passkey'
```

Install dependencies with `mix deps.get`, then create firmware with `mix
firmware` or directly burn to an SD card with `mix firmware.burn`.

Plug the RPi 4 USB-C port to a computer (it will have to supply enough current
to power the Pi, but it works on my laptop). After starting, the RPi will be
recognized as a USB Keyboard (HID device).

Connect via SSH to the RPi with `ssh nerves.local` and in the IEx console run
`Rpi4UsbHid.type_char_a()`. This will type the character `a` on the connected
computer, as if it was typed on a USB keyboard.

## Explanation:

This project enables USB-C Gadget mode on the Raspberry Pi 4:

  - A custom `fwup.conf` file (indicated in the config file `config/rpi4.exs`)
    adds `dwc2` support (look for lines containing `dwc2`) and loads a custom
    `config.txt`.
  - The custom `config.txt` enables USB gadget mode with `dwc2`.
  - A custom `erlinint.config` loads a custom script upon start. The script in
    turns creates the HID Gadget using ConfigFS.
  - The `Rpi4UsbHid.setup()` function, called upon application start, enables
    the HID gadget.
  - The `Rpi4UsbHid.type_char_a()` function sends HID reports emulating the
    press of the `a` key.
