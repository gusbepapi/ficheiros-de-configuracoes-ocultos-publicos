// Importing the QtQuick module, which provides the `Item`, `Row`, and `Text` types
import QtQuick
// Importing the QtQuick Layouts module, which provides proportional row layout
import QtQuick.Layouts
// Importing QuickShell's core module, which provides `DesktopEntries`
import Quickshell
// Importing QuickShell's Hyprland integration, which exposes the toplevels and the workspaces
import Quickshell.Hyprland

import components

Item {
  id: content

  // Accepting the frame's gold colour as an external parameter, so the content tints itself to match whichever alternative hosts it
  property color accentColour: "#C8AA6E"
  // Accepting the frame's body colour, so a workspace number reverses legibly against a filled diamond
  property color bodyColour: "#1A1A1A"
  // Accepting the frame's interior height, so text and icon sizes scale to whatever room the frame affords
  property int contentHeight: 28

  // Naming the three typefaces in one place, so a future Æcesuperāluese substitution touches only these three lines
  readonly property string displayFont: "Beaufort Pro"
  readonly property string textFont: "Kurinto Seri"
  readonly property string iconFont: "Symbols Nerd Font"

  // Overriding selected names where an application's own desktop entry is cosmetically unsatisfactory
  readonly property var nameOverrides: ({
    "codium-insiders": "VSCodium Insiders",
    "firefox": "Firefox Stable",
    "kitty": "Kitty Terminal",
    "org.kde.dolphin": "Dolphin"
  })

  // Resolving a clean application name from a Hyprland toplevel, preferring an override, then the desktop entry, then the title
  function resolveAppName(toplevel)
  {
    // Reading the Wayland surface, which carries the stable application identifier
    const surface = toplevel ? toplevel.wayland : null

    if (surface === null || surface === undefined)
    {
      return ""
    }

    // Keying on the Wayland appId, the canonical identifier the desktop-entry registry expects
    const appId = surface.appId || ""

    // Preferring a manual override where one is declared for this appId
    if (content.nameOverrides[appId] !== undefined)
    {
      return content.nameOverrides[appId]
    }

    // Consulting the freedesktop desktop-entry registry, which names every installed application canonically
    const entry = DesktopEntries.byId(appId)

    if (entry)
    {
      return entry.name
    }

    // Falling back to the live title only when no desktop entry exists for this surface
    return surface.title || ""
  }

  RowLayout
  {
    id: row
    anchors.fill: parent
    anchors.leftMargin: 8
    anchors.rightMargin: 8
    spacing: 12

    // Region 1: the Piltovan equivalent of the Apple menu, a single display-weight glyph opening the system menu
    AppleMenu
    {
      accentColour: content.accentColour
      contentHeight: content.contentHeight
      dropdownVariant: 7
      dropdownPhase: "gradient"
      barBottomOffset: 48
      Layout.alignment: Qt.AlignVCenter
    }

    // Region 2: the Hyprland workspaces, each a numbered diamond, the focused one filled
    Row
    {
      id: workspaces
      spacing: 6
      Layout.alignment: Qt.AlignVCenter

      Repeater
      {
        // Sorting the workspaces by numeric identifier, since the model's native order follows creation rather than number
        model:
        {
          const list = Hyprland.workspaces ? Hyprland.workspaces.values.slice() : []
          return list.sort((a, b) => a.id - b.id)
        }

        delegate: Item
        {
          id: workspaceItem
          required property var modelData

          // Resolving whether this workspace is the focused one, by comparing against the focused workspace's identifier
          readonly property bool isFocused: Hyprland.focusedWorkspace
            ? modelData.id === Hyprland.focusedWorkspace.id
            : false

          // Sizing a square bounding box so the rotated diamond spans the content height
          implicitWidth: content.contentHeight * 0.72
          implicitHeight: content.contentHeight * 0.72

          // Drawing the diamond as a square rotated through forty-five degrees
          Rectangle
          {
            anchors.centerIn: parent
            // Setting the side length so the rotated diagonal equals the bounding box
            width: parent.height * 0.707
            height: width
            rotation: 45

            // Filling the diamond when focused, leaving the others hollow against the bar
            color: workspaceItem.isFocused ? content.accentColour : "transparent"
            border.color: content.accentColour
            border.width: 1
            antialiasing: true
          }

          // Labelling the diamond with its workspace number, kept upright over the rotated square
          Text
          {
            anchors.centerIn: parent
            text: workspaceItem.modelData.id
            font.family: content.textFont
            font.pixelSize: content.contentHeight * 0.34
            // Reversing the number's colour against the fill, so it stays legible whether the diamond is filled or hollow
            color: workspaceItem.isFocused ? content.bodyColour : content.accentColour
          }

          // Switching to this workspace by sending a Lua dispatch descriptor, the form the config layer evaluates
          MouseArea
          {
            anchors.fill: parent
            onClicked: Hyprland.dispatch('hl.dsp.focus({ workspace = "' + workspaceItem.modelData.id + '" })')
          }
        }
      }
    }

    // Region 3: the active application name, resolved to a clean name and decorative only with no menu items
    Text
    {
      id: appName
      text: content.resolveAppName(Hyprland.activeToplevel)
      font.family: content.textFont
      font.pixelSize: content.contentHeight * 0.5
      color: content.accentColour
      elide: Text.ElideRight
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignVCenter
    }

    // Region 4: the network indicator, a placeholder icon pending NetworkManager integration
    Text
    {
      id: networkIcon
      text: "\uf1eb"
      font.family: content.iconFont
      font.pixelSize: content.contentHeight * 0.5
      color: content.accentColour
      Layout.alignment: Qt.AlignVCenter
    }

    // Region 5: the battery indicator, conditionally instantiated pending UPower integration
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

    // Region 6: the launcher trigger, the Piltovan equivalent of Spotlight
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

    // Region 7: the control centre trigger
    Text
    {
      id: controlCentreIcon
      text: "\uf462"
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

    // Region 8: the notification centre trigger
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

    // Region 9: the clock, showing both date and time, running text rather than an icon
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
