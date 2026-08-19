// Importing the Quickshell core module, which provides the `PanelWindow` type
import Quickshell
// Importing the QtQuick module, which provides the `Rectangle` and `Text` types
import QtQuick
// Importing the QtQuick Shapes module, which provides the `Shape` and `ShapePath` types
import QtQuick.Shapes
// Importing the compatibility effects module, which provides `LinearGradient`
import Qt5Compat.GraphicalEffects

PanelWindow {
  id: panel

  // Defining the palette and geometry as tunable properties
  readonly property color bodyColour: "#1A1A1A"
  readonly property color goldColour: "#C8AA6E"
  readonly property color testColour: '#8F8269'
  readonly property int borderWidth: 2
  readonly property int strokeWidth: 2
  readonly property int barHeight: 50

  readonly property int edgeMargin: 2
  readonly property int frameGap: 2
  readonly property int scoopRadius: 10

  // Defining the two ends of the single vertical gold gradient
  readonly property color goldTop: "#E8D9A0"
  readonly property color goldBottom: "#9A7634"

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
    top: 10
    left: 12
    right: 12
  }

  // Growing the surface so the ornaments and the scaled preview are not clipped
  implicitHeight: panel.barHeight * panel.effectiveScale

  // Reserving only the height of the bar body, so windows tile correctly
  exclusiveZone: ((panel.preview ? 0 : -10) + panel.barHeight) * panel.effectiveScale

  // Making the window transparent so that only the painted children are visible
  color: "transparent"

  // Defining a reusable rectangle whose four corners are scooped concave, at the top level
  component ScoopedRect: Shape {
    id: sr

    property int scoop: panel.scoopRadius
    property color fill: "transparent"
    property color stroke: "white"
    property int strokeW: panel.borderWidth

    // antialiasing: true
    preferredRendererType: Shape.CurveRenderer

    ShapePath {
      fillColor: sr.fill
      strokeColor: sr.stroke
      strokeWidth: sr.strokeW
      capStyle: ShapePath.FlatCap
      joinStyle: ShapePath.MiterJoin

      startX: sr.scoop
      startY: 0
      // Running the top edge
      PathLine { x: sr.width - sr.scoop; y: 0 }
      // Scooping the top-right corner inward
      PathArc { x: sr.width; y: sr.scoop; radiusX: sr.scoop; radiusY: sr.scoop; direction: PathArc.Counterclockwise }
      // Running the right edge
      PathLine { x: sr.width; y: sr.height - sr.scoop }
      // Scooping the bottom-right corner inward
      PathArc { x: sr.width - sr.scoop; y: sr.height; radiusX: sr.scoop; radiusY: sr.scoop; direction: PathArc.Counterclockwise }
      // Running the bottom edge
      PathLine { x: sr.scoop; y: sr.height }
      // Scooping the bottom-left corner inward
      PathArc { x: 0; y: sr.height - sr.scoop; radiusX: sr.scoop; radiusY: sr.scoop; direction: PathArc.Counterclockwise }
      // Running the left edge
      PathLine { x: 0; y: sr.scoop }
      // Scooping the top-left corner inward
      PathArc { x: sr.scoop; y: 0; radiusX: sr.scoop; radiusY: sr.scoop; direction: PathArc.Counterclockwise }
    }
  }

  // Staging the content at natural size, then scaling it uniformly from the top-left for previews
  Item {
    id: stage

    anchors.top: parent.top
    anchors.left: parent.left
    // Dividing by the scale so that, once scaled, the bar lands exactly on the screen edge
    width: parent.width / panel.effectiveScale
    height: panel.barHeight

    transformOrigin: Item.TopLeft
    scale: panel.effectiveScale

    // Pass one — drawing the solid black body, inset by the outer margin plus the frame gap so it sits inside the outer frame
    Rectangle {
      id: body
      anchors.fill: parent
      anchors.margins: panel.edgeMargin + panel.frameGap
      color: panel.bodyColour
      radius: 0

      Text {
        // Centring the label within the bar body
        anchors.centerIn: parent
        text: "Olá, Piltover"
        color: panel.goldColour
        font.pixelSize: 14
      }
    }

    // Pass two — gathering every gold outline into one hidden mask, white
    Item {
      id: goldMask
      anchors.fill: parent
      visible: false

      // Masking the inner body border, at the same inset as the black body so the border lands on its edge
      Rectangle {
        id: maskBody
        anchors.fill: parent
        anchors.margins: panel.edgeMargin + panel.frameGap
        color: "transparent"
        border.color: "white"
        border.width: panel.borderWidth
        antialiasing: true
      }

      // Masking the outer scooped frame, inset by the outer margin alone so it stays larger than the body
      ScoopedRect {
        id: maskOuterFrame
        anchors.fill: parent
        anchors.margins: panel.edgeMargin
      }
    }

    // Pass three — showing one vertical gradient only where the gold mask is opaque
    LinearGradient {
      anchors.fill: goldMask
      source: goldMask

      start: Qt.point(0, 0)
      end: Qt.point(0, goldMask.height)

      gradient: Gradient {
        GradientStop { position: 0.0; color: panel.goldTop }
        GradientStop { position: 1.0; color: panel.goldBottom }
      }
    }
  }
}
