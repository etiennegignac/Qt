# This Python file uses the following encoding: utf-8

# To be used on the @QmlElement decorator
# (QML_IMPORT_MINOR_VERSION is optional)
QML_IMPORT_NAME = "fummins.libraries.Bridge"
QML_IMPORT_MAJOR_VERSION = 1

import sys
# import RPi.GPIO as GPIO
from pathlib import Path

from PySide6.QtCore import QObject, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, QmlElement

# GLOBAL VARIABLES
drvSeatStatus = int(0) # 0 = off, 1 = A/C, 2 = Heat
passSeatStatus = int(0) # 0 = off, 1 = A/C, 2 = Heat

tcaseStatus = int(0) # 0 = UNKNOWN OR WORKING, 1 = 2WD, 2 = 4WD-High, 3 = 4WD-LOW

# Config
# GPIO.setmode(GPIO.BOARD) # Set pin numbering scheme to board numbering


# ----------------------------------- MODBUS ------------------------------------------------------------
# This Raspberry Pi is the Modbus MASTER (aka client?)
#











# BRIDGE CLASS TO COMMUNICATE BETWEEN PYTHON AND QML
@QmlElement
class Bridge(QObject):

    # Check with transfer case controller what the current status is
    @Slot()
    def returnTCaseStatus(result=int):
        #time.sleep(5)
        return 1
        #return tcaseStatus

    # Prints something to the console
    @Slot(str)
    def debug(self, s):
        print(s)

    # Returns value based on driver seat status
    @Slot(result=str)
    def returnDrvSeatStatusString(self):
        match drvSeatStatus:
            case 0: return "darkgray"
            case 1: return "blue"
            case 2: return "red"
            case _: return "yellow"

    # Returns value based on passenger seat status
    @Slot(result=str)
    def returnPassSeatStatusString(self):
        match passSeatStatus :
            case 0: return "darkgray"
            case 1: return "blue"
            case 2: return "red"
            case _: return "yellow"

    # Used clicked the driver seat
    @Slot()
    def toggleDrvSeat(self):
        global drvSeatStatus
        drvSeatStatus += 1
        if(drvSeatStatus == 3): drvSeatStatus = 0
        print("New value of drvSeatStatus is " + str(drvSeatStatus))

    # User clicked the passenger seat
    @Slot()
    def togglePassSeat(self):
        global passSeatStatus
        passSeatStatus += 1
        if(passSeatStatus == 3): passSeatStatus = 0
        print("New value of passSeatStatus is " + str(passSeatStatus))


# qmlRegisterType(Bridge, "fummins.libraries.Bridge", 1, 0, "Bridge")


# MAIN APPLICATION STARTS HERE
if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
