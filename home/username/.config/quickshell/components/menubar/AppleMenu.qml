// Importing the QtQuick module, which provides the `Item`, `Text`, and `Column` types
import QtQuick
// Importing the QtQuick Layouts module, which provides `Layout` attached properties
import QtQuick.Layouts
// Importing the Quickshell core module, which provides `PopupWindow`, `Edges`, and `Quickshell.execDetached`
import Quickshell
// Importing the shared component module, which provides `AlternativeFrames`
import components

// Presenting the Piltovan gear, the equivalent of the Apple menu, which toggles a framed dropdown when clicked
Item {
  id: root

  // Accepting the bar's gold colour, so the glyph matches whichever alternative hosts the bar
  property color accentColour: "#C8AA6E"
  // Accepting the bar's interior height, so the glyph scales to the room the frame affords
  property int contentHeight: 28
  // Naming the icon typeface in one place
  property string iconFont: "Symbols Nerd Font"
  // Selecting which ornamental frame the dropdown wears, independently of the bar's own frame
  property int dropdownVariant: 1
  property string dropdownPhase: "gradient"
  // Holding the distance from the gear's bottom to the bar's outer bottom edge, plus the floating gap beneath the bar, set by the bar
  property int barBottomOffset: 24

  // Sizing the clickable region to the glyph
  implicitWidth: glyph.implicitWidth
  implicitHeight: glyph.implicitHeight

  Text {
    id: glyph
    anchors.centerIn: parent
    text: "\uf013"
    font.family: root.iconFont
    font.pixelSize: root.contentHeight * 0.6
    // Brightening the glyph while the dropdown is open, so the trigger reads as active
    color: dropdown.visible ? Qt.lighter(root.accentColour, 1.3) : root.accentColour
  }

  // Toggling the dropdown on click
  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: dropdown.visible = !dropdown.visible
  }

  // Dropping the framed menu from the bar's outer bottom edge, floating below it by the offset the bar supplies
  PopupWindow {
    id: dropdown
    visible: false
    color: "transparent"
    // Grabbing focus so a touch or click anywhere outside the popup dismisses it, the mechanism the dotfiles popups use
    grabFocus: true

    // Widening to the content plus interior insets, plus any side bands the frame reserves for flanking ornaments
    implicitWidth: 240 + 2 * frameBody.bodySideReserve
    // Heightening to the content plus interior insets, plus the bands reserved above and below the body for ornaments
    implicitHeight: menuColumn.implicitHeight + 2 * frameBody.interiorInset + frameBody.bodyTopReserve + frameBody.bodyBottomReserve

    anchor {
      item: root
      edges: Edges.Bottom
      // Pushing the popup down past the bar's lower edge, so it floats beneath the bar rather than hanging from the gear
      rect.y: root.barBottomOffset
    }

    // Wearing the chosen ornamental frame, sized to the popup rather than the bar
    AlternativeFrames {
      id: frameBody
      anchors.fill: parent
      variant: root.dropdownVariant
      phase: root.dropdownPhase

      // Stacking the menu rows within the frame's interior
      Column {
        id: menuColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        spacing: 0

        AppleMenuItem
        {
          label: "Sobre este sistema"
          accentColour: root.accentColour
          onTriggered:
          {
            dropdown.visible = false
            aboutWindow.show()
          }
        }

        AppleMenuItem
        {
          label: "Preferências do sistema…"
          accentColour: root.accentColour
          onTriggered:
          {
            dropdown.visible = false
            Quickshell.execDetached(["systemsettings"])
          }
        }

        AppleMenuItem
        {
          label: "Bloquear o ecrã"
          accentColour: root.accentColour
          onTriggered:
          {
            dropdown.visible = false
            Quickshell.execDetached(["hyprlock"])
          }
        }

        AppleMenuItem
        {
          label: "Suspender"
          accentColour: root.accentColour
          onTriggered:
          {
            dropdown.visible = false
            Quickshell.execDetached(["systemctl", "suspend"])
          }
        }

        AppleMenuItem
        {
          label: "Terminar sessão"
          accentColour: root.accentColour
          // Dispatching through the Lua descriptor the config layer expects
          onTriggered:
          {
            dropdown.visible = false
            Quickshell.execDetached(["hyprctl", "dispatch", "hl.dsp.exit()"])
          }
        }
      }
    }
  }

  // Holding the about-this-system window, opened by the first menu item
  AboutWindow {
    id: aboutWindow
  }
}
