/**
  串口设置界面
**/
import QtQuick 2.15
import QtQuick.Controls 2.15
import FluentUI
import QtSerialPort 2.15

Rectangle {
    color: "#f0f0f0" // #f0f0f0

    // 1、设备状态界面标题logo和文本
    Rectangle {
        id:rectangleRUD
        width: parent.width
        height: 140
        color: "#f0f0f0"// #f0f0f0
        // 1.1 logo部分
        Rectangle{
            id:rectangleRUDLogo
            width: parent.width
            color: "transparent"
            height: 50
            anchors.left:parent.left
            anchors.top: parent.top
            Text {
                id:textAnalog
                text: "串口设置"
                font.pixelSize: 29
                color: "#1B1B1B"
            }
        }
        // 1.2 图片部分
        Rectangle{
            id:recImage
            width: 148
            color: "transparent" // #f0f0f0
            height: 90
            anchors.left:rectangleRUD.left
            anchors.bottom: rectangleRUD.bottom
            Image {
                id:picLogo
                source: "qrc:/images/AnalogLogo.png"
                width: 148
                height: 83
                fillMode: Image.PreserveAspectFit  // 保持图片的比例
                anchors.right:recImage.right
            }
        }
        // 1.3 文字部分
        Rectangle{
            id:recText
            width: 200
            color: "transparent"
            height: 90
            anchors.left:recImage.right
            anchors.bottom: rectangleRUD.bottom
            Row {
                id:rowRUD
                anchors.left:recText.left
                anchors.top:recText.top
                anchors.topMargin: 15
                spacing: 5

                Text {
                    id:textRDU
                    text: "RDU远程显示单元"
                    font.pixelSize: 17
                    color: "#1B1B1B"
                }

                Text {
                    id:textCGN
                    text: "中广核久源（成都）科技有限公司"
                    anchors.top: textRDU.bottom
                    anchors.left: textRDU.left
                    font.pixelSize: 13
                    color: "#1A1A1A"
                }

                Text {
                    id:textName
                    text: "重命名"
                    anchors.top: textCGN.bottom
                    anchors.left: textRDU.left
                    font.pixelSize: 14
                    color: "#003E92"
                }
            }
        }
    }

    // 2、串口设置
    Rectangle{
        id:portChoose
        width:495
        anchors.top: rectangleRUD.bottom
        anchors.topMargin: 4
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent" // #FBFBFB
        radius: 9  // 圆角半径为9
        height: 105
        // 2.1 文本部分
        Rectangle{
            id:recOutputText
            width: parent.width
            height: 45
            color: "transparent" // 透明色
            anchors.top: parent.top
            // 第一行文本
            Row {
                id:recOutputTextRow1
                anchors.left:recOutputText.left
                // anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 10
                spacing: 5

                Text {
                    id:recOutputTextRow1TextLeft
                    text: "串口设置"
                    font.pixelSize: 14
                    color: "#000000"
                    anchors.bottom: recOutputTextRow1.bottom
                }
            }

        }
        // 2.3 下拉框+打开按钮
        Rectangle {
            anchors.top: recOutputText.bottom
            width: parent.width
            height: 69
            radius: 9
            Row {
                id:rowRepeater
                anchors.fill: parent
                spacing: 10

                FluComboBox{ // 下拉框
                    id:rowRepeaterComboBoxComboBox
                    width: (parent.width/3)*2
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    editable: false
                    model: portModel
                }

                FluToggleButton { // 开关按钮
                       id: toggleButton
                       text: serialPortHandler.isSerialPortOpen ? "关闭串口" : "打开串口" // 根据串口状态更新按钮文字
                       anchors.right: parent.right
                       anchors.rightMargin: 30
                       anchors.verticalCenter: parent.verticalCenter
                       onClicked: {
                           if (serialPortHandler.isSerialPortOpen) {
                               serialPortHandler.closeSerialPort()
                           } else {
                               serialPortHandler.openSerialPort(rowRepeaterComboBoxComboBox.currentText)
                           }
                       }
                   }
            }

        }

    }

    // 3、串口数据
    Rectangle{
        id:portReceive
        width:495
        anchors.top: portChoose.bottom
        anchors.topMargin: 28
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent" // #FBFBFB
        radius: 9  // 圆角半径为9
        height: parent.height-portChoose.height-rectangleRUD.height-70
        // 2.1 文本部分
        Rectangle{
            id:recOutputTextReceive
            width: parent.width
            height: 45
            color: "transparent" // 透明色
            anchors.top: parent.top
            // 第一行文本
            Row {
                id:recOutputTextReceiveRow1
                anchors.left:recOutputTextReceive.left
                // anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 10
                spacing: 5

                Text {
                    id:recOutputTextReceiveRow1Left
                    text: "串口数据"
                    font.pixelSize: 14
                    color: "#000000"
                    anchors.bottom: recOutputTextReceiveRow1.bottom
                }
            }

        }
        // 2.2 矩形接收框
        Rectangle {
            id:receiveRectangle
            anchors.top: recOutputTextReceive.bottom
            width: parent.width
            height: parent.height-30
            color: "#FBFBFB" // transparent
            radius: 9
            // 2.2.1 多行输入文本框
            Rectangle{
                id:rectangleText
                width: parent.width
                height: parent.height-60
                anchors.bottom: rectangleBottom.top
                color: "transparent"
                Rectangle{
                    id:rectangleTextinside
                    anchors.centerIn: parent // 居中
                    width: parent.width-40
                    height:parent.height-20
                    color:"transparent"
                    border.color: "#E5E5E5"
                    border.width: 2

                    ScrollView {
                        anchors.fill: parent
                        TextEdit {
                            id:textEdit
                            //                             text: "这里是长文本...\n这里是第二行...\n继续第三行...\n这里是第四行...\n
                            //                                 还有更多行...这里是长文本...\n这里是第二行...\n继续第三行...\n这里是第四行...\n还有更多行...
                            // 还有更多行...这里是长文本...\n这里是第二行...\n继续第三行...\n这里是第四行...\n还有更多行...
                            // 还有更多行...这里是长文本...\n这里是第二行...\n继续第三行...\n这里是第四行...\n还有更多行..."
                            text: serialPortHandler.readData()
                            font.pixelSize: 20
                            wrapMode: TextEdit.Wrap
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            readOnly: true // 设置为false允许编辑文本
                        }
                    }
                }
            }
            // 2.2.2 已接收+已发送+清空按钮
            Rectangle{
                id:rectangleBottom
                width: parent.width
                height: 50
                anchors.bottom: receiveRectangle.bottom
                color: "transparent"

                Row{
                    id:receiveRectangleRow
                    anchors.fill: parent
                    spacing: 5

                    Text {
                        id:receiveRectangleRowText1
                        text: "已接收:"
                        font.pixelSize: 14
                        color: "#000000"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.top: parent.top
                        anchors.topMargin: 15
                    }

                    Text {
                        id:receiveRectangleRowText2
                        text: "已发送:"
                        font.pixelSize: 14
                        color: "#000000"
                        anchors.left: receiveRectangleRowText1.left
                        anchors.leftMargin: 150
                        anchors.top: parent.top
                        anchors.topMargin: 15
                    }

                    FluFilledButton{
                        text:"清空"
                        font.pixelSize: 14
                        anchors.left: receiveRectangleRowText2.left
                        anchors.leftMargin: 230
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        onClicked: {
                            textEdit.text = ""
                        }
                    }

                }

            }
        }

    }

    // 模型
    ListModel {
        id: portModel
    }

    // 获取串口信息
    Component.onCompleted: {
        var ports = serialPortHandler.getAvailablePorts();
        for (var i = 0; i < ports.length; i++) {
            portModel.append({"text": ports[i]});
        }
    }
}

// 注册 SerialPortHandler 到 QML

