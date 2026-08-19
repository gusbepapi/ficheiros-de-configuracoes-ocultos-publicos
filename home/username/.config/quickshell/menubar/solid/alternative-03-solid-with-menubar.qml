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
  readonly property color testColour: "#8F8269"
  readonly property int borderWidth: 2
  readonly property int strokeWidth: 2
  readonly property int barHeight: 50
  readonly property int topGap: 14
  readonly property int pendantDrop: 15
  readonly property int pendantClearance: 16
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

      // Anchoring the bar body to the top of the stage
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: panel.barHeight

      color: panel.bodyColour
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

      MenuBarContent {
        // Filling the body interior; the pendant hangs below as a sibling and never intrudes here
        anchors.fill: parent
        // Clearing the brackets and the protruding end tabs along the sides, and the border top and bottom
        anchors.leftMargin: panel.borderWidth + panel.bracketArm
        anchors.rightMargin: panel.borderWidth + panel.bracketArm
        anchors.topMargin: panel.borderWidth
        anchors.bottomMargin: panel.borderWidth

        // Tinting the content with this frame's gold colour
        accentColour: panel.goldColour
        // Passing the free interior height, after the border inset on top and bottom
        contentHeight: panel.barHeight - 2 * panel.borderWidth
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

      // Defining each chevron's points once, so the fill and stroke passes share them
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

      // Filling the outer chevron with transparent color
      ShapePath {
        strokeColor: "transparent"
        fillColor: "transparent"
        PathPolyline { path: pendant.outerPath }
      }

      // Filling the inner chevron with transparent color
      ShapePath {
        strokeColor: "transparent"
        fillColor: "transparent"
        PathPolyline { path: pendant.innerPath }
      }

      // Stroking the outer chevron on top
      ShapePath {
        strokeColor: panel.goldColour
        strokeWidth: panel.strokeWidth
        fillColor: "transparent"
        capStyle: ShapePath.FlatCap
        joinStyle: ShapePath.MiterJoin
        PathPolyline { path: pendant.outerPath }
      }

      // Stroking the inner chevron on top
      ShapePath {
        strokeColor: panel.goldColour
        strokeWidth: panel.strokeWidth
        fillColor: "transparent"
        capStyle: ShapePath.FlatCap
        joinStyle: ShapePath.MiterJoin
        PathPolyline { path: pendant.innerPath }
      }
    }
  }
}