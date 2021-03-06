import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2


Item {

    GridLayout {
        anchors.fill: parent
        anchors.margins: 5
        columns: 2
        //Component.onCompleted: { mainWindow.minimumWidth = 800; mainWindow.minimumHeight = 350 }
        Component.onCompleted: { mainWindow.minimumWidth = 750; mainWindow.minimumHeight = 425; say_to_user("")}



    // Panel: Basic config
        GroupBox {
            Layout.fillWidth: true
            GridLayout {
                anchors.fill: parent
                anchors.margins: 5
                columns: 2

                Label{
                    Layout.columnSpan: 2
                    //font.family: "Helvetica"
                    color: "Green"
                    font.pointSize: 10
                    font.bold: true
                    text: qsTr("Básico")
                    horizontalAlignment: Text.AlignHCenter
                }

                Label{ text: qsTr("Actualizar manualmente") }
                Button{
                    text: "Actualizar"
                    tooltip: "Presiona para actualziar"
                    onClicked: {
                        Utils.update("")
                        say_to_user( qsTr("Descargando actualización, puede llevar unos segundos"), "blue" )
                    }
                }

                /*Label{ text: qsTr("Preguntar al añadir escena") }
                CheckBox {
                    text: qsTr("")
                    checked: settings.ask
                    onClicked: settings.ask = checked
                }*/


                Label{ text: qsTr("Empezar en pantalla completa") }
                CheckBox {
                    text: qsTr("")
                    checked: settings.start_fullscreen
                    onClicked: settings.start_fullscreen = checked
                }


                Label{ text: qsTr("Preguntar si hay actualizaciones") }
                CheckBox {
                    text: qsTr("")
                    checked: settings.ask_to_update
                    onClicked: settings.ask_to_update = checked
                }


                Label{ text: qsTr("Compartir información automáticamente") }
                CheckBox {
                    text: qsTr("")
                    checked: settings.autoshare
                    onClicked: settings.autoshare = checked
                }

                Label{ text: qsTr("Reproductor favorito") }
                ComboBox {
                    id: player_combo
                    Layout.minimumWidth : 100
                    model: players_list
                    //currentIndex: player.execute.name()
                    onActivated: set_player( currentText )
                }
            }
        }


    // Panel: Advanced config!
        GroupBox {
            Layout.fillWidth: true
            GridLayout {
                anchors.fill: parent
                anchors.margins: 5
                columns: 2

                Label{
                    Layout.columnSpan: 2
                    //font.family: "Helvetica"
                    color: "Green"
                    font.pointSize: 10
                    font.bold: true
                    text: qsTr("Avanzado")
                    horizontalAlignment: Text.AlignHCenter
                }

                Label{ text: qsTr("Calibración guiada") }
                Button {
                    text: qsTr("Calibrar")
                    Layout.preferredWidth: 100
                    onClicked: manual_calibration()
                }


                Label{ text: qsTr("Saltar antes de las escenas") }
                TextField {
                    text: settings.time_margin
                    onEditingFinished: settings.time_margin = parseFloat(text)
                }

                Label{ text: qsTr("Ejecutable VLC") }
                TextField {
                    text: settings.vlc_path
                    Layout.minimumWidth: 250
                    onEditingFinished: {
                        settings.vlc_path = text
                        VLC_CONSOLE.set_path( settings.vlc_path )
                        VLC_TCP.set_path( settings.vlc_path )
                    }
                }

            }
        }


    // Panel: Ninja config!
        GroupBox {
            Layout.fillWidth: true
            GridLayout {
                anchors.fill: parent
                anchors.margins: 5
                columns: 2

                Label{
                    Layout.columnSpan: 2
                    //font.family: "Helvetica"
                    color: "Green"
                    font.pointSize: 10
                    font.bold: true
                    text: qsTr("Ninja")
                    horizontalAlignment: Text.AlignHCenter
                }

                /*Label{ text: qsTr("Beta testers") }
                Button {
                    id: testing
                    text: "No pulsar jamás"
                    Layout.fillWidth: true
                    onClicked: {
                        //manual_calibration()
                        //Utils.get_shots("")
                        //survey.visible = true
                        //Utils.update("")
                        //get_subs()
                        //media.url = fileurl.text.toString()
                        //parse_input_file()
                        //calibrate_from_subtitles()
                        //console.log(JSON.stringify(a))
                        //console.log( seconds_to_time(65) )
                    }
                }*/
                Label{ text: qsTr("Diferencia tiempo entre versiones") }
                TextField {
                    Layout.fillWidth: true
                    id:offset
                    text: sync.applied_offset
                    onEditingFinished: apply_sync( parseFloat(offset.text), parseFloat(speed.text), 1 )
                }


                Label{ text: qsTr("Diferencia velocidad entre versiones") }
                TextField {
                    Layout.fillWidth: true
                    id:speed
                    text: sync.applied_speed
                    onEditingFinished: apply_sync( parseFloat(offset.text), parseFloat(speed.text), 1 )
                }
            }
        }

        Label{
            id: l_msg
            color: movie.msg_color
            text: movie.msg_to_user
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            font.bold : true
        }

    }
}


