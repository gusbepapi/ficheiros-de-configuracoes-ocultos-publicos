// Importing the Quickshell core module, which provides the `PanelWindow` type
import Quickshell
// Importing the QtQuick module, which provides the `Text` type
import QtQuick

PanelWindow {
  id: panel

  // Defining the palette and geometry as tunable properties
  readonly property color bodyColour: "#1A1A1A"
  readonly property color goldColour: "#C8AA6E"
  readonly property color testColour: "#8F8269"
  readonly property int barHeight: 50
  readonly property int borderWidth: 2
  readonly property int bracketArm: 9
  readonly property int bracketThickness: 2
  readonly property int tabWidth: 4
  readonly property int tabHeight: 10
  
  // Reading the preview switch from the environment
  property bool preview: Quickshell.env("BAR_PREVIEW") === "1"
  // Holding the magnification used while previewing
  property real previewScale: 2.0
  // Resolving to the real scale, which is 1.0 whenever preview is off
  readonly property real effectiveScale: panel.preview ? panel.previewScale : 1.0

  // Docking the panel to the top, left, and right edges
  anchors {
    top: true
    left: true
    right: true
  }

  // Offsetting the panel from the screen edges
  margins {
    top: 12
    left: 12
    right: 12
  }

  // Growing the surface so the ornaments and the scaled preview are not clipped
  implicitHeight: panel.barHeight * panel.effectiveScale

  // Reserving the unscaled body extent, so windows tile correctly in production
  exclusiveZone: (2 + panel.barHeight) * panel.effectiveScale

  // Making the window transparent so that only the painted children are visible
  color: "transparent"

  // Staging the content at natural size, then scaling it uniformly from the top-left for previews
  Item {
    id: stage

    anchors.top: parent.top
    anchors.left: parent.left
    // Dividing by the scale so that, once scaled, the bar lands exactly on the screen edge
    width: parent.width / panel.effectiveScale
    height: 50

    transformOrigin: Item.TopLeft
    scale: panel.effectiveScale

    // Declaring the visible body of the bar as a separate rectangle
    Rectangle {
      id: body
      antialiasing: true

      // Filling the floating window with the bar body
      anchors.fill: parent
      color: panel.bodyColour

      // Keeping the corners sharp
      radius: 0

      // Drawing the first border as a gold outline around the body
      border.color: panel.goldColour
      border.width: panel.borderWidth

      // Defining a reusable L-shaped corner bracket as the second extra border
      component CornerBracket: Item {
        id: bracket

        // Sharing the panel geometry with every instance
        property int arm: panel.bracketArm
        property int thickness: panel.bracketThickness
        property color colour: panel.goldColour

        // Sizing the bounding box of the bracket to a square of the arm length
        width: arm
        height: arm

        // Drawing the horizontal arm of the L from the corner of the box
        Rectangle {
          width: bracket.arm
          height: bracket.thickness
          color: bracket.colour
        }

        // Drawing the vertical arm of the L from the corner of the box
        Rectangle {
          width: bracket.thickness
          height: bracket.arm
          color: bracket.colour
        }
      }

      // Placing the top-left bracket just inside the border, in its default orientation
      CornerBracket {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: panel.borderWidth
        anchors.leftMargin: panel.borderWidth
      }

      // Placing the top-right bracket, rotating it a quarter turn so the corner faces top-right
      CornerBracket {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: panel.borderWidth
        anchors.rightMargin: panel.borderWidth
        rotation: 90
      }

      // Placing the bottom-right bracket, rotating it a half turn so the corner faces bottom-right
      CornerBracket {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: panel.borderWidth
        anchors.rightMargin: panel.borderWidth
        rotation: 180
      }

      // Placing the bottom-left bracket, rotating it three-quarters of a turn so the corner faces bottom-left
      CornerBracket {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: panel.borderWidth
        anchors.leftMargin: panel.borderWidth
        rotation: 270
      }

      Text {
        // Centring the label within the bar body
        anchors.centerIn: parent
        text: "Olá, Piltover"
        color: panel.goldColour
        font.pixelSize: 14
      }
    }
  }
}