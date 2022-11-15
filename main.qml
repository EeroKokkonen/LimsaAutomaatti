import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Limsa automaatti")

    ProductMenu{
        width: parent.width - 100;
        height: parent.height - 100;
        x: 50
        y: 50
        pathList: ["kokis.png","fanta.png","sprite.png","pepsi.png",
            "kokis.png","fanta.png","sprite.png", "pepsi.png"];
    }
    BackgroundAnimation{
        id: bg;
        visible: true;
        anchors.fill: parent;
        z: -200;
    }
}
