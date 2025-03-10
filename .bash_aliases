dlogs() {
    cid=$(docker ps -f "name=$1" -q)
    lines=${2:-500}
    docker logs ${cid} --tail ${lines} -f
}

dbash() {
    cid=$(docker ps -f "name=$1" -q)
    docker exec -ti ${cid} bash
}

soundConfigBluetooth() {
    pacmd set-default-sink 'alsa_output.usb-0b0e_Jabra_Link_380_08C8C25054F3-00.iec958-stereo'
    pacmd set-default-source 'alsa_input.usb-0b0e_Jabra_Link_380_08C8C25054F3-00.mono-fallback'
}

soundConfigLaptop() {
    pacmd set-default-sink 'alsa_output.pci-0000_00_1f.3.analog-stereo'
    pacmd set-default-source 'alsa_input.pci-0000_00_1f.3.analog-stereo'
}

restartUsb() {
    # USB 3.1 Only
    for port in $(lspci | grep xHCI | cut -d' ' -f1); do
        echo -n "0000:${port}"| sudo tee /sys/bus/pci/drivers/xhci_hcd/unbind;
        sleep 5;
        echo -n "0000:${port}" | sudo tee /sys/bus/pci/drivers/xhci_hcd/bind;
        sleep 5;
    done
    
    # All USB
    for port in $(lspci | grep USB | cut -d' ' -f1); do
        echo -n "0000:${port}"| sudo tee /sys/bus/pci/drivers/xhci_hcd/unbind;
        sleep 5;
        echo -n "0000:${port}" | sudo tee /sys/bus/pci/drivers/xhci_hcd/bind;
        sleep 5;
    done
}
