// Importing the Quickshell core module, which provides the `PanelWindow` type and `Quickshell.env`
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

  // Defining the two ends of the single vertical gold gradient
  readonly property color goldTop: "#E8D9A0"
  readonly property color goldBottom: "#9A7634"

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
  exclusiveZone: (panel.topGap + panel.vPad + panel.barHeight) * panel.effectiveScale

  // Making the window transparent so that only the painted children are visible
  color: "transparent"

  // Defining a reusable rectangle whose four corners are scooped concave
  component ScoopedRect: Shape {
    id: sr

    property int scoop: panel.scoopRadius
    property color fill: "transparent"
    property color stroke: "white"
    property int strokeW: panel.borderWidth

    // Smoothing the curves through the curve renderer rather than multi-sampling
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

  // Defining a reusable hollow ring as a bordered circle, white for the mask
  component Ring: Rectangle {
    z: 1
    width: panel.ringRadius * 2
    height: panel.ringRadius * 2
    radius: panel.ringRadius
    color: "transparent"
    border.color: "white"
    border.width: panel.borderWidth
    antialiasing: true
  }

  // Defining a reusable hollow capsule as a bordered stadium, white for the mask
  component Capsule: Rectangle {
    z: 1
    property bool vertical: true
    width: vertical ? panel.vCapWidth : panel.hCapLength
    height: vertical ? panel.vCapLength : panel.hCapHeight
    radius: (vertical ? panel.vCapWidth : panel.hCapHeight) / 2
    color: "transparent"
    border.color: "white"
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

    // Pass one — filling the scooped body in body colour, with no stroke, since the border now comes from the gradient
    ScoopedRect {
      id: body

      anchors.fill: parent
      anchors.topMargin: panel.vPad
      anchors.bottomMargin: panel.pendantDrop + panel.pendantClearance
      anchors.leftMargin: panel.sideInset
      anchors.rightMargin: panel.sideInset

      fill: panel.bodyColour
      stroke: "transparent"

      Text {
        // Centring the label within the body
        anchors.centerIn: parent
        text: "Olá, Piltover"
        color: panel.goldColour
        font.pixelSize: 14
      }
    }

    // Pass two — gathering the body border, every ornament, and the pendant into one hidden mask, white
    Item {
      id: goldMask
      anchors.fill: parent
      visible: false

      // Masking the body border, at the same geometry as the filled body
      ScoopedRect {
        id: maskBody

        anchors.fill: parent
        anchors.topMargin: panel.vPad
        anchors.bottomMargin: panel.pendantDrop + panel.pendantClearance
        anchors.leftMargin: panel.sideInset
        anchors.rightMargin: panel.sideInset

        stroke: "white"
      }

      // Masking a ring just outside each of the four corners
      Ring {
        anchors.right: maskBody.left
        anchors.rightMargin: panel.ringGapX
        anchors.bottom: maskBody.top
        anchors.bottomMargin: panel.ringGapY
      }

      Ring {
        anchors.left: maskBody.right
        anchors.leftMargin: panel.ringGapX
        anchors.bottom: maskBody.top
        anchors.bottomMargin: panel.ringGapY
      }

      Ring {
        anchors.right: maskBody.left
        anchors.rightMargin: panel.ringGapX
        anchors.top: maskBody.bottom
        anchors.topMargin: panel.ringGapY
      }

      Ring {
        anchors.left: maskBody.right
        anchors.leftMargin: panel.ringGapX
        anchors.top: maskBody.bottom
        anchors.topMargin: panel.ringGapY
      }

      // Masking a vertical capsule against the middle of each side
      Capsule {
        vertical: true
        anchors.right: maskBody.left
        anchors.rightMargin: panel.vCapGap
        anchors.verticalCenter: maskBody.verticalCenter
        anchors.verticalCenterOffset: panel.vCapShift
      }

      Capsule {
        vertical: true
        anchors.left: maskBody.right
        anchors.leftMargin: panel.vCapGap
        anchors.verticalCenter: maskBody.verticalCenter
        anchors.verticalCenterOffset: panel.vCapShift
      }

      // Masking a single horizontal capsule above the top edge, centred
      Capsule {
        vertical: false
        anchors.bottom: maskBody.top
        anchors.bottomMargin: panel.hCapGap
        anchors.horizontalCenter: maskBody.horizontalCenter
        anchors.horizontalCenterOffset: panel.hCapShift
      }

      // Masking the pendant strokes, hanging from the centre of the body's bottom edge
      Shape {
        id: maskPendant
        preferredRendererType: Shape.CurveRenderer
        antialiasing: true

        anchors.horizontalCenter: maskBody.horizontalCenter
        anchors.top: maskBody.bottom

        // Defining the pendant geometry in local coordinates
        readonly property int shoulderY: 5
        readonly property int chamfer: 6
        readonly property int outerHalf: 100
        readonly property int outerNeck: 8
        readonly property int innerHalf: 20
        readonly property int innerTipY: 24

        // Sizing the shape from the outer half-width, so the chamfers are never clipped
        width: maskPendant.outerHalf * 2 + 14
        height: panel.pendantDrop + panel.pendantClearance
        readonly property real cx: width / 2

        // Stroking the outer chevron, with an angled end and a horizontal shoulder on each side
        ShapePath {
          strokeColor: "white"
          strokeWidth: panel.strokeWidth
          fillColor: "transparent"
          capStyle: ShapePath.FlatCap
          joinStyle: ShapePath.MiterJoin

          startX: maskPendant.cx - maskPendant.outerHalf
          startY: 0
          PathLine { x: maskPendant.cx - maskPendant.outerHalf + maskPendant.chamfer; y: maskPendant.shoulderY }
          PathLine { x: maskPendant.cx - maskPendant.outerNeck; y: maskPendant.shoulderY }
          PathLine { x: maskPendant.cx; y: panel.pendantDrop }
          PathLine { x: maskPendant.cx + maskPendant.outerNeck; y: maskPendant.shoulderY }
          PathLine { x: maskPendant.cx + maskPendant.outerHalf - maskPendant.chamfer; y: maskPendant.shoulderY }
          PathLine { x: maskPendant.cx + maskPendant.outerHalf; y: 0 }
        }

        // Stroking the inner chevron, attached to the bar edge and nested within the outer one
        ShapePath {
          strokeColor: "white"
          strokeWidth: panel.strokeWidth
          fillColor: "transparent"
          capStyle: ShapePath.FlatCap
          joinStyle: ShapePath.MiterJoin

          startX: maskPendant.cx - maskPendant.innerHalf
          startY: 0
          PathLine { x: maskPendant.cx; y: maskPendant.innerTipY }
          PathLine { x: maskPendant.cx + maskPendant.innerHalf; y: 0 }
        }
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
