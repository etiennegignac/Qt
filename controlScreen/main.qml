import QtQuick
import QtQuick.Controls
import QtQuick.Window

import fummins.libraries.Bridge 1.0 //Remember to copy the local QML library to the main Qt folder QML library (bug in QtCreator)

Window {
    width: 800
    height: 480
    visible: true
    color: "#f4d1d1d1"
    title: qsTr("Fummins Control Screen")

    // Do this when the window is loaded
    Component.onCompleted: {
       // switch (bridge.returnTCaseStatus());
    }

    Bridge {
        id: bridge
    }

    Label {
        id:driveLabel
        x: 0
        y: 13
        text: "2WD"
        font.pointSize: 50
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        color: "yellow"
        SequentialAnimation on opacity {

            id: driveLabelOpacityAnimation
            running: true
            loops: Animation.Infinite

            OpacityAnimator {
                target: driveLabel
                from: 0
                to: 1
                duration: 500
            }

            OpacityAnimator {
                target: driveLabel
                from: 1
                to: 0
                duration: 500
            }
        }
    }

    MouseArea {
        id: drvSeatMouseArea
        x: 100
        y: 130
        width: 180
        height: 220

        onClicked: {
            bridge.toggleDrvSeat()
            drvIconRect.color = bridge.returnDrvSeatStatusString()
        }

        Rectangle {
            id: drvIconRect
            anchors.fill: parent
            color: "darkgray"
        }

    }

    MouseArea {
        id: passSeatMouseArea
        x: 520
        y: 130
        width: 180
        height: 220

        onClicked: {
            bridge.togglePassSeat()
            passIconRect.color = bridge.returnPassSeatStatusString()
        }
        Rectangle {
            id: passIconRect
            anchors.fill: parent
            color: "darkgray"
        }

    }

    /*
    Button {
        id:drvSeatHeatButton
        text: bridge.returnDrvSeatStatusString()
        onClicked: {
            bridge.toggleDrvSeatHeat() // Update driver seat status
            text = bridge.returnDrvSeatStatusString() // Change button label to reflect new status
        }
    }*/
}
