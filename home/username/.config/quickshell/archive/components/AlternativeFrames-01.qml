// Importing the QtQuick module, which provides the `Item` and `Rectangle` types
import QtQuick
// Importing the QtQuick Shapes module, which provides `Shape` and `ShapePath` for the scooped frames
import QtQuick.Shapes
// Importing the compatibility effects module, which provides `OpacityMask`
import Qt5Compat.GraphicalEffects

// Drawing one of the nine ornamental frames around arbitrary popup content, re-parameterised to the frame's own width and height rather than a bar's fixed dimensions
Item {
  id: frame

  // Selecting which of the nine ornamental frames to draw
  property int variant: 1
  // Choosing between the flat gold fill and the vertical gold gradient
  property string phase: "gradient"

  // Defining the palette, shared with the bar frames so popups match the bar
  property color bodyColour: "#1A1A1A"
  property color goldColour: "#C8AA6E"
  property color goldTop: "#F2E3AD"
  property color goldBottom: "#8A6A30"

  // Defining the variant-01 geometry, mirrored from the bar frame so the ornament reads identically
  property int borderWidth: 2
  property int bracketArm: 9
  property int bracketThickness: 2

  // Defining the end-tab geometry used by variant 03 and 04
  property int tabWidth: 4
  property int tabHeight: 10

  // Defining the variant-06 geometry — an outer scooped frame standing proud of an inner bordered body
  property int edgeMargin: 2
  property int frameGap: 2
  property int scoopRadius: 10

  // Defining the variant-02 pendant geometry, hanging from the body's bottom edge into a reserved band below
  property int pendantDrop: 15
  property int pendantClearance: 16
  // Filling the pendant chevrons in body colour for variant 04
  property color pendantFill: frame.bodyColour

  // Defining the variant-05 notch and circle geometry
  property int notchDepth: 16
  property int notchHalf: 14
  property int circleRadius: 4

  // Reserving room below the body for any ornament that hangs beneath it, zero unless the variant has one
  readonly property int bodyBottomReserve:
  {
    switch (frame.variant)
    {
      case 2:
      case 3:
      case 4:
      case 5:
        return frame.pendantDrop + frame.pendantClearance
      default:
        return 0
    }
  }

  // Computing the interior inset, so child content never collides with the border or the corner ornaments
  readonly property int interiorInset:
  {
    switch (frame.variant)
    {
      case 1:
        return frame.borderWidth + frame.bracketArm
      case 2:
        // Clearing only the body border, since this frame carries no corner ornaments on the body
        return frame.borderWidth
      case 3:
      case 4:
        // Clearing the border and the corner brackets, as the brackets sit inside the body corners
        return frame.borderWidth + frame.bracketArm
      case 5:
        // Clearing the side notches, which bite inward at mid-height exactly where content sits
        return frame.notchDepth
      case 6:
        // Clearing the body inset plus the scoop radius, so content avoids the concave corners
        return frame.edgeMargin + frame.frameGap + frame.scoopRadius
      case 7:
        // Clearing the body edge, the frame gap, and the scoop radius, since the body itself is the scooped shape
        return frame.edgeMargin + frame.frameGap + frame.scoopRadius
      default:
        return frame.borderWidth + frame.bracketArm
    }
  }

  // Exposing the body interior as the default child target, so callers place content directly inside the frame
  default property alias content: interior.data

  // Pass one — filling the body, drawn normally and excluded from the gradient; the body occupies the frame minus any reserved band below it
  Item {
    id: body
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: parent.height - frame.bodyBottomReserve

    // Filling a rectangular body for the variants whose body is rectangular
    Rectangle {
      anchors.fill: parent
      visible: frame.variant !== 7 && frame.variant !== 5
      antialiasing: true
      color: frame.bodyColour
      radius: 0
    }

    // Filling a scooped body for variant 07, whose body is itself the scooped shape, inset to match its gold border
    ScoopedRect {
      anchors.fill: parent
      anchors.margins: frame.edgeMargin
      visible: frame.variant === 7
      stroke: "transparent"
      fill: frame.bodyColour
    }

    // Filling a notched body for variant 05, whose sides bite inward at mid-height
    NotchedBody {
      anchors.fill: parent
      visible: frame.variant === 5
      fill: frame.bodyColour
      stroke: "transparent"
    }

    // Hosting the caller's content, inset to clear the border and the corner ornaments
    Item {
      id: interior
      anchors.fill: parent
      anchors.margins: frame.interiorInset
    }
  }

  // Pass one (continued) — filling variant 04's pendant chevrons in body colour, hanging below the body, never touched by the gradient
  PendantChevron {
    visible: frame.variant === 4
    filled: true
    anchors.horizontalCenter: body.horizontalCenter
    anchors.top: body.bottom
  }

  // Pass two — gathering every gold outline into one hidden, white mask, rendered into a layer so the gradient samples a fully built frame
  Item {
    id: goldStrokes
    anchors.fill: parent
    visible: false
    layer.enabled: true

    // Variant 01 — an outer border and four corner brackets, drawn only when selected
    Item {
      anchors.fill: parent
      visible: frame.variant === 1

      // Outlining the body border
      Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "white"
        border.width: frame.borderWidth
        radius: 0
      }

      // Composing one L-shaped corner bracket from a horizontal and a vertical bar

      // Placing the top-left bracket
      MaskCornerBracket {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: frame.borderWidth
        anchors.leftMargin: frame.borderWidth
      }

      // Placing the top-right bracket
      MaskCornerBracket {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: frame.borderWidth
        anchors.rightMargin: frame.borderWidth
        rotation: 90
      }

      // Placing the bottom-right bracket
      MaskCornerBracket {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: frame.borderWidth
        anchors.rightMargin: frame.borderWidth
        rotation: 180
      }

      // Placing the bottom-left bracket
      MaskCornerBracket {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: frame.borderWidth
        anchors.leftMargin: frame.borderWidth
        rotation: 270
      }
    }

    // Variant 06 — an inner bordered body and an outer scooped frame, drawn only when selected
    Item {
      anchors.fill: parent
      visible: frame.variant === 6

      // Masking the inner body border, at the same inset as the black body so the border lands on its edge
      Rectangle {
        anchors.fill: parent
        anchors.margins: frame.edgeMargin + frame.frameGap
        color: "transparent"
        border.color: "white"
        border.width: frame.borderWidth
        antialiasing: true
      }

      // Masking the outer scooped frame, inset by the outer margin alone so it stays larger than the body
      ScoopedRect {
        anchors.fill: parent
        anchors.margins: frame.edgeMargin
      }
    }

    // Variant 07 — a scooped outer border at the body edge and an inner rectangle inset by the frame gap
    Item {
      anchors.fill: parent
      visible: frame.variant === 7

      // Masking the outer scooped border, at the same inset as the scooped body
      ScoopedRect {
        anchors.fill: parent
        anchors.margins: frame.edgeMargin
        stroke: "white"
      }

      // Masking the inner rectangle border, inset further by the frame gap so it stays smaller than the scoop
      Rectangle {
        anchors.fill: parent
        anchors.margins: frame.edgeMargin + frame.frameGap
        color: "transparent"
        border.color: "white"
        border.width: frame.borderWidth
        antialiasing: true
      }
    }

    // Variant 02 — a body border occupying the upper region and a chevron pendant hanging into the reserved band
    Item {
      anchors.fill: parent
      visible: frame.variant === 2

      // Masking the body border, matching the body's own height so it sits above the pendant band
      Rectangle {
        id: variant2Body
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height - frame.bodyBottomReserve
        color: "transparent"
        border.color: "white"
        border.width: frame.borderWidth
        antialiasing: true
      }

      // Masking the pendant, hanging from the centre of the body's bottom edge
      PendantChevron {
        anchors.horizontalCenter: variant2Body.horizontalCenter
        anchors.top: variant2Body.bottom
      }
    }

    // Variant 03 — a bordered body with corner brackets and end tabs, plus the pendant
    Item {
      anchors.fill: parent
      visible: frame.variant === 3

      Rectangle {
        id: variant3Body
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height - frame.bodyBottomReserve
        color: "transparent"
        border.color: "white"
        border.width: frame.borderWidth
        antialiasing: true

        // Placing the four corner brackets and two end tabs inside the body border
        MaskCornerBracket {
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.topMargin: frame.borderWidth
          anchors.leftMargin: frame.borderWidth
        }
        MaskCornerBracket {
          anchors.top: parent.top
          anchors.right: parent.right
          anchors.topMargin: frame.borderWidth
          anchors.rightMargin: frame.borderWidth
          rotation: 90
        }
        MaskCornerBracket {
          anchors.bottom: parent.bottom
          anchors.right: parent.right
          anchors.bottomMargin: frame.borderWidth
          anchors.rightMargin: frame.borderWidth
          rotation: 180
        }
        MaskCornerBracket {
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.bottomMargin: frame.borderWidth
          anchors.leftMargin: frame.borderWidth
          rotation: 270
        }

        // Tabbing the middle of each end
        Rectangle {
          anchors.left: parent.left
          anchors.leftMargin: frame.borderWidth
          anchors.verticalCenter: parent.verticalCenter
          width: frame.tabWidth
          height: frame.tabHeight
          color: "white"
        }
        Rectangle {
          anchors.right: parent.right
          anchors.rightMargin: frame.borderWidth
          anchors.verticalCenter: parent.verticalCenter
          width: frame.tabWidth
          height: frame.tabHeight
          color: "white"
        }
      }

      PendantChevron {
        anchors.horizontalCenter: variant3Body.horizontalCenter
        anchors.top: variant3Body.bottom
      }
    }

    // Variant 04 — identical body furniture to variant 03; the pendant fill is drawn separately in pass one
    Item {
      anchors.fill: parent
      visible: frame.variant === 4

      Rectangle {
        id: variant4Body
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height - frame.bodyBottomReserve
        color: "transparent"
        border.color: "white"
        border.width: frame.borderWidth
        antialiasing: true

        MaskCornerBracket {
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.topMargin: frame.borderWidth
          anchors.leftMargin: frame.borderWidth
        }
        MaskCornerBracket {
          anchors.top: parent.top
          anchors.right: parent.right
          anchors.topMargin: frame.borderWidth
          anchors.rightMargin: frame.borderWidth
          rotation: 90
        }
        MaskCornerBracket {
          anchors.bottom: parent.bottom
          anchors.right: parent.right
          anchors.bottomMargin: frame.borderWidth
          anchors.rightMargin: frame.borderWidth
          rotation: 180
        }
        MaskCornerBracket {
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.bottomMargin: frame.borderWidth
          anchors.leftMargin: frame.borderWidth
          rotation: 270
        }

        Rectangle {
          anchors.left: parent.left
          anchors.leftMargin: frame.borderWidth
          anchors.verticalCenter: parent.verticalCenter
          width: frame.tabWidth
          height: frame.tabHeight
          color: "white"
        }
        Rectangle {
          anchors.right: parent.right
          anchors.rightMargin: frame.borderWidth
          anchors.verticalCenter: parent.verticalCenter
          width: frame.tabWidth
          height: frame.tabHeight
          color: "white"
        }
      }

      PendantChevron {
        anchors.horizontalCenter: variant4Body.horizontalCenter
        anchors.top: variant4Body.bottom
      }
    }

    // Variant 05 — a notched body with circles at the notches, plus the pendant
    Item {
      anchors.fill: parent
      visible: frame.variant === 5

      NotchedBody {
        id: variant5Body
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height - frame.bodyBottomReserve
        stroke: "white"
      }

      // Marking each side notch with a small circle
      Rectangle {
        x: -frame.circleRadius
        y: variant5Body.midY - frame.circleRadius
        width: frame.circleRadius * 2
        height: frame.circleRadius * 2
        radius: frame.circleRadius
        color: "white"
      }
      Rectangle {
        x: variant5Body.width - frame.circleRadius
        y: variant5Body.midY - frame.circleRadius
        width: frame.circleRadius * 2
        height: frame.circleRadius * 2
        radius: frame.circleRadius
        color: "white"
      }

      PendantChevron {
        anchors.horizontalCenter: variant5Body.horizontalCenter
        anchors.top: variant5Body.bottom
      }
    }
  }

  // Defining an L-shaped corner bracket, white for the mask, shared by variants 01, 03, and 04
  component MaskCornerBracket: Item {
    property int arm: frame.bracketArm
    property int thickness: frame.bracketThickness

    width: arm
    height: arm

    Rectangle {
      width: parent.arm
      height: parent.thickness
      color: "white"
    }

    Rectangle {
      width: parent.thickness
      height: parent.arm
      color: "white"
    }
  }

  // Defining a rectangle whose four corners are scooped concave, building asynchronously so the curve geometry settles against final dimensions
  component ScoopedRect: Shape {
    id: sr

    property int scoop: frame.scoopRadius
    property color fill: "transparent"
    property color stroke: "white"
    property int strokeW: frame.borderWidth

    asynchronous: true
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

  // Defining the chevron pendant shared by variants 02 to 05, stroked white for the mask or filled in body colour for variant 04
  component PendantChevron: Shape {
    id: pc

    // Stroking for the mask, or filling for variant 04's body-coloured pass-one shape
    property bool filled: false
    property color fillColour: frame.pendantFill

    asynchronous: true
    preferredRendererType: Shape.CurveRenderer
    antialiasing: true

    // Defining the pendant geometry in local coordinates
    readonly property int shoulderY: 5
    readonly property int chamfer: 6
    readonly property int outerHalf: 100
    readonly property int outerNeck: 8
    readonly property int innerHalf: 20
    readonly property int innerTipY: 24

    // Sizing the shape from the outer half-width, so the chamfers are never clipped
    width: pc.outerHalf * 2 + 14
    height: frame.pendantDrop + frame.pendantClearance
    readonly property real cx: width / 2

    // Drawing the outer chevron, with an angled end and a horizontal shoulder on each side
    ShapePath {
      strokeColor: pc.filled ? "transparent" : "white"
      strokeWidth: frame.borderWidth
      fillColor: pc.filled ? pc.fillColour : "transparent"
      capStyle: ShapePath.FlatCap
      joinStyle: ShapePath.MiterJoin

      startX: pc.cx - pc.outerHalf
      startY: 0
      PathLine { x: pc.cx - pc.outerHalf + pc.chamfer; y: pc.shoulderY }
      PathLine { x: pc.cx - pc.outerNeck; y: pc.shoulderY }
      PathLine { x: pc.cx; y: frame.pendantDrop }
      PathLine { x: pc.cx + pc.outerNeck; y: pc.shoulderY }
      PathLine { x: pc.cx + pc.outerHalf - pc.chamfer; y: pc.shoulderY }
      PathLine { x: pc.cx + pc.outerHalf; y: 0 }
    }

    // Drawing the inner chevron, nested within the outer one
    ShapePath {
      strokeColor: pc.filled ? "transparent" : "white"
      strokeWidth: frame.borderWidth
      fillColor: pc.filled ? pc.fillColour : "transparent"
      capStyle: ShapePath.FlatCap
      joinStyle: ShapePath.MiterJoin

      startX: pc.cx - pc.innerHalf
      startY: 0
      PathLine { x: pc.cx; y: pc.innerTipY }
      PathLine { x: pc.cx + pc.innerHalf; y: 0 }
    }
  }

  // Defining the notched body shape for variant 05, whose sides bite inward at mid-height
  component NotchedBody: Shape {
    id: nb

    property color fill: "transparent"
    property color stroke: "white"
    property int strokeW: frame.borderWidth

    asynchronous: true
    preferredRendererType: Shape.CurveRenderer
    antialiasing: true

    readonly property real midY: height / 2

    ShapePath {
      fillColor: nb.fill
      strokeColor: nb.stroke
      strokeWidth: nb.strokeW
      capStyle: ShapePath.FlatCap
      joinStyle: ShapePath.MiterJoin

      startX: 0
      startY: 0
      // Running the top edge
      PathLine { x: nb.width; y: 0 }
      // Descending the right edge to the upper notch shoulder
      PathLine { x: nb.width; y: nb.midY - frame.notchHalf }
      // Biting inward to the notch apex
      PathLine { x: nb.width - frame.notchDepth; y: nb.midY }
      // Returning to the right edge at the lower notch shoulder
      PathLine { x: nb.width; y: nb.midY + frame.notchHalf }
      // Continuing the right edge to the bottom
      PathLine { x: nb.width; y: nb.height }
      // Running the bottom edge
      PathLine { x: 0; y: nb.height }
      // Ascending the left edge to the lower notch shoulder
      PathLine { x: 0; y: nb.midY + frame.notchHalf }
      // Biting inward to the left notch apex
      PathLine { x: frame.notchDepth; y: nb.midY }
      // Returning to the left edge at the upper notch shoulder
      PathLine { x: 0; y: nb.midY - frame.notchHalf }
      // Closing up the left edge to the top
      PathLine { x: 0; y: 0 }
    }
  }

  // Holding the vertical gold gradient, hidden, used as the gradient-phase source
  Rectangle {
    id: goldGradient
    anchors.fill: parent
    visible: false
    gradient: Gradient {
      GradientStop { position: 0.0; color: frame.goldTop }
      GradientStop { position: 1.0; color: frame.goldBottom }
    }
  }

  // Holding the flat gold fill, hidden, used as the solid-phase source
  Rectangle {
    id: goldFlat
    anchors.fill: parent
    visible: false
    color: frame.goldColour
  }

  // Pass three — showing the chosen gold source only where the mask is opaque
  OpacityMask {
    anchors.fill: parent
    source: frame.phase === "solid" ? goldFlat : goldGradient
    maskSource: goldStrokes
  }
}
