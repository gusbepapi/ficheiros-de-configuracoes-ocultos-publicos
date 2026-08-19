// Importing the Quickshell core module, which provides the `PanelWindow` type
import Quickshell
// Importing the QtQuick module, which provides the `Rectangle` and `Text` types
import QtQuick
// Importing the QtQuick Shapes module, which provides the `Shape` and `ShapePath` types
import QtQuick.Shapes

PanelWindow {
  id: panel

  // Defining the palette and geometry as tunable properties
  readonly property color bodyColour: "#1A1A1A"
  readonly property color goldColour: "#C8AA6E"
  readonly property color testColour: "#8F8269"
  readonly property int borderWidth: 2
  readonly property int strokeWidth: 2
  readonly property int barHeight: 50
  readonly property int topGap: 16
  readonly property int pendantDrop: 15
  readonly property int pendantClearance: 16

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

  // Offsetting the panel from the screen edges so that it floats
  margins {
    top: panel.topGap
    left: 12
    right: 12
  }

  // Growing the surface so the ornaments and the scaled preview are not clipped
  implicitHeight: (panel.barHeight + panel.pendantDrop + panel.pendantClearance) * panel.effectiveScale

  // Reserving only the height of the bar body, so that the pendant is free to overspill below it
  exclusiveZone: (20 + panel.barHeight) * panel.effectiveScale

  // Making the window transparent so that only the painted children are visible
  color: "transparent"

  // Staging the content at natural size, then scaling it uniformly from the top-left for previews
  Item {
    id: stage

    anchors.top: parent.top
    anchors.left: parent.left
    // Dividing by the scale so that, once scaled, the bar lands exactly on the screen edge
    width: parent.width / panel.effectiveScale
    height: panel.barHeight + panel.pendantDrop + panel.pendantClearance

    transformOrigin: Item.TopLeft
    scale: panel.effectiveScale

    Rectangle {
      id: body
      antialiasing: true

      // Anchoring the bar body to the top of the surface and leaving the lower region transparent
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: panel.barHeight

      color: panel.bodyColour
      radius: 0

      // Drawing the gold border around the body
      border.color: panel.goldColour
      border.width: panel.borderWidth

      Text {
        // Centring the label within the bar body
        anchors.centerIn: parent
        text: "Olá, Piltover"
        color: panel.goldColour
        font.pixelSize: 14
      }
    }

    // Declaring the pendant in the transparent region below the bar body
    Shape {
      id: pendant
      preferredRendererType: Shape.CurveRenderer 
      antialiasing: true

      // Hanging the pendant from the centre of the bar's bottom edge
      anchors.horizontalCenter: body.horizontalCenter
      anchors.top: body.bottom

      // Defining the pendant geometry in local coordinates
      readonly property int shoulderY: 5
      readonly property int chamfer: 6
      readonly property int outerHalf: 100
      readonly property int outerNeck: 8
      readonly property int innerHalf: 20
      readonly property int innerTipY: 24

      // Sizing the shape from the outer half-width, so the chamfers are never clipped
      width: pendant.outerHalf * 2 + 14
      height: panel.pendantDrop + panel.pendantClearance
      readonly property real cx: width / 2

      // Drawing the outer chevron, with an angled end and a horizontal shoulder on each side
      ShapePath {
        strokeColor: panel.goldColour
        strokeWidth: panel.strokeWidth
        fillColor: "transparent"
        capStyle: ShapePath.FlatCap
        joinStyle: ShapePath.MiterJoin

        startX: pendant.cx - pendant.outerHalf
        startY: 0
        // Slanting the left end down to the shoulder
        PathLine { x: pendant.cx - pendant.outerHalf + pendant.chamfer; y: pendant.shoulderY }
        // Running the left shoulder inward
        PathLine { x: pendant.cx - pendant.outerNeck; y: pendant.shoulderY }
        // Descending to the outer tip
        PathLine { x: pendant.cx; y: panel.pendantDrop }
        // Ascending to the right shoulder
        PathLine { x: pendant.cx + pendant.outerNeck; y: pendant.shoulderY }
        // Running the right shoulder outward
        PathLine { x: pendant.cx + pendant.outerHalf - pendant.chamfer; y: pendant.shoulderY }
        // Slanting the right end up to the bar edge
        PathLine { x: pendant.cx + pendant.outerHalf; y: 0 }
      }

      // Drawing the inner chevron, attached to the bar edge and nested within the outer one
      ShapePath {
        strokeColor: panel.goldColour
        strokeWidth: panel.strokeWidth
        fillColor: "transparent"
        capStyle: ShapePath.FlatCap
        joinStyle: ShapePath.MiterJoin

        // Attaching the left arm to the bar's bottom edge
        startX: pendant.cx - pendant.innerHalf
        startY: 0
        // Descending to the inner tip
        PathLine { x: pendant.cx; y: pendant.innerTipY }
        // Ascending back to the bar's bottom edge
        PathLine { x: pendant.cx + pendant.innerHalf; y: 0 }
      }
    }
  }
}