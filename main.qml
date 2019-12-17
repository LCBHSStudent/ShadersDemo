import Reader 1.0
import Finder 1.0
import QtQuick 2.12
import QtQuick.Controls 2.12

import "./Components"

Item {
    id: root
    width: 1280
    height: 768
    Rectangle {color: "#000000"; anchors.fill: parent}
    
    ShaderToyItem {
        id: toy
        anchors.fill: parent
        pixelShader: reader.result
        
        iChannel0: ShaderEffectSource {
            hideSource: true
            sourceItem: Image {
                property int index: comboBox.currentIndex
                source: ""
                onIndexChanged: {
                    source = "qrc" + finder.absolutePaths[index] + "/iChannel0.png"
                }
            }
        }
        
        iChannel1: ShaderEffectSource{
            hideSource: true
//            textureMirroring: ShaderEffectSource.NoMirroring
            sourceItem: Image {
                property int index: comboBox.currentIndex
                source: ""

                onIndexChanged: {
                    source = "qrc" + finder.absolutePaths[index] + "/iChannel1.png"
                }
            }
        }
        iChannel2: ShaderEffectSource{
            hideSource: true
//            textureMirroring: ShaderEffectSource.NoMirroring
            sourceItem: Image {
                property int index: comboBox.currentIndex
                source: ""
                onIndexChanged: {
                    source = "qrc" + finder.absolutePaths[index] + "/iChannel2.png"
                }
            }
        }
        iChannel3: ShaderEffectSource{
            hideSource: true
//            textureMirroring: ShaderEffectSource.NoMirroring
            sourceItem: Image {
                property int index: comboBox.currentIndex
                source: ""
                onIndexChanged: {
                    source = "qrc" + finder.absolutePaths[index] + "/iChannel3.png"
                }
            }
        }
        
        Reader {
            id: reader
            source: ""
            result: ""
        }
        Finder {
            id: finder
            path: ""
            suffix: "glsl"
            onTargetsChanged: {
                iModel.clear();
                for (var i in targets) {
                    iModel.append( {source:targets[i]});
                }
            }
            Component.onCompleted: path = ":/Shaders"
        }
    }
    ListModel {
        id: iModel
    }
    ComboBox {
        id: comboBox
        model: iModel
        Component.onCompleted: {
            currentIndex = 0;
        }
        onCurrentIndexChanged: {
            reader.source = currentText;
        }
    }
    
    Loader {
        id: fps
        x: root.width - width - 10
        y: 10
        source: "qrc:/qmls/Components/Fps.qml"
    }
}
