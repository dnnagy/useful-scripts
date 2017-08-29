#setup path
cd $HOME
mkdir esp8266_dev
chmod 700 esp8266_dev
cd esp8266_dev

#clone Arduino library
git clone https://github.com/esp8266/Arduino.git esp8266

#export variable
export ESP_ROOT_DIR="$HOME/esp8266_dev/esp8266" && printf '\nexport ESP_ROOT_DIR="$HOME/esp8266_dev/esp8266"\n' >> $HOME/.bash_profile

#install required tools
cd $ESP_ROOT_DIR/tools && python get.py

#download third-party libraries
cd $ESP_ROOT_DIR/libraries
git clone https://github.com/me-no-dev/ESPAsyncTCP.git
git clone https://github.com/jarzebski/Arduino-MPU6050.git
git clone https://github.com/sparkfun/SparkFun_APDS-9960_Sensor_Arduino_Library.git
git clone https://github.com/tzapu/WiFiManager.git

#download the makefile
cd $HOME/esp8266_dev
git clone https://github.com/plerup/makeEspArduino.git

#download esptool.py
cd $HOME/esp8266_dev
git clone https://github.com/espressif/esptool.git

#create make and upload commands
printf '\n#Build esp8266 sketch with makefile\nespmake(){\n\tcd $1\n\tprintf "Will place binary to "$1/build"\"\n\trm -rf ./build\n\tmake -f $HOME/esp8266_dev/makeEspArduino/makeEspArduino.mk ESP_ROOT=$ESP_ROOT_DIR BUILD_DIR=./build\n}\n' >> $HOME/.bash_profile
printf '\n#Load a binary to the device using esptool.py\nespload(){\n\tpython $HOME/esp8266_dev/esptool/esptool.py -b $1 -p /dev/cu.SLAB_USBtoUART write_flash 0x0 $2 && screen /dev/cu.SLAB_USBtoUART $1\n}\n' >> $HOME/.bash_profile
#printf 'alias espload="python $HOME/esp8266_dev/esptool-master/esptool.py -b $1 -p /dev/cu.SLAB_USBtoUART write_flash 0x0 $2 && screen /dev/cu.SLAB_USBtoUART $1"' >> $HOME/.bash_profile

#make bash commands
printf 'alias serial="screen /dev/cu.SLAB_USBtoUART"' >> $HOME/.bash_profile
