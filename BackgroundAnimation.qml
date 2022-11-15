import QtQuick 2.15

Rectangle {
    id: animation;
    width: parent.width
    height: parent.height;
    x: parent.x;
    y: parent.y;
    visible: false;

    Behavior on y {
        PropertyAnimation {
            easing.type: Easing.OutQuart;
            duration: 5000
        }
    }
    Behavior on height {
        PropertyAnimation {
            duration: 5000
        }
    }
    color: "#66d14f4f"


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
