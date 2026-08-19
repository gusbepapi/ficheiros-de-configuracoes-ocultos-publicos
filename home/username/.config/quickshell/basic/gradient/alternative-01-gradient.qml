// Importing the Quickshell core module, which provides the `PanelWindow` type
import Quickshell
// Importing the QtQuick module, which provides the `Rectangle` and `Text` types
import QtQuick
// Importing Qt5Compat.GraphicalEffects for OpacityMask
import Qt5Compat.GraphicalEffects

PanelWindow {
  id: panel

  // Defining the palette and geometry as tunable properties
  readonly property color bodyColour: "#1A1A1A"
  readonly property color goldColour: "#C8AA6E"
  readonly property int borderWidth: 2
  readonly property int barHeight: 50
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

    // Pass 1: The solid black body, drawn normally and excluded from the gradient
    Rectangle {
      id: body
      antialiasing: true
      anchors.fill: parent
      color: panel.bodyColour
      radius: 0
      border.color: "transparent"
      border.width: 0

      Text {
        anchors.centerIn: parent
        text: "Olá, Piltover"
        color: panel.goldColour
        font.pixelSize: 14
      }
    }

    // Pass 2: All gold outlines, white-stroked, used only as the mask
    Item {
      id: goldStrokes
      anchors.fill: parent
      visible: false
      layer.enabled: true

      // Outer body border
      Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "white"
        border.width: panel.borderWidth
        radius: 0
      }

      // Corner brackets (white)
      component WhiteCornerBracket: Item {
        property int arm: panel.bracketArm
        property int thickness: panel.bracketThickness

        width: arm
        height: arm

        Rectangle {
          width: arm
          height: thickness
          color: "white"
        }

        Rectangle {
          width: thickness
          height: arm
          color: "white"
        }
      }

      // Top-left bracket
      WhiteCornerBracket {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: panel.borderWidth
        anchors.leftMargin: panel.borderWidth
      }

      // Top-right bracket
      WhiteCornerBracket {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: panel.borderWidth
        anchors.rightMargin: panel.borderWidth
        rotation: 90
      }

      // Bottom-right bracket
      WhiteCornerBracket {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: panel.borderWidth
        anchors.rightMargin: panel.borderWidth
        rotation: 180
      }

      // Bottom-left bracket
      WhiteCornerBracket {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: panel.borderWidth
        anchors.leftMargin: panel.borderWidth
        rotation: 270
      }
    }

    // The single gradient, spanning the whole bar, also hidden
    Rectangle {
      id: goldGradient
      anchors.fill: parent
      visible: false
      gradient: Gradient {
        GradientStop { position: 0.0; color: "#f2e3ad" }
        GradientStop { position: 1.0; color: "#8a6a30" }
      }
    }

    // Pass 3: Showing the gradient only where the gold strokes are
    OpacityMask {
      anchors.fill: parent
      source: goldGradient
      maskSource: goldStrokes
    }
  }
}