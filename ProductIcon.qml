import QtQuick 2.15

Rectangle {
    id: test;
    width: 100;
    height: 100;
    property string imagePath;
    property int positionNumber: 0;
    property var onClick;
    property bool isOnClickDisabled: false;
    color: Qt.rgba(0,0,0,0);
    Image{
        width: parent.width;
        height: parent.height;
        source: parent.imagePath;
    }
    Behavior on scale {
        PropertyAnimation {
            duration: 500
        }
    }
    Behavior on x {
        PropertyAnimation {
            duration: 500
        }
    }
    Behavior on y {
        PropertyAnimation {
            duration: 500
        }
    }
    onFocusChanged: {

        if(focus){
        }
        else{
        }
    }
    MouseArea {
        anchors.fill: parent
        onPressed: {

        }
        onReleased: {
            if(positionNumber === 0 && !isOnClickDisabled)
                parent.onClick();
        }
    }

}
