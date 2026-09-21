import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import "../Common/" as Common

Kirigami.ScrollablePage {
    property alias cfg_wrapOn: wrap.checked
    property alias cfg_animationDuration: animTime.value
    property alias cfg_blinkOnAttentionRequired: blinkOnAttentionRequired.checked
    property alias cfg_highlightOnHover: hoveringShowsHighlight.checked
    property alias cfg_tooltipOnHover: hoveringShowsTooltip.checked
    title: i18nc("@title","General")
    Kirigami.FormLayout {
        anchors.fill: parent
        wideMode: true
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Mouse Actions"
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Hovering reveals highlight:")
            PC3.CheckBox {
                id: hoveringShowsHighlight
            }
            Common.InfoButton {
                txt: "Show the active-workspace highlight while the pointer is over a workspace."
            }
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Hovering reveals tooltip:")
            PC3.CheckBox {
                id: hoveringShowsTooltip
            }
            Common.InfoButton {
                txt: "Show workspace and window information when the pointer rests over the pager."
            }
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Wraparound when scrolling:")
            PC3.CheckBox {
                id: wrap
            }
            Common.InfoButton {
                txt: "Continue from the first workspace after the last one, and vice versa."
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Animations"
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Animation Duration:")
            PC3.Slider {
                id: animTime
                from: 0
                to: 1000
                stepSize: 10
                live: true
            }
            PC3.Label {
                text: animTime.value +"ms"
            }
            Common.InfoButton {
                txt: "Set the duration of workspace indicator animations. Set to 0 to disable them."
            }
        }
        RowLayout {
            Kirigami.FormData.label: "Blink when attention required:"
            PC3.CheckBox {
                id: blinkOnAttentionRequired
            }
            Common.InfoButton {
                txt: "Blink the workspace indicator when one of its windows requests attention. Requires highlights."
            }
        }
    }
}
