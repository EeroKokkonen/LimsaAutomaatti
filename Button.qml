import QtQuick 2.15

// Nappi
Rectangle {
    property string buttonText: ""
    property color backgroundColor: "lightgreen"

    signal buttonClicked;
    property var onRelease: function(){};
    property var onPress: function(){};

    color: backgroundColor
    width: 100
    height: 100
    radius: 100

    Text {
        text: parent.buttonText
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            parent.onPress()

        }
        onReleased: {


            parent.buttonClicked()
            parent.onRelease();
        }
    }
}
