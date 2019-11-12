defmodule Rpi4UsbHid do
  @moduledoc """
  This is a proof-of-concept of using the USB-C port from the RPi 4 in Gadget mode (in this case for HID Keyboard emulation)
  """

  def setup do
    File.ln_s("/sys/kernel/config/usb_gadget/g1/functions/hid.usb0", "/sys/kernel/config/usb_gadget/g1/configs/c.1/hid.usb0")
    :os.cmd('ls /sys/class/udc > /sys/kernel/config/usb_gadget/g1/UDC')
  end

  def type_char_a do
    :os.cmd('printf "%b" "\\x00\\x00\\x04\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0')
    :os.cmd('printf "%b" "\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00" > /dev/hidg0')
  end
end
