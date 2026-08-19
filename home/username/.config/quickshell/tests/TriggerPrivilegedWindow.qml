import QtQuick
import Quickshell
import Quickshell.Io 

FloatingWindow {
    id: root
    
    visible: true
    implicitWidth: 250   
    implicitHeight: 100 
    
    Rectangle {
        anchors.fill: parent
        color: apacheRestartProcess.running ? "#1e2c4a" : "#232534"
        radius: 8

        Text {
            anchors.centerIn: parent
            text: apacheRestartProcess.running ? "Restarting Apache..." : "Click to Restart Apache"
            color: "white"
            font.pointSize: 12
        }

        TapHandler {
            enabled: !apacheRestartProcess.running
            onTapped: {
                console.log("Button clicked! Triggering native systemctl call...");
                apacheRestartProcess.running = true; 
            }
        }
    }

    Process {
        id: apacheRestartProcess
        
        command: ["systemctl", "restart", "apache2.service"]

        onExited: (exitCode) => {
            console.log("Process finished with code: " + exitCode);
            
            running = false; 
            
            if (exitCode === 0) {
                console.log("Success: Apache restarted smoothly! Closing widget.");
                // CORRECTED FIX: Standard QML engine shutdown command
                Qt.quit(); 
            } else {
                console.log("Polkit dialog closed or authentication failed.");
            }
        }
    }
}
