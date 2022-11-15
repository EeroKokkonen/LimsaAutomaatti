import QtQuick 2.15

Rectangle {
    property list<string> pathList;
    property list<ProductIcon> productList;
    property int productSize: 100;
    property int circleRadius: (width / 3);
    color: Qt.rgba(0,0,0,0);

    Button{
        anchors.left: parent.left;
        anchors.verticalCenter: parent.verticalCenter;
        backgroundColor: "red"
        width: 20;
        height: 20;
        onButtonClicked: {
            parent.rotateMenu("left");
        }
    }
    Button{
        anchors.right: parent.right;
        anchors.verticalCenter: parent.verticalCenter;
        backgroundColor: "red"
        width: 20;
        height: 20;
        onButtonClicked: {
            parent.rotateMenu("right");
        }
    }

    function rotateMenu(direction){
        let positionChangeNmbr;
        if (direction === "left"){
            positionChangeNmbr = -1;
        }
        else if (direction === "right") {
            positionChangeNmbr = 1;
        }
        for(let i = 0; i < productList.length; i++){
            productList[i].positionNumber += positionChangeNmbr;

            if(productList[i].positionNumber === productList.length)
                productList[i].positionNumber = 0;

            else if(productList[i].positionNumber === -1)
                productList[i].positionNumber = productList.length - 1;

            changePosition(i);
        }
        changeFocus()
    }

    function changeFocus(){
        for(let i = 0; i < productList.length; i++) {

            if (productList[i].positionNumber === 0)
                productList[i].focus = true;
        }
    }

    function getPosition(_index) {
        let productAngleInCircle = (2 * Math.PI) / pathList.length * _index;
        let productCap = Math.sin(productAngleInCircle) * circleRadius;
        let xPos = productCap + (parent.x + (parent.width / 2) - (productSize / 2));
        let zPos = Math.cos(productAngleInCircle) * circleRadius;
        let yPos =  y + getScale(zPos) * (productSize /1.5);
        return [xPos, yPos ,zPos]
    }

    function changePosition(_index) {
        let [xPos, yPos, zPos] = getPosition(productList[_index].positionNumber);
        productList[_index].x = xPos;
        productList[_index].y = yPos;
        productList[_index].z = zPos;
        console.log(zPos)
        let scale = getScale(zPos);
        productList[_index].scale = scale;
    }

    function getScale(_zPos){
        return 1 +_zPos / circleRadius * 0.65;
    }

    function createProduct(_xPos, _yPos ,_zPos){
        let scale = getScale(_zPos);
        let index = productList.length ? productList.length : 0;

        let component = Qt.createComponent("ProductIcon.qml");
        let sprite = component.createObject(parent,{"x":_xPos, "y":_yPos, "imagePath":pathList[index],
                                                "width":productSize, "height":productSize, "scale":scale, "z":_zPos,
                                                "onClick": function(){
                                                    for(let i=0; i < productList.length; i++){
                                                        if (this !== productList[i])
                                                            productList[i].visible = false;
                                                        productList[i].isOnClickDisabled = true;
                                                    }
                                                    visible = false;
                                                    bg.state ="show"
                                                    let component = Qt.createComponent("Button.qml");
                                                    let sprite = component.createObject(parent,{"width": productSize, "height": productSize,
                                                                                            "x": parent.width / 2 + parent.x - productSize / 2,
                                                                                            "y": height - productSize / 3 / 2,
                                                                                            "buttonText": "Paina tästä",
                                                                                            "z": 0,
                                                                                            "color": "lightGreen",
                                                                                            "onRelease": function(){bg.state = "effectOff";console.log("Pois")},
                                                                                            "onPress": function(){bg.state = "effectOn"; console.log("Päällä")}
                                                                                        })
                                                    let sprite2 = component.createObject(parent,{"width": 59, "height": 50,
                                                                                            "anchors.left": left,
                                                                                             "anchors.top": top,
                                                                                            "buttonText": "Takaisin",
                                                                                            "color": "red",
                                                                                             "z": 0,
                                                                                             "onRelease": function(){
                                                                                                 sprite.visible = false;
                                                                                                 this.visible = false;
                                                                                                 for(let i=0; i < productList.length; i++){
                                                                                                     productList[i].visible = true;
                                                                                                     productList[i].isOnClickDisabled = false;
                                                                                                 }
                                                                                                 visible = true;
                                                                                                 bg.state ="hide"
                                                                                             },
                                                                                             "onPress": function(){bg.state = "effectOn"; console.log("Päällä")}
                                                                                         })
                                                    }});

        productList.push(sprite);
        productList[index].positionNumber = index;
    }

    // @disable-check M16
    Component.onCompleted: {
        for(let i = 0; i < pathList.length; i++) {

            let [xPos, yPos ,zPos] = getPosition(i)

            createProduct(xPos, yPos, zPos);
        }
        changeFocus();
    }
}
