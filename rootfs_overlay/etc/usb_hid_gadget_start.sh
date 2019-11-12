modprobe dwc2
modprobe libcomposite

mount none /sys/kernel/config -t configfs

cd /sys/kernel/config/usb_gadget/
mkdir -p g1
cd g1
echo 0x1d6b > idVendor # 0x1d6b Linux Foundation
echo 0x0104 > idProduct # 0x0104 Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2
echo 0xEF > bDeviceClass
echo 0x02 > bDeviceSubClass
echo 0x01 > bDeviceProtocol
mkdir -p strings/0x409
echo "ef14df55db46849f" > strings/0x409/serialnumber
echo "Dummy Manufacturer" > strings/0x409/manufacturer
echo "Nerves RPi4 HID Device" > strings/0x409/product
mkdir -p configs/c.1/strings/0x409
echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower

mkdir -p functions/hid.usb0
echo 1 > functions/hid.usb0/protocol
echo 1 > functions/hid.usb0/subclass
echo 8 > functions/hid.usb0/report_length
printf "%b" "\\x05\\x01\\x09\\x06\\xa1\\x01\\x05\\x07\\x19\\xe0\\x29\\xe7\\x15\\x00\\x25\\x01\\x75\\x01\\x95\\x08\\x81\\x02\\x95\\x01\\x75\\x08\\x81\\x03\\x95\\x05\\x75\\x01\\x05\\x08\\x19\\x01\\x29\\x05\\x91\\x02\\x95\\x01\\x75\\x03\\x91\\x03\\x95\\x06\\x75\\x08\\x15\\x00\\x25\\x65\\x05\\x07\\x19\\x00\\x29\\x65\\x81\\x00\\xc0" > functions/hid.usb0/report_desc

# ln -s functions/hid.usb0 configs/c.1/
# File.ln_s("/sys/kernel/config/usb_gadget/g1/functions/hid.usb0", "/sys/kernel/config/usb_gadget/g1/configs/c.1/hid.usb0")
# End functions

# ls /sys/class/udc > UDC

# ls /sys/class/udc > /sys/kernel/config/usb_gadget/g1/UDC
