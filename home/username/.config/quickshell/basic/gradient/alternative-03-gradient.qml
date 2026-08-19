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

  // Defining a reusable L-shaped corner bracket at the top level, so the mask can instantiate it
  component CornerBracket: Item {
    id: bracket

    property int arm: panel.bracketArm
    property int thickness: panel.bracketThickness
    property color colour: "white"

    width: arm
    height: arm

    // Drawing the horizontal arm of the L
    Rectangle {
      width: bracket.arm
      height: bracket.thickness
      color: bracket.colour
    }

    // Drawing the vertical arm of the L
    Rectangle {
      width: bracket.thickness
      height: bracket.arm
      color: bracket.colour
    }
  }

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

    // Pass one — drawing the solid black body, with no gold border, since the border now comes from the gradient
    Rectangle {
      id: body
      antialiasing: true

      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: panel.barHeight

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

    // Pass two — gathering every gold outline into one hidden mask, white, since only its alpha is read
    Item {
      id: goldMask
      anchors.fill: parent
      visible: false

      // Masking the body border, matching the real body's geometry
      Rectangle {
        id: maskBody

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: panel.barHeight

        color: "transparent"
        border.color: "white"
        border.width: panel.borderWidth
        antialiasing: true

        // Masking the top-left bracket
        CornerBracket {
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.topMargin: panel.borderWidth
          anchors.leftMargin: panel.borderWidth
        }

        // Masking the top-right bracket
        CornerBracket {
          anchors.top: parent.top
          anchors.right: parent.right
          anchors.topMargin: panel.borderWidth
          anchors.rightMargin: panel.borderWidth
          rotation: 90
        }

        // Masking the bottom-right bracket
        CornerBracket {
          anchors.bottom: parent.bottom
          anchors.right: parent.right
          anchors.bottomMargin: panel.borderWidth
          anchors.rightMargin: panel.borderWidth
          rotation: 180
        }

        // Masking the bottom-left bracket
        CornerBracket {
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.bottomMargin: panel.borderWidth
          anchors.leftMargin: panel.borderWidth
          rotation: 270
        }

        // Masking the tab at the middle of the left end
        Rectangle {
          anchors.left: parent.left
          anchors.leftMargin: panel.borderWidth
          anchors.verticalCenter: parent.verticalCenter
          width: panel.tabWidth
          height: panel.tabHeight
          color: "white"
        }

        // Masking the tab at the middle of the right end
        Rectangle {
          anchors.right: parent.right
          anchors.rightMargin: panel.borderWidth
          anchors.verticalCenter: parent.verticalCenter
          width: panel.tabWidth
          height: panel.tabHeight
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

        // Drawing the outer chevron, with an angled end and a horizontal shoulder on each side
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

        // Drawing the inner chevron, attached to the bar edge and nested within the outer one
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
