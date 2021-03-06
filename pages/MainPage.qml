import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import "../components"

Item {
    id: wholePage

    onYChanged: {
        console.log("MainPage's y ch to " + y)
    }

    MouseArea {
        id: pageArea
        anchors.fill: parent
        onClicked: {
            pageArea.focus = true
        }

        TitleBar {
            id: titleBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            color: "#f6f5f1"

            title: "All Contacts"

            rightButtonIconSource: "qrc:///images/plus.png"
            onRightButtonClicked: pageStack.push("qrc:///pages/NewContactPage.qml")

        }
        Rectangle {
            id: searchBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: titleBar.bottom
            height: 43
            color: "#c9c9ce"


            Rectangle {
                id: searchFieldWrapper
                anchors.left: parent.left
                anchors.right: cancelLabel.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 8
                anchors.rightMargin: 10
                anchors.topMargin: 6
                anchors.bottomMargin: 8
                radius: 6
                color: "white"

                TextField {
                    id: searchField
                    anchors.fill: parent
                    anchors.leftMargin: 24

                    horizontalAlignment: Text.AlignLeft

                    style: TextFieldStyle {
                        background: Rectangle {
                            radius: 6
                        }
                    }

                    Image {
                        id: xbutton
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        anchors.verticalCenter: parent.verticalCenter
                        width: sourceSize.width / 2
                        height: sourceSize.height / 2
                        source: "qrc:///images/text-edit-x.png"
                        visible: searchField.text.length > 0

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                searchField.text = ""
                            }
                        }
                    }

                }

                Item {
                    id: searchTextPlaceholder
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.leftMargin: 8
                    anchors.topMargin: 4

                    width: childrenRect.width
                    height: glassIcon.height

                    Image {
                        id: glassIcon
                        width: sourceSize.width / 2
                        height: sourceSize.height / 2
                        source: "qrc:///images/magnifying-glass.png"
                    }

                    Label {
                        anchors.left: glassIcon.right
                        anchors.leftMargin: 8
                        anchors.verticalCenter: glassIcon.verticalCenter
                        text: "Search"
                        color: "#8e8e93"
                        font.pixelSize: 14
                        visible: searchField.text.trim().length === 0
                    }
                }

            }

            DimmableTextButton {
                id: cancelLabel

                anchors.left: parent.right
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                clip: true
                font.family: "Helvetica Neue"
                font.pointSize: 18
                color: "#0079ff"
                dimmingColor: "#c9c9ce"
                text: "Cancel"
                onClicked: {
                    // better than changing state as clicked will care about everything related to focus change
                    pageArea.clicked(null)
                }
            }

            Rectangle {
                id: underline
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: "#bfbfc1"
            }


        }
        Item {
            id: contactList
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: searchBar.bottom
            anchors.bottom: parent.bottom
    //        color: "white"
        }

        states: [
            State {
                name: "searchBarActive"
                when: searchField.activeFocus
                AnchorChanges {
                    target: titleBar
                    anchors.top: pageArea.top
                    anchors.bottom: pageArea.top
                }
                AnchorChanges {
                    target: searchTextPlaceholder
                    anchors.horizontalCenter: undefined
                    anchors.left: searchFieldWrapper.left
                }
                AnchorChanges {
                    target: cancelLabel
                    anchors.left: undefined
                }
                PropertyChanges {
                    target: cancelLabel
                    width: cancelLabel.implicitWidth
                }
            },
            State {
                name: ""
                StateChangeScript {
                    script: {
                        Qt.inputMethod.hide()
                    }
                }
            }

        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                AnchorAnimation { duration: 200; easing.type: Easing.InOutQuad }
            }
        ]

    }

    Component.onCompleted: {
        console.log("MainPage completed. Platform OS is " + Qt.platform.os)
    }

}
