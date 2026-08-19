// Importing the Quickshell core module, which provides the `PanelWindow` type and `Quickshell.env`
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
  readonly property int borderWidth: 2
  readonly property int strokeWidth: 2
  readonly property int barHeight: 50
  readonly property int topGap: 4 

  // Defining the pendant geometry
  readonly property int pendantDrop: 15
  readonly property int pendantClearance: 16

  // Defining the Eternalian ornament dimensions
  readonly property int scoopRadius: 8
  readonly property int ringRadius: 6
  readonly property int vCapWidth: 10
  readonly property int vCapLength: 24
  readonly property int hCapLength: 180
  readonly property int hCapHeight: 12

  // Nudging each ornament family into place — positive gaps push outward from the body
  property int ringGapX: -2
  property int ringGapY: -4
  property int vCapGap: -5
  property int vCapShift: 0
  property int hCapGap: -6
  property int hCapShift: 0

  // Padding the body inward from the surface, leaving room for the protruding ornaments
  readonly property int sideInset: 16
  readonly property int vPad: 16

  // Reading the preview switch from the environment, so it toggles without editing the file
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

  // Growing the surface so the top ornaments, the bottom pendant, and the scaled preview are not clipped
  implicitHeight: (panel.vPad + panel.barHeight + panel.pendantDrop + panel.pendantClearance) * panel.effectiveScale

  // Reserving to the body's bottom, so windows tile there while the pendant overspills below
  exclusiveZone: ((panel.preview ? 28 : 14) + panel.vPad + panel.barHeight) * panel.effectiveScale

  // Making the window transparent so that only the painted children are visible
  color: "transparent"

  // Defining a reusable rectangle whose four corners are scooped concave
  component ScoopedRect: Shape {
    id: sr

    property int scoop: panel.scoopRadius
    property color fill: "transparent"
    property color stroke: panel.goldColour
    property int strokeW: panel.borderWidth

    // Smoothing the curves through the curve renderer rather than multi-sampling
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

  // Defining a reusable hollow ring as a bordered circle
  component Ring: Rectangle {
    z: 1
    width: panel.ringRadius * 2
    height: panel.ringRadius * 2
    radius: panel.ringRadius
    color: "transparent"
    border.color: panel.goldColour
    border.width: panel.borderWidth
    antialiasing: true
  }

  // Defining a reusable hollow capsule as a bordered stadium, vertical or horizontal
  component Capsule: Rectangle {
    z: 1
    property bool vertical: true
    width: vertical ? panel.vCapWidth : panel.hCapLength
    height: vertical ? panel.vCapLength : panel.hCapHeight
    radius: (vertical ? panel.vCapWidth : panel.hCapHeight) / 2
    color: "transparent"
    border.color: panel.goldColour
    border.width: panel.borderWidth
    antialiasing: true
  }

  // Staging the content at natural size, then scaling it uniformly from the top-left for previews
  Item {
    id: stage

    anchors.top: parent.top
    anchors.left: parent.left
    // Dividing by the scale so that, once scaled, the bar lands exactly on the screen edge
    width: parent.width / panel.effectiveScale
    height: panel.vPad + panel.barHeight + panel.pendantDrop + panel.pendantClearance

    transformOrigin: Item.TopLeft
    scale: panel.effectiveScale

    // Drawing the filled scooped body, inset above for the top ornaments and below for the pendant
    ScoopedRect {
      id: body

      anchors.fill: parent
      anchors.topMargin: panel.vPad
      anchors.bottomMargin: panel.pendantDrop + panel.pendantClearance
      anchors.leftMargin: panel.sideInset
      anchors.rightMargin: panel.sideInset

      fill: panel.bodyColour

      Text {
        // Centring the label within the body
        anchors.centerIn: parent
        text: "Olá, Piltover"
        color: panel.goldColour
        font.pixelSize: 14
      }
    }

    // Placing a ring just outside each of the four corners
    Ring {
      anchors.right: body.left
      anchors.rightMargin: panel.ringGapX
      anchors.bottom: body.top
      anchors.bottomMargin: panel.ringGapY
    }

    Ring {
      anchors.left: body.right
      anchors.leftMargin: panel.ringGapX
      anchors.bottom: body.top
      anchors.bottomMargin: panel.ringGapY
    }

    Ring {
      anchors.right: body.left
      anchors.rightMargin: panel.ringGapX
      anchors.top: body.bottom
      anchors.topMargin: panel.ringGapY
    }

    Ring {
      anchors.left: body.right
      anchors.leftMargin: panel.ringGapX
      anchors.top: body.bottom
      anchors.topMargin: panel.ringGapY
    }

    // Placing a vertical capsule against the middle of each side
    Capsule {
      vertical: true
      anchors.right: body.left
      anchors.rightMargin: panel.vCapGap
      anchors.verticalCenter: body.verticalCenter
      anchors.verticalCenterOffset: panel.vCapShift
    }

    Capsule {
      vertical: true
      anchors.left: body.right
      anchors.leftMargin: panel.vCapGap
      anchors.verticalCenter: body.verticalCenter
      anchors.verticalCenterOffset: panel.vCapShift
    }

    // Placing a single horizontal capsule above the top edge, centred
    Capsule {
      vertical: false
      anchors.bottom: body.top
      anchors.bottomMargin: panel.hCapGap
      anchors.horizontalCenter: body.horizontalCenter
      anchors.horizontalCenterOffset: panel.hCapShift
    }

    // Declaring the pendant in the transparent region below the bar body, in place of the bottom capsule
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
