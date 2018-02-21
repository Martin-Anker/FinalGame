import VPlay 2.0
import QtQuick 2.0

EntityBase {

    PhysicsWorld {
        // set no gravity, the collider is not physics-based
      }

    id: player

    function togglespeedX() {
        speedX = speedX * -1
    }

    function togglespeedY() {
        speedY = speedY * -1
    }

    property double speedX: 10
    property double speedY: 10
    property int score: 0
    property int life: 3
    property string playercolor: "grey"
    property int gameoveropacity: 0
    property bool playerrun: false

    entityId: "entity"
    entityType: "customEntity"

    MovementAnimation {
         id: animation
         target: parent
         property: "pos"

         velocity: Qt.point(speedX, speedY)

         // start running from the beginning
         running: false

         Rectangle {
             id: playerrect
             width: 35
             height: 35
             color: playercolor
             MouseArea {
                 anchors.fill: parent
                onPressed: {
                    if (speedX < 0) {
                        speedX = speedX - 20
                    }

                    if (speedX > 0) {
                        speedX = speedX + 20
                    }

                    if (speedY < 0) {
                        speedY = speedY - 20
                    }

                    if (speedY > 0) {
                        speedY = speedY + 20
                    }
                    gameovertext.opacity = 0
                    console.debug(speedX, speedY)
                    animation.running = true
                    mainplayer.score = mainplayer.score + 1
                }
             }

         }

    }

}
