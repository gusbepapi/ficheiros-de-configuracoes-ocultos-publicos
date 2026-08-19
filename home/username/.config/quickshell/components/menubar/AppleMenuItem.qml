// Importing the QtQuick module, which provides the `Rectangle`, `Text`, and `MouseArea` types
import QtQuick

// Presenting one selectable row within the Apple menu dropdown, highlighting on hover and emitting a signal on click
Rectangle {
  id: item

  // Accepting the label text and the gold colour from the dropdown
  property string label: ""
  property color accentColour: "#C8AA6E"
  // Reporting a click to the dropdown
  signal triggered

  width: parent ? parent.width : implicitWidth
  implicitWidth: rowLabel.implicitWidth + 24
  implicitHeight: 28

  // Highlighting the row faintly while hovered, leaving it transparent otherwise
  color: mouseArea.containsMouse ? Qt.rgba(item.accentColour.r, item.accentColour.g, item.accentColour.b, 0.18) : "transparent"

  Text {
    id: rowLabel
    anchors.left: parent.left
    anchors.leftMargin: 12
    anchors.verticalCenter: parent.verticalCenter
    text: item.label
    font.family: "Kurinto Seri"
    font.pixelSize: 13
    color: item.accentColour
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: item.triggered()
  }
}
