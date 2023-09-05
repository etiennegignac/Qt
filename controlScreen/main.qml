import QtQuick
import QtQuick.Controls
import QtQuick.Window

import fummins.libraries.Bridge 1.0 //Remember to copy the local QML library to the main Qt folder QML library (bug in QtCreator)

Window {
    id: mainWindow
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

    SwipeView {
        id: mainSwipeView
        anchors.fill: parent

        Item {
            id: mainPage
            anchors.fill: parent

            Image {
                id: drivetrainImage
                source: "res/drivetrain/2WD_200_250.png"
                x: (mainWindow.width - width)/2 //Centered
                y: 60
                width: 200
                height: 250

                SequentialAnimation on opacity {

                    id: drivetrainImageOpacityAnimation
                    running: true
                    loops: Animation.Infinite

                    OpacityAnimator {
                        target: drivetrainImage
                        from: 0
                        to: 1
                        duration: 500
                    }

                    OpacityAnimator {
                        target: drivetrainImage
                        from: 1
                        to: 0
                        duration: 500
                    }
                }

            }

            Label {
                id: airLabel
                y: 109
                text: "Air tank: --- psi"
                anchors.bottom: compressorLabel.top
                color: "#4b4b4b"
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                anchors.horizontalCenter: drivetrainImage.horizontalCenter
                font.pointSize: 19
            }
            Label {
                id: compressorLabel
                y: 109
                text: "Electric compressor: OFF"
                anchors.bottom: backBattVoltsLabel.top
                color: "#4b4b4b"
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                anchors.horizontalCenter: drivetrainImage.horizontalCenter
                font.pointSize: 19
            }

            Label {
                id: backBattVoltsLabel
                y: 185
                text: "House battery: --.- volts"
                anchors.bottom: parent.bottom
                color: "#4b4b4b"
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                anchors.bottomMargin: 10
                anchors.horizontalCenter: drivetrainImage.horizontalCenter
                font.pointSize: 19
            }

            MouseArea {
                id: drvSeatMouseArea
                x: 50
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
                x: 570
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
        }
    }
}
