import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PC3
import QtQuick.Controls as QQC2
import "../Common/" as Common
import org.kde.kquickcontrols as KQuickControls

Kirigami.ScrollablePage {
    title: i18nc("@title", "Appearance")

    //Types-----------------------------------
    property alias cfg_type: type.style
    property alias cfg_highlightType: hType.currentIndex
    //Dimensions
    property alias cfg_spacing: spacing.value
    property alias cfg_t1width: pillDimen.w
    property alias cfg_t1height: pillDimen.h
    property alias cfg_t1activeHeight: activePillDimen.h
    property alias cfg_t1activeWidth: activePillDimen.w
    property alias cfg_fixedLen: fixedLen.value
    property alias cfg_t1radius: t1radius.value
    //Custom Lists
    property alias cfg_iconsList: customIcons.text
    property alias cfg_labelsList: customLabels.text
    property alias cfg_labelExtra: extraCustomLabel.text
    property alias cfg_iconExtra: extraCustomIcon.text
    property alias cfg_showOnlyActive: showOnlyActiveWorkspaces.checked
    //Decorations
    //Other
    property alias cfg_template: template.text
    property alias cfg_labelSource: labelSource.currentIndex
    property alias cfg_beforeTemplate: beforeTemplate.text
    property alias cfg_afterTemplate: afterTemplate.text
    property alias cfg_activeTemplate: activeTemplate.text
    property alias cfg_allowLabelRotate: allowLabelRotate.checked

    property string substituteText: i18n('\n<b>Replacements:</b>\n%d - Desktop number\n%name - Desktop name\n%roman - Roman numerals')

    Kirigami.FormLayout {
        anchors.fill: parent
        wideMode: true

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Layout Settings")
        }
        Common.PixelSlider {
            id: spacing
            Kirigami.FormData.label: i18n("Spacing:")
            from: 0
            to: 20
        }
        Common.PixelDimensions {
            id: pillDimen
            from: 1
            Kirigami.FormData.label: i18n("Inactive:")
            visible: cfg_type == 0
        }
        Common.PixelDimensions {
            id: activePillDimen
            from: 1
            Kirigami.FormData.label: i18n("Active:")
            visible: cfg_type == 0
        }
        PC3.Slider {
            id: t1radius
            from: 0
            to: 5
            stepSize: 0.5
            visible: cfg_type == 0
            Kirigami.FormData.label: i18n("Pill radius:")
        }
        Common.PixelSlider {
            visible: cfg_type > 0
            Kirigami.FormData.label: i18n("Fixed length:")
            id: fixedLen
            from: 1
            to: 150
        }
        PC3.CheckBox {
            visible: cfg_type == 1
            id: allowLabelRotate
            Kirigami.FormData.label: i18n("Rotate label for vertical panels:")
        }


        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Indicator Settings")
        }
        RowLayout {
            id: type
            Kirigami.FormData.label: i18n("Indicator style:")
            property int style
            PC3.RadioButton {
                text: i18n("Pills")
                checked: type.style == 0
                onCheckedChanged: if(checked) type.style = 0
            }
            PC3.RadioButton {
                text: i18n("Text")
                checked: type.style == 1
                onCheckedChanged: if(checked) type.style = 1
            }
            PC3.RadioButton {
                text: i18n("Icons")
                checked: type.style == 2
                onCheckedChanged: if(checked) type.style = 2
            }
        }

        PC3.CheckBox {
            id: showOnlyActiveWorkspaces
            Kirigami.FormData.label: i18n("Show only workspaces with windows:")
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Label source:")
            visible: cfg_type == 1
            QQC2.ComboBox {
                id: labelSource
                model: [i18n("Desktop number"), i18n("Desktop name"),
                i18n("Custom template"), i18n("Relative templates"),
                i18n("Pre-defined labels"), i18n("Roman numerals"),
                i18n("Hindu-Arabic numerals"), i18n("Chinese numerals")]
            }
            Common.InfoButton {
                txt: i18n("Choose how workspace labels are generated.")
            }
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Custom template:")
            visible: cfg_type == 1 && cfg_labelSource == 2
            PC3.TextField {
                id: template
            }
            Common.InfoButton {
                txt: i18n("Use one template for every workspace. Replacements are listed below.")
            }
        }
        PC3.TextField {
            id: beforeTemplate
            visible: cfg_type == 1 && cfg_labelSource == 3
            Kirigami.FormData.label: i18n("Before template:")
        }
        PC3.TextField {
            id: activeTemplate
            visible: cfg_type == 1 && cfg_labelSource == 3
            Kirigami.FormData.label: i18n("Active template:")
        }
        PC3.TextField {
            id: afterTemplate
            visible: cfg_type == 1 && cfg_labelSource == 3
            Kirigami.FormData.label: i18n("After template:")
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Pre-defined labels:")
            visible: cfg_type == 1 && cfg_labelSource == 4
            PC3.TextArea {
                id: customLabels
                placeholderText: i18n("One konqi\nTwo konqis\nThree konqis")
            }
            Common.InfoButton {
                txt: i18n("Enter one label per workspace, in order. Missing or empty entries use the extra label.")
            }
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Extra label:")
            visible: cfg_type == 1 && cfg_labelSource == 4
            PC3.TextField {
                id: extraCustomLabel
                placeholderText: i18n("D%d")
            }
            Common.InfoButton {
                txt: i18n("Fallback label for workspaces without a predefined label.")
            }
        }
        PC3.Label {
            visible: cfg_type == 1 && (cfg_labelSource == 4
            || cfg_labelSource == 3 || cfg_labelSource == 2)
            Kirigami.FormData.label: i18n("Replacements for templates:")
            Kirigami.FormData.labelAlignment: Qt.AlignTop
            text: i18n("<b>%d</b>: Desktop number<br>
            <b>%name</b>: Desktop name<br>
            <b>%roman</b>: Roman numerals<br>
            <b>%hindu</b>: Hindu-Arabic numerals<br>
            <b>%chinese</b>: Chinese/Mandarin numerals")
        }




        RowLayout {
            Kirigami.FormData.label: i18n("Custom icons:")
            visible: cfg_type == 2
            PC3.TextArea {
                id: customIcons
                placeholderText: i18n("format-text-code\ninternet-services\nmusic-note-16th")
            }
            Common.InfoButton {
                txt: i18n('Use an icon explorer like <b>Cuttlefish</b> to look for icon IDs.\n'+
                'First icon goes to the first desktop and so on.\n'+
                'If an icon name is wrong, it will fallback to the extra icon.')
            }
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Extra icon:")
            visible: cfg_type == 2
            PC3.TextField {
                id: extraCustomIcon
                placeholderText: i18n("desktop-symbolic")
            }
            Common.InfoButton {
                txt: i18n("This icon will be shown when the desktop IDs you entered are less than open desktops.")
            }
        }
        //For Custom Text Type-----------------------------------------
        // ----------------------------------------
        // Highlight Settings
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Highlight Settings")
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Highlight style:")
            QQC2.ComboBox {
                id: hType
                model: [i18n("None"), i18n("Line"), i18n("Square"), i18n("Full"), i18n("Full with Line")]
            }
            Common.InfoButton {
                txt: i18n("Controls how the active workspace is highlighted.")
            }
        }
    }
}
