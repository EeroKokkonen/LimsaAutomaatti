import QtQuick 2.15

Rectangle {
    id: bg
    width: parent.width
    height: parent.height;
    x: 0;
    y: parent.y;
    Rectangle{
        id: animation;
        height: parent.height;
        width: parent.width;
        x: parent.x;
        y: parent.y;
        color: Qt.rgba(0.4, 0.2, 0.15, 0.3)
        visible: false;

        Behavior on y {
            PropertyAnimation {
                easing.type: Easing.InCurve;
                duration: 5000
            }
        }
        Behavior on height {
            PropertyAnimation {
                duration: 5000
            }
        }
    }

    gradient: Gradient {
            GradientStop { position: 0.0; color: "black"}
            GradientStop { position: 1.0; color: "gray"}
    }
    states: [
        State{
          name: "show"
          PropertyChanges{
              target:animation;
              visible: true;
          }
        },
        State{
          name: "hide"
          PropertyChanges{
              target:animation;

              visible: false;
          }
        },
        State {
            name: "effectOn"
            PropertyChanges {
                target: animation;
                focus: true;
                y: parent.height;
                visible: true;
            }

        },
        State {
            name: "effectOff"
            PropertyChanges {
                target: animation;
                y: parent.y;
                visible: true;
            }
        }
    ]


}
