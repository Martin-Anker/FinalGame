import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"

    activeScene: scene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 960
    screenHeight: 640

    PhysicsWorld {
        // set no gravity, the collider is not physics-based
      }

    Scene {
        id: scene
        MouseArea {
                anchors.fill: parent
               onPressed: {
                    mainplayer.life = mainplayer.life - 1
                    if (mainplayer.life <= 0) {
                    gameovertext.opacity = 1

                    }
                    else {
                        gameovertext.opacity = 0
                    }

               }
        }


        Player {
            id: mainplayer
            anchors.alignWhenCentered: Scene.Center
            x: 200
            y: 160
            BoxCollider {
                id: fixture
               anchors.fill: parent
               collisionTestingOnlyMode: true
               bodyType: Body.Static
               categories: Box.Category1
            }
        }

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 480
        height: 320

        Rectangle {
            anchors.right: scene.right
            id: rectright
            width: 20
            height: 1000
            color: "red"
            BoxCollider {
                anchors.fill: parent
                collidesWith: Box.Category1
                categories: Box.Category2
                collisionTestingOnlyMode: true
                fixture.onBeginContact: {
                       console.debug("test")
                       mainplayer.speedX = mainplayer.speedX * -1
                     }
            }
        }

        Rectangle {
            anchors.left: scene.gameWindowAnchorItem.left
            id: rectleft
            width: 20
            height: 1000
            color: "red"
            BoxCollider {
                categories: Box.Category3
                collidesWith: Box.Category1
                anchors.fill: parent
                collisionTestingOnlyMode: true
                fixture.onBeginContact: {
                       console.debug("test")
                       mainplayer.speedX = mainplayer.speedX * -1
                     }
            }
        }

        Rectangle {
            anchors.bottom: scene.gameWindowAnchorItem.bottom
            id: rectbottom
            width: 1000
            height: 20
            color: "red"
            BoxCollider {
                categories: Box.Category4
                collidesWith: Box.Category1
                anchors.fill: parent
                collisionTestingOnlyMode: true
                fixture.onBeginContact: {
                       console.debug("test")
                       mainplayer.speedY = mainplayer.speedY * -1
                     }
            }
        }

        Rectangle {
            anchors.top: scene.gameWindowAnchorItem.top
            id: recttop
            width: 1000
            height: 20
            color: "red"
            BoxCollider {
                categories: Box.Category5
                collidesWith: Box.Category1
                anchors.fill: parent
                collisionTestingOnlyMode: true
                fixture.onBeginContact: {
                       console.debug("test")
                       mainplayer.speedY = mainplayer.speedY * -1
                     }
            }
        }

        Text {
            anchors.bottom: scene.bottom
            text: "Punkte: " + mainplayer.score
            font.family: "Helvetica"
            font.pointSize: 10
            color: "black"
        }

        Text {
            anchors.bottom: scene.bottom
            anchors.right: parent.right
            text: "Leben: " + mainplayer.life
            font.family: "Helvetica"
            font.pointSize: 10
            color: "black"
        }

        Text {
            id: gameovertext
            anchors.horizontalCenter : parent.horizontalCenter
            anchors.verticalCenter : parent.verticalCenter
            text: "GAME OVER"
            color: "black"
            font.family: "Helvetica"
            font.pointSize: 40
            opacity: 0
            Text {
                anchors.top: parent.bottom
                text: "Click on Restart and than on the player to start the game again."
                color: "black"
                font.family: "Helvetica"
                font.pointSize: 10
            }
        }

        SimpleButton {
                anchors.left: scene.left
                anchors.top: scene.top
               text: "Restart"

               // these are the default values
               color: "darkblue"
               textColor: "white"
               pixelSize: 18


               onClicked: {
                mainplayer.gameoveropacity = 0
                console.debug("test")
                mainplayer.score = 0
                mainplayer.life = 3
                mainplayer.speedX = 10
                mainplayer.speedY = 10
               }
        }

    }
}
