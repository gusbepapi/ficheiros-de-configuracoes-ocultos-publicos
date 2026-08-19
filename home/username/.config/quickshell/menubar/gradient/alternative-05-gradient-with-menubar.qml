// Importing the Quickshell core module, which provides the `PanelWindow` type
import Quickshell
// Importing the QtQuick module, which provides the `Rectangle` and `Text` types
import QtQuick
// Importing the QtQuick Shapes module, which provides the `Shape` and `ShapePath` types
import QtQuick.Shapes
// Importing the compatibility effects module, which provides `LinearGradient`
import Qt5Compat.GraphicalEffects

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
  readonly property int topGap: 14
  readonly property int pendantDrop: 15
  readonly property int pendantClearance: 16
  readonly property int notchDepth: 16
  readonly property int notchHalf: 14
  readonly property int circleRadius: 4

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
    width: parent.width / panel.effectiveScale
    height: panel.barHeight + panel.pendantDrop + panel.pendantClearance

    transformOrigin: Item.TopLeft
    scale: panel.effectiveScale

    // Pass one — drawing the solid black body with notched sides
    Shape {
      id: body
      antialiasing: true

      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: panel.barHeight

      readonly property real w: width
      readonly property real midY: height / 2

      ShapePath {
        strokeColor: "transparent"
        fillColor: panel.bodyColour
        capStyle: ShapePath.FlatCap
        joinStyle: ShapePath.MiterJoin

        PathPolyline {
          path: [
            Qt.point(0, 0),
            Qt.point(body.w, 0),
            Qt.point(body.w, body.midY - panel.notchHalf),
            Qt.point(body.w - panel.notchDepth, body.midY),
            Qt.point(body.w, body.midY + panel.notchHalf),
            Qt.point(body.w, body.height),
            Qt.point(0, body.height),
            Qt.point(0, body.midY + panel.notchHalf),
            Qt.point(panel.notchDepth, body.midY),
            Qt.point(0, body.midY - panel.notchHalf),
            Qt.point(0, 0)
          ]
        }
      }

      MenuBarContent {
        // Filling the notched body; the pendant hangs below as a sibling and never intrudes here
        anchors.fill: parent
        // Clearing the side notches, which bite inward at mid-height exactly where the content row sits
        anchors.leftMargin: panel.notchDepth
        anchors.rightMargin: panel.notchDepth
        anchors.topMargin: panel.borderWidth
        anchors.bottomMargin: panel.borderWidth

        // Tinting the content with this frame's gold colour
        accentColour: panel.goldColour
        // Passing the free interior height, after the border inset on top and bottom
        contentHeight: panel.barHeight - 2 * panel.borderWidth
      }
    }

    // Pass two — gathering every gold outline into one hidden mask, white
    Item {
      id: goldMask
      anchors.fill: parent
      visible: false

      // Masking the body border with notched sides
      Shape {
        id: maskBody
        antialiasing: true

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: panel.barHeight

        readonly property real w: width
        readonly property real midY: height / 2

        ShapePath {
          strokeColor: "white"
          strokeWidth: panel.borderWidth
          fillColor: "transparent"
          capStyle: ShapePath.FlatCap
          joinStyle: ShapePath.MiterJoin

          PathPolyline {
            path: [
              Qt.point(0, 0),
              Qt.point(maskBody.w, 0),
              Qt.point(maskBody.w, maskBody.midY - panel.notchHalf),
              Qt.point(maskBody.w - panel.notchDepth, maskBody.midY),
              Qt.point(maskBody.w, maskBody.midY + panel.notchHalf),
              Qt.point(maskBody.w, maskBody.height),
              Qt.point(0, maskBody.height),
              Qt.point(0, maskBody.midY + panel.notchHalf),
              Qt.point(panel.notchDepth, maskBody.midY),
              Qt.point(0, maskBody.midY - panel.notchHalf),
              Qt.point(0, 0)
            ]
          }
        }

        // Masking the left circle (positioned at the notch)
        Rectangle {
          x: maskBody.left - panel.circleRadius
          y: maskBody.midY - panel.circleRadius
          width: panel.circleRadius * 2
          height: panel.circleRadius * 2
          radius: panel.circleRadius
          color: "white"
        }

        // Masking the right circle (positioned at the notch)
        Rectangle {
          x: maskBody.right - panel.circleRadius
          y: maskBody.midY - panel.circleRadius
          width: panel.circleRadius * 2
          height: panel.circleRadius * 2
          radius: panel.circleRadius
          color: "white"
        }
      }

      // Masking the pendant, hanging from the centre of the body's bottom edge
      Shape {
        id: maskPendant
        preferredRendererType: Shape.CurveRenderer
        antialiasing: true

        anchors.horizontalCenter: maskBody.horizontalCenter
        anchors.top: maskBody.bottom

        readonly property int shoulderY: 5
        readonly property int chamfer: 6
        readonly property int outerHalf: 100
        readonly property int outerNeck: 8
        readonly property int innerHalf: 20
        readonly property int innerTipY: 24

        width: maskPendant.outerHalf * 2 + 14
        height: panel.pendantDrop + panel.pendantClearance
        readonly property real cx: width / 2

        readonly property var outerPath: [
          Qt.point(cx - outerHalf, 0),
          Qt.point(cx - outerHalf + chamfer, shoulderY),
          Qt.point(cx - outerNeck, shoulderY),
          Qt.point(cx, panel.pendantDrop),
          Qt.point(cx + outerNeck, shoulderY),
          Qt.point(cx + outerHalf - chamfer, shoulderY),
          Qt.point(cx + outerHalf, 0)
        ]

        readonly property var innerPath: [
          Qt.point(cx - innerHalf, 0),
          Qt.point(cx, innerTipY),
          Qt.point(cx + innerHalf, 0)
        ]

        // Stroking the outer chevron
        ShapePath {
          strokeColor: "white"
          strokeWidth: panel.strokeWidth
          fillColor: "transparent"
          capStyle: ShapePath.FlatCap
          joinStyle: ShapePath.MiterJoin
          PathPolyline { path: maskPendant.outerPath }
        }

        // Stroking the inner chevron
        ShapePath {
          strokeColor: "white"
          strokeWidth: panel.strokeWidth
          fillColor: "transparent"
          capStyle: ShapePath.FlatCap
          joinStyle: ShapePath.MiterJoin
          PathPolyline { path: maskPendant.innerPath }
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