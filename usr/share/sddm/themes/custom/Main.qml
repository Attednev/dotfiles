import QtQuick 2.12
import QtGraphicalEffects 1.12
import SddmComponents 2.0

Rectangle {
    id: container

    //property int sessionIndex: session.index

    /*TextConstants { id: textConstants }

    Connections {
        target: sddm

        onLoginSucceeded: {
            errorMessage.color = "steelblue"
            errorMessage.text = textConstants.loginSucceeded
        }

        onLoginFailed: {
            password.text = ""
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
        }
        onInformationMessage: {
            errorMessage.color = "red"
            errorMessage.text = message
        }
}*/

	Background {
		id: background
		anchors.fill: parent
		source: config.background
		fillMode: Image.PreserveAspectCrop
		onStatusChanged: {
			if (status == Image.Error && source != config.defaultBackground) {
				source = config.defaultBackground
			}
		}

		ShaderEffectSource {
			id: mask
			sourceItem: background
			width: 550 
			height: parent.height
			sourceRect: Qt.rect(x, y, width, height)
		}
	
		GaussianBlur {
			anchors.fill: mask
			source: mask
			radius: 8
			samples: 8
		}
	}

	Rectangle {
		width: 550
		height: parent.height
		anchors.left: parent.left
		color: "transparent"

		Clock {
			id: clock
			anchors.bottom: parent.verticalCenter
			anchors.horizontalCenter: parent.horizontalCenter 
			width: parent.width
			color: "white"
		}

		Rectangle {
			id: credentials
			anchors.top: parent.verticalCenter
			anchors.horizontalCenter: parent.horizontalCenter

			width: parent.width * 0.8
			height: 200
			color: "transparent"

			Rectangle {
				anchors.bottomMargin: 10
				anchors.bottom: parent.verticalCenter
				width: parent.width
				height: 45
				radius: 20
				border.color: "white"
				border.width: 2
				color: "transparent"

				Text {
					id: lbName
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					anchors.leftMargin: 15
					color: "white"
					//width: 10
					font.bold: true
					font.pixelSize: 24
					text: ""
				}

				TextBox {
					id: name
					anchors.leftMargin: 10
					anchors.left: lbName.right
					color: "transparent"
					borderColor: "transparent"
					focusColor: "transparent"
					hoverColor: "transparent"
					textColor: "white"
					text: userModel.lastUser
					font.pixelSize: 20
					height: parent.height
					width: parent.width - lbName.width - anchors.leftMargin - lbName.anchors.leftMargin

					KeyNavigation.backtab: rebootButton
					KeyNavigation.tab: password

					Keys.onPressed: {
						if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
							sddm.login(name.text, password.text, 0)
							event.accepted = true
						}
					}
				}
			}

			Rectangle {
				id: passwordBox
				anchors.topMargin: 10
				anchors.top: parent.verticalCenter
				width: parent.width
				height: 45
				radius: 20
				border.color: "white"
				border.width: 2
				color: "transparent"

				Text {
					id: lbPassword
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					anchors.leftMargin: 15
					color: "white"
					font.bold: true
					font.pixelSize: 24
					text: ""
				}

				PasswordBox {
					id: password
					anchors.leftMargin: 10
					anchors.left: lbPassword.right
					color: "transparent"
					borderColor: "transparent"
					focusColor: "transparent"
					hoverColor: "transparent"
					textColor: "white"
					height: parent.height
					width: parent.width - lbPassword.width - anchors.leftMargin - lbPassword.anchors.leftMargin
				
					KeyNavigation.backtab: name
					KeyNavigation.tab: shutdownButton

					Keys.onPressed: {
						if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
							sddm.login(name.text, password.text, 0)
							event.accepted = true
						}
					}
				}
			}
			
			Row {
				spacing: 10
				anchors.topMargin: 20
				anchors.top: passwordBox.bottom
				anchors.horizontalCenter: parent.horizontalCenter
				property int btnWidth: Math.max(loginButton.implicitWidth,
				shutdownButton.implicitWidth,
				rebootButton.implicitWidth, 80) + 8

				Rectangle {
					id: shutdownButton

					width: 50
					height: 50

					border.color: "white"
					border.width: 2
					radius: 50

					color: "transparent"

					KeyNavigation.backtab: password; 
					KeyNavigation.tab: rebootButton

					Text {
						anchors.horizontalCenter: parent.horizontalCenter
						anchors.verticalCenter: parent.verticalCenter
						font.pixelSize: 24
						color: "white"
						text: ""
					}

					MouseArea {
						anchors.fill: parent

						cursorShape: Qt.PointingHandCursor
						acceptedButtons: Qt.LeftButton

						onClicked: {
							sddm.powerOff()
						}
					}
				}

				Rectangle {
					id: rebootButton

					width: 50
					height: 50

					border.color: "white"
					border.width: 2
					radius: 50

					color: "transparent"

					KeyNavigation.backtab: shutdownButton
					KeyNavigation.tab: name

					Text {
						anchors.horizontalCenter: parent.horizontalCenter
						anchors.verticalCenter: parent.verticalCenter
						font.pixelSize: 24
						color: "white"
						text: ""
					}

					MouseArea {
						anchors.fill: parent

						cursorShape: Qt.PointingHandCursor
						acceptedButtons: Qt.LeftButton

						onClicked: {
							sddm.reboot()
						}
					}
				}
			}		
		}
	}


	Component.onCompleted: {
		if (name.text == "") {
			name.focus = true
		} else {
			password.focus = true
		}
	}
}
