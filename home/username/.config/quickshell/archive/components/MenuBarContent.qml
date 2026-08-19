// Importing the QtQuick module, which provides the `Item`, `Row`, and `Text` types
import QtQuick
// Importing the QtQuick Layouts module, which provides proportional row layout
import QtQuick.Layouts
// Importing QuickShell's Hyprland integration, which exposes the active toplevel window
import Quickshell.Hyprland

Item {
  id: content

  // Accepting the frame's gold colour as an external parameter, so the content tints itself to match whichever alternative hosts it
  property color accentColour: "#C8AA6E"
  // Accepting the frame's interior height, so text and icon sizes scale to whatever room the frame affords
  property int contentHeight: 28

  // Naming the three typefaces in one place, so a future Æcesuperāluese substitution touches only these three lines
  readonly property string displayFont: "Beaufort Pro"
  readonly property string textFont: "Kurinto Seri"
  readonly property string iconFont: "Symbols Nerd Font"

  RowLayout
  {
    id: row
    anchors.fill: parent
    anchors.leftMargin: 8
    anchors.rightMargin: 8
    spacing: 12

    // Region 1: the Piltovan equivalent of the Apple menu, a single display-weight glyph opening the system menu
    Text
    {
      id: systemMenuGlyph
      text: "\uf013"
      font.family: content.iconFont
      font.pixelSize: content.contentHeight * 0.6
      color: content.accentColour
      Layout.alignment: Qt.AlignVCenter

      MouseArea
      {
        anchors.fill: parent
        onClicked: console.log("Gerando o menu do sistema")
      }
    }

    // Region 2: the active application name, bound live to Hyprland, decorative only with no menu items
    Text
    {
      id: appName
      text: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : ""
      font.family: content.textFont
      font.pixelSize: content.contentHeight * 0.5
      color: content.accentColour
      elide: Text.ElideRight
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignVCenter
    }

    // Region 3: the network indicator, a placeholder icon pending NetworkManager integration
    Text
    {
      id: networkIcon
      text: "\uf1eb"
      font.family: content.iconFont
      font.pixelSize: content.contentHeight * 0.5
      color: content.accentColour
      Layout.alignment: Qt.AlignVCenter
    }

    // Region 4: the battery indicator, conditionally instantiated pending UPower integration
    Text
    {
      id: batteryIcon
      visible: false
      text: "\uf240"
      font.family: content.iconFont
      font.pixelSize: content.contentHeight * 0.5
      color: content.accentColour
      Layout.alignment: Qt.AlignVCenter
    }

    // Region 5: the launcher trigger, the Piltovan equivalent of Spotlight
    Text
    {
      id: spotlightIcon
      text: "\uf002"
      font.family: content.iconFont
      font.pixelSize: content.contentHeight * 0.5
      color: content.accentColour
      Layout.alignment: Qt.AlignVCenter

      MouseArea
      {
        anchors.fill: parent
        onClicked: console.log("Abrindo o lançador")
      }
    }

    // Region 6: the control centre trigger
    Text
    {
      id: controlCentreIcon
      text: "\uf013"
      font.family: content.iconFont
      font.pixelSize: content.contentHeight * 0.5
      color: content.accentColour
      Layout.alignment: Qt.AlignVCenter

      MouseArea
      {
        anchors.fill: parent
        onClicked: console.log("Abrindo a central de controlo")
      }
    }

    // Region 7: the notification centre trigger
    Text
    {
      id: notificationCentreIcon
      text: "\uf0f3"
      font.family: content.iconFont
      font.pixelSize: content.contentHeight * 0.5
      color: content.accentColour
      Layout.alignment: Qt.AlignVCenter

      MouseArea
      {
        anchors.fill: parent
        onClicked: console.log("Abrindo a central de notificações")
      }
    }

    // Region 8: the clock, showing both date and time, running text rather than an icon
    Text
    {
      id: clock
      text: Qt.formatDateTime(new Date(), "ddd d MMM  hh:mm")
      font.family: content.textFont
      font.pixelSize: content.contentHeight * 0.45
      color: content.accentColour
      Layout.alignment: Qt.AlignVCenter

      Timer
      {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd d MMM  hh:mm")
      }
    }
  }
}
