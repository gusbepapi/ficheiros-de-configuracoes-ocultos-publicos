// Importing the QtQuick module, which provides the `Text`, `Image`, `Rectangle`, and layout types
import QtQuick
// Importing the QtQuick Layouts module
import QtQuick.Layouts
// Importing the QtQuick Window module, which provides the `Window.active` attached property
import QtQuick.Window
// Importing the Quickshell core module, which provides `FloatingWindow`
import Quickshell
// Importing the shared component module, which provides `AlternativeFrames` and `SystemInfo`
import components

// Presenting the about-this-system window, wearing the Eternalian frame, opened on demand from the Apple menu
FloatingWindow {
  id: root

  title: "quickshell-about-this-system"
  implicitWidth: 680
  implicitHeight: 480
  visible: false
  color: "transparent"

  readonly property color accentColour: "#C8AA6E"
  readonly property color accentDim: Qt.darker(root.accentColour, 1.3)
  readonly property color bodyColour: "#1A1A1A"

  function show() { root.visible = true }

  // Dismissing on keyboard shortcuts
  Shortcut {
    sequences: ["Ctrl+W", "Ctrl+Q", "Escape"]
    onActivated: root.visible = false
  }

  // Dismissing when the window loses focus, guarded so the polkit serial prompt does not close it
  Item {
    id: focusWatcher
    readonly property bool windowActive: Window.active
    onWindowActiveChanged:
    {
      if (!focusWatcher.windowActive && !SystemInfo.serialPending)
      {
        root.visible = false
      }
    }
  }

  AlternativeFrames {
    anchors.fill: parent
    variant: 8
    phase: "gradient"

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 20
      spacing: 0

      // Tab bar
      RowLayout {
        id: tabBar
        spacing: 2
        Layout.fillWidth: true
        Layout.bottomMargin: 12

        property int current: 0

        Repeater {
          model: ["Visão geral", "Ecrãs", "Armazenamento", "Aparência", "Ferramentas"]
          delegate: Rectangle {
            required property string modelData
            required property int index
            implicitWidth: tabLabel.implicitWidth + 20
            implicitHeight: 28
            radius: 3
            color: tabBar.current === index
              ? Qt.rgba(root.accentColour.r, root.accentColour.g, root.accentColour.b, 0.22)
              : "transparent"
            border.color: tabBar.current === index ? root.accentColour : "transparent"
            border.width: 1

            Text {
              id: tabLabel
              anchors.centerIn: parent
              text: parent.modelData
              font.family: "Kurinto Seri"
              font.pixelSize: 12
              color: tabBar.current === index ? root.accentColour : root.accentDim
            }

            MouseArea {
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
              onClicked: tabBar.current = index
            }
          }
        }
      }

      // Tab content
      Item {
        Layout.fillWidth: true
        Layout.fillHeight: true

        // --- TAB 0: Overview ---
        RowLayout {
          anchors.fill: parent
          spacing: 20
          visible: tabBar.current === 0

          Image {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            source: SystemInfo.logoSource
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
          }

          ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 2

            Text {
              text: SystemInfo.distroName
              font.family: "Beaufort Pro"
              font.pixelSize: 20
              color: root.accentColour
              Layout.fillWidth: true
              elide: Text.ElideRight
            }

            Text {
              text: SystemInfo.versionDisplay
              font.family: "Kurinto Seri"
              font.pixelSize: 13
              color: root.accentDim
              visible: SystemInfo.versionDisplay.length > 0
            }

            Item { Layout.preferredHeight: 10 }

            SpecRow { label: "Chip";           value: SystemInfo.chip }
            SpecRow { label: "Fabricante";     value: SystemInfo.motherboardVendor }
            SpecRow { label: "Produto";        value: SystemInfo.motherboardName }
            SpecRow { label: "Processador";    value: SystemInfo.processorSummary }
            SpecRow { label: "Memória";        value: SystemInfo.memorySummary }
            SpecRow { label: "Gráficos";       value: SystemInfo.gpuName }
            SpecRow {
              label: "Núcleo"
              value: SystemInfo.kernelDisplay
            }
            SpecRow { label: "Número de série"; valueComponent: serialSwatch }

            Item { Layout.fillHeight: true }
          }
        }

        // --- TAB 1: Displays ---
        ColumnLayout {
          anchors.fill: parent
          spacing: 4
          visible: tabBar.current === 1

          Repeater {
            model: SystemInfo.displays
            delegate: ColumnLayout {
              required property var modelData
              Layout.fillWidth: true
              spacing: 2

              Text {
                text: SystemInfo.displayName(modelData.name) || "Monitor desconhecido"
                font.family: "Beaufort Pro"
                font.pixelSize: 16
                color: root.accentColour
                Layout.fillWidth: true
              }

              SpecRow {
                label: "Resolução"
                value: (modelData.output ? modelData.output.width + " × " + modelData.output.height : "")
                  + (modelData.output && modelData.output.refreshRate ? "  @  " + modelData.output.refreshRate.toFixed(0) + " Hz" : "")
              }

              SpecRow {
                label: "Tamanho físico"
                value: (modelData.physical ? SystemInfo.mmToInches(modelData.physical.width, modelData.physical.height) +
                  "  (" + modelData.physical.width + " × " + modelData.physical.height + " mm)" : "")
              }

              SpecRow {
                label: "Data de fabrico"
                value: (modelData.manufactureDate ? String(modelData.manufactureDate.year) : "")
              }

              SpecRow { label: "Tipo"; value: modelData.type || "" }

              Item { Layout.preferredHeight: 8 }
            }
          }

          Item { Layout.fillHeight: true }
        }

        // --- TAB 2: Storage ---
        ColumnLayout {
          anchors.fill: parent
          spacing: 12
          visible: tabBar.current === 2

          Repeater {
            model: SystemInfo.mergedDisks
            delegate: ColumnLayout {
              required property var modelData
              Layout.fillWidth: true
              spacing: 4

              // Header line: model name, device path, capacity on one line
              RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                  text: modelData.model.length > 0 ? modelData.model : modelData.name
                  font.family: "Beaufort Pro"
                  font.pixelSize: 13
                  color: root.accentColour
                  elide: Text.ElideRight
                  Layout.fillWidth: true
                }

                Text {
                  text: "/dev/" + modelData.name
                  font.family: "Kurinto Seri"
                  font.pixelSize: 11
                  color: root.accentDim
                }

                Text {
                  text: modelData.hasUsage
                    ? SystemInfo.bytesToHuman(modelData.totalBytes) + "  ·  " + SystemInfo.bytesToHuman(modelData.freeBytes) + " livre"
                    : SystemInfo.bytesToHuman(modelData.totalBytes)
                  font.family: "Kurinto Seri"
                  font.pixelSize: 11
                  color: root.accentDim
                }
              }

              // Usage bar — shown only when a mounted partition provides usage data
              Rectangle {
                visible: modelData.hasUsage && modelData.totalBytes > 0
                Layout.fillWidth: true
                height: 18
                radius: 4
                color: Qt.rgba(root.accentColour.r, root.accentColour.g, root.accentColour.b, 0.12)
                border.color: Qt.rgba(root.accentColour.r, root.accentColour.g, root.accentColour.b, 0.3)
                border.width: 1

                Rectangle {
                  width: modelData.totalBytes > 0 ? parent.width * (modelData.usedBytes / modelData.totalBytes) : 0
                  height: parent.height
                  radius: parent.radius
                  color: root.accentColour
                  opacity: 0.85
                }

                Text {
                  anchors.centerIn: parent
                  text: modelData.totalBytes > 0 ? Math.round(modelData.usedBytes / modelData.totalBytes * 100) + "% utilizado" : ""
                  font.family: "Kurinto Seri"
                  font.pixelSize: 10
                  color: root.bodyColour
                }
              }

              Item { Layout.preferredHeight: 4 }
            }
          }

          Item { Layout.fillHeight: true }
        }

        // --- TAB 3: Appearance ---
        ColumnLayout {
          anchors.fill: parent
          spacing: 2
          visible: tabBar.current === 3

          SpecRow { label: "Plataforma gráfica"; value: SystemInfo.graphicsPlatform }
          SpecRow { label: "Gestor de janelas";  value: SystemInfo.wmName + (SystemInfo.wmVersion.length > 0 ? "  " + SystemInfo.wmVersion : "") }
          SpecRow { label: "Tema Qt";            value: SystemInfo.qtTheme }
          SpecRow { label: "Tema GTK";           value: SystemInfo.gtkTheme }
          SpecRow { label: "Ícones Qt";          value: SystemInfo.qtIcons }
          SpecRow { label: "Ícones GTK";         value: SystemInfo.gtkIcons }
          SpecRow { label: "Tipo de letra Qt";   value: SystemInfo.qtFont }
          SpecRow { label: "Tipo de letra GTK2"; value: SystemInfo.gtk2Font }
          SpecRow { label: "Tipo de letra GTK4"; value: SystemInfo.gtk4Font }
          SpecRow { label: "Cursor";             value: SystemInfo.cursorTheme + (SystemInfo.cursorSize.length > 0 ? "  " + SystemInfo.cursorSize + " px" : "") }
          SpecRow { label: "Idioma";             value: SystemInfo.locale }

          Item { Layout.fillHeight: true }
        }

        // --- TAB 4: Favourite tools (seeded by fastfetch, overridable via YAML fallback) ---
        ColumnLayout {
          anchors.fill: parent
          spacing: 2
          visible: tabBar.current === 4

          SpecRow { label: "Shell";             value: SystemInfo.shellName + (SystemInfo.shellVersion.length > 0 ? "  " + SystemInfo.shellVersion : "") }
          SpecRow { label: "Terminal";          value: SystemInfo.terminalName + (SystemInfo.terminalVersion.length > 0 ? "  " + SystemInfo.terminalVersion : "") }
          SpecRow { label: "Editor de texto";   value: SystemInfo.textEditorName + (SystemInfo.textEditorVersion.length > 0 ? "  " + SystemInfo.textEditorVersion : "") }
          SpecRow { label: "Editor gráfico";    value: SystemInfo.guiEditorName + (SystemInfo.guiEditorVersion.length > 0 ? "  " + SystemInfo.guiEditorVersion : "") }
          SpecRow { label: "IDE";               value: SystemInfo.ideName + (SystemInfo.ideVersion.length > 0 ? "  " + SystemInfo.ideVersion : "") }
          SpecRow { label: "Navegador";         value: SystemInfo.browserName + (SystemInfo.browserVersion.length > 0 ? "  " + SystemInfo.browserVersion : "") }

          Item { Layout.fillHeight: true }
        }
      }
    }
  }

  // Serial swatch component
  Component {
    id: serialSwatch

    Item {
      implicitWidth: 160
      implicitHeight: 18

      Text {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: SystemInfo.serial.length > 0
        text: SystemInfo.serial
        font.family: "Kurinto Seri"
        font.pixelSize: 12
        color: root.accentColour
      }

      Rectangle {
        anchors.fill: parent
        visible: SystemInfo.serial.length === 0
        radius: 2
        color: Qt.rgba(root.accentColour.r, root.accentColour.g, root.accentColour.b, 0.18)
        border.color: Qt.rgba(root.accentColour.r, root.accentColour.g, root.accentColour.b, 0.4)
        border.width: 1

        Text {
          anchors.centerIn: parent
          text: SystemInfo.serialPending ? "a autenticar…" : "mostrar"
          font.family: "Kurinto Seri"
          font.pixelSize: 11
          color: root.accentColour
        }

        MouseArea {
          anchors.fill: parent
          enabled: !SystemInfo.serialPending
          cursorShape: Qt.PointingHandCursor
          onClicked: SystemInfo.revealSerial()
        }
      }
    }
  }

  // Reusable label-and-value row
  component SpecRow: RowLayout {
    required property string label
    property alias value: valueText.text
    property Component valueComponent: null

    spacing: 8
    Layout.fillWidth: true
    Layout.topMargin: 1
    Layout.bottomMargin: 1

    Text {
      text: parent.label
      font.family: "Kurinto Seri"
      font.pixelSize: 12
      color: root.accentDim
      Layout.preferredWidth: 160
      horizontalAlignment: Text.AlignRight
      verticalAlignment: Text.AlignVCenter
    }

    Text {
      id: valueText
      visible: !parent.valueComponent
      font.family: "Kurinto Seri"
      font.pixelSize: 12
      color: root.accentColour
      wrapMode: Text.WordWrap
      verticalAlignment: Text.AlignVCenter
      Layout.fillWidth: true
    }

    Loader {
      visible: !!parent.valueComponent
      Layout.fillWidth: true
      sourceComponent: parent.valueComponent
    }
  }
}
