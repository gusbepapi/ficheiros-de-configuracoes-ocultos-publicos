// Importing the QtQuick module, which provides the `Text`, `Image`, and `Column` types
import QtQuick
// Importing the QtQuick Layouts module, which provides `RowLayout` and `ColumnLayout`
import QtQuick.Layouts
// Importing the QtQuick Window module, which provides the `Window.active` attached property
import QtQuick.Window
// Importing the Quickshell core module, which provides `FloatingWindow`
import Quickshell
// Importing the shared component module, which provides `AlternativeFrames` and `SystemInfo`
import components

// Presenting the about-this-system window, wearing the Eternalian frame, opened on demand from the Apple menu
FloatingWindow {
  id: root

  // Naming the window distinctively, so a Hyprland window rule can float it and strip its decoration
  title: "quickshell-about-this-system"
  implicitWidth: 560
  implicitHeight: 360
  visible: false
  // Showing the frame's gold against transparency, so the Eternalian ornaments read against the desktop
  color: "transparent"

  // The palette, matching the bar
  readonly property color accentColour: "#C8AA6E"
  readonly property color bodyColour: "#1A1A1A"

  // Opening the window, called from the Apple menu
  function show()
  {
    root.visible = true
  }

  // Dismissing on Control+W, Control+Q, or Escape
  Shortcut {
    sequences: ["Ctrl+W", "Ctrl+Q", "Escape"]
    onActivated: root.visible = false
  }

  // Watching the window's active state, dismissing when focus is lost, but never while the privileged serial prompt holds focus
  Item {
    id: focusWatcher

    readonly property bool windowActive: Window.active
    onWindowActiveChanged:
    {
      if (!focusWatcher.windowActive && !SystemInfo.serialPending)
      {
        root.visible = false
      }
    }
  }

  // Wearing alternative 08, the Art Deco Eternalian frame, around the whole window
  AlternativeFrames {
    anchors.fill: parent
    variant: 8
    phase: "gradient"

    // Laying out the overview: the distribution logo on the left, the identity and spec rows on the right
    RowLayout {
      anchors.fill: parent
      anchors.margins: 28
      spacing: 24

      // Showing the distribution logo, supplied by you as an asset or resolved from the icon theme
      Image {
        Layout.preferredWidth: 128
        Layout.preferredHeight: 128
        Layout.alignment: Qt.AlignTop
        source: SystemInfo.logoSource
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
      }

      // Stacking the identity and the spec rows
      ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 2

        // Naming the distribution prominently, by its NAME alone without codename or version
        Text {
          text: SystemInfo.distroName
          font.family: "Beaufort Pro"
          font.pixelSize: 22
          color: root.accentColour
          Layout.fillWidth: true
          elide: Text.ElideRight
        }

        // Versioning beneath the name, as the capitalised codename and number
        Text {
          text: SystemInfo.versionDisplay
          font.family: "Kurinto Seri"
          font.pixelSize: 13
          color: Qt.darker(root.accentColour, 1.2)
          visible: SystemInfo.versionDisplay.length > 0
        }

        Item { Layout.preferredHeight: 12 }

        // Listing the reliable fields now; the hardware rows await the fastfetch payload
        SpecRow {
          label: "Núcleo"
          value: SystemInfo.kernelRelease + (SystemInfo.kernelArch.length > 0 ? "  (" + SystemInfo.kernelArch + ")" : "")
        }

        SpecRow {
          label: "Número de série"
          // Hiding the serial behind a swatch, revealed on demand through a privileged prompt
          valueComponent: serialSwatch
        }

        Item { Layout.fillHeight: true }
      }
    }
  }

  // Hiding the serial number behind a gradient swatch, revealed on click through a privileged prompt, then shown as text
  Component {
    id: serialSwatch

    Item {
      implicitWidth: 140
      implicitHeight: 18

      // Showing the serial once it has been read
      Text {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: SystemInfo.serial.length > 0
        text: SystemInfo.serial
        font.family: "Kurinto Seri"
        font.pixelSize: 12
        color: root.accentColour
      }

      // Offering the redacted swatch until the serial is revealed
      Rectangle {
        anchors.fill: parent
        visible: SystemInfo.serial.length === 0
        radius: 2
        color: Qt.rgba(root.accentColour.r, root.accentColour.g, root.accentColour.b, 0.18)
        border.color: Qt.rgba(root.accentColour.r, root.accentColour.g, root.accentColour.b, 0.4)
        border.width: 1

        Text {
          anchors.centerIn: parent
          text: SystemInfo.serialPending ? "a autenticar…" : "mostrar"
          font.family: "Kurinto Seri"
          font.pixelSize: 11
          color: root.accentColour
        }

        MouseArea {
          anchors.fill: parent
          enabled: !SystemInfo.serialPending
          cursorShape: Qt.PointingHandCursor
          // Revealing the serial through the polkit prompt
          onClicked: SystemInfo.revealSerial()
        }
      }
    }
  }

  // Defining the reusable label-and-value row, after the dotfiles' pattern, with an optional custom value component
  component SpecRow: RowLayout {
    required property string label
    property alias value: valueText.text
    property Component valueComponent: null

    spacing: 8
    Layout.fillWidth: true
    Layout.topMargin: 1
    Layout.bottomMargin: 1

    Text {
      text: parent.label
      font.family: "Kurinto Seri"
      font.pixelSize: 12
      color: Qt.darker(root.accentColour, 1.3)
      Layout.preferredWidth: 150
      horizontalAlignment: Text.AlignRight
      verticalAlignment: Text.AlignVCenter
    }

    Text {
      id: valueText
      visible: !parent.valueComponent
      font.family: "Kurinto Seri"
      font.pixelSize: 12
      color: root.accentColour
      wrapMode: Text.WordWrap
      verticalAlignment: Text.AlignVCenter
      Layout.fillWidth: true
    }

    Loader {
      visible: !!parent.valueComponent
      Layout.fillWidth: true
      sourceComponent: parent.valueComponent
    }
  }
}
