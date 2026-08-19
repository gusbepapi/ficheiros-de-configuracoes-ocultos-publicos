// Importing the Quickshell core module, which provides the `PanelWindow` type
import Quickshell
// Importing the QtQuick module, which provides the `Rectangle` and `Text` types
import QtQuick
// Importing the QtQuick Shapes module, which provides the `Shape` and `ShapePath` types
import QtQuick.Shapes

import components

PanelWindow {
  id: panel

  // Defining the palette and geometry as tunable properties
  readonly property color bodyColour: "#1A1A1A"
  readonly property color goldColour: "#C8AA6E"
  readonly property color testColour: '#8F8269'
  readonly property int borderWidth: 2
  readonly property int strokeWidth: 2
  readonly property int barHeight: 50
  readonly property int topGap: 10

  readonly property int edgeMargin: 2
  readonly property int frameGap: 2
  readonly property int scoopRadius: 10

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

  // Reserving the unscaled bar height, so windows tile correctly in production
  exclusiveZone: ((panel.preview ? 0 : -10) + panel.barHeight) * panel.effectiveScale

  // Growing the surface so the ornaments and the scaled preview are not clipped
  implicitHeight: panel.barHeight * panel.effectiveScale

  // Making the window transparent so that only the painted children are visible
  color: "transparent"

  // Defining a reusable rectangle whose four corners are scooped concave
  component ScoopedRect: Shape {
    id: sr

    property int scoop: panel.scoopRadius
    property color fill: "transparent"
    property color stroke: panel.goldColour
    property int strokeW: panel.borderWidth

    antialiasing: true
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

    // Drawing the filled scooped body as the larger, outer shape
    ScoopedRect {
      id: body
      anchors.fill: parent
      anchors.margins: panel.edgeMargin
      fill: panel.bodyColour
    }

    // Drawing the pure rectangle as the smaller, transparent inner frame around the content
    Rectangle {
      id: innerFrame
      anchors.fill: body
      anchors.margins: panel.frameGap
      color: "transparent"
      radius: 0

      // Drawing the inner gold outline as the rectangle's own border
      border.color: panel.goldColour
      border.width: panel.borderWidth

      MenuBarContent {
        // Filling the scooped body; insetting by the scoop radius so no content enters the concave corners
        anchors.fill: parent
        anchors.leftMargin: panel.scoopRadius
        anchors.rightMargin: panel.scoopRadius
        anchors.topMargin: panel.borderWidth + panel.frameGap
        anchors.bottomMargin: panel.borderWidth + panel.frameGap

        // Tinting the content with this frame's gold colour
        accentColour: panel.goldColour
        // Passing the free interior height, after the inner-frame inset on top and bottom
        contentHeight: panel.barHeight - 2 * panel.edgeMargin - 2 * (panel.borderWidth + panel.frameGap)
      }
    }
  }
}