import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import com.example 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Keyboard Input")

    TextArea {
        id: textArea
        anchors.fill: parent
        wrapMode: Text.Wrap
        focus: true
        Keys.onPressed: {
            KeyboardInputManager.keyPressed(event.text)
        }
    }

    Connections {
        target: KeyboardInputManager

        onKeyPressed: {
            textArea.text += key
        }
    }
}
