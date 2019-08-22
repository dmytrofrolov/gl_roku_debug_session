
sub init()
    ' Don't do
    ' m.top.getParent()
    ' node.setFocus(true)
    ' label = m.top.createChild("Label")
    ' label.text = "asd"
    m.top.ObserveField("args", "OnArgsSet")

    m.screenStackUI = m.top.findNode("screenStackUI")

    globalContainer = CreateObject("roSGNode", "GlobalContainer")
    m.global.addFields({
        globalContainer : globalContainer
    })
end sub


sub OnArgsSet(event as Object)
    ' roSGNodeEvent
    ' event.GetField() ' args
    args = event.getData() ' {}
    ' event.GetRoSGNode() ' == m.top
    ShowGridScreen()
end sub


sub ShowGridScreen()
    screen = CreateObject("roSGNode", "GridScreen")
    screen.ObserveField("itemSelected", "OnGridItemSelected")
    ' screen.subtype() == "GridScreen"
    content = GetListContent()
    screen.content = content
    ShowScreen(screen)
end sub


sub OnGridItemSelected(event as Object)
    gridScreen = event.GetRoSGNode()
    itemSelected = event.GetData()
    ShowDetailsScreen(gridScreen.content.getChild(itemSelected))
end sub


sub ShowDetailsScreen(selectedItem)
    screen = CreateObject("roSGNode", "DetailsScreen")
    screen.ObserveField("buttonSelected", "OnDetailsButtonSelected")
    screen.content = selectedItem
    ShowScreen(screen)
end sub

sub OnDetailsButtonSelected(event as Object)
    detailScreen = event.GetRoSGNode()
    selectedItem = detailScreen.content
    ShowVideoScreen(selectedItem)
end sub



sub ShowVideoScreen(selectedItem)
    screen = CreateObject("roSGNode", "VideoScreen")
    screen.content = selectedItem
    ShowScreen(screen)
end sub



' _______ content
function GetListContent()
    content = CreateObject("roSGNode", "ContentNode")
    content.update({
            title : "List"
            children : [{
                    title : "title1"
                    hdposterurl : "pkg:/images/image.png"
                    url : "pkg:/images/1.mp4"
                    streamFormat : "mp4"
                },
                {
                    title : "title1"
                    hdposterurl : "pkg:/images/image.png"
                    url : "pkg:/images/1.mp4"
                    streamFormat : "mp4"
                }]
        }, true)
    return content
end function



function onKeyEvent(key as String, press as Boolean)
    if press
        if key = "back"
            isScreensLeft = CloseLastScreen()
            return isScreensLeft
        end if
    end if
    return false
end function


' ______________
' Screen Stack
sub ShowScreen(screen)
    lastScreen = m.screenStackUI.getChild(m.screenStackUI.GetChildCount()-1)
    m.screenStackUI.appendChild(screen)
    screen.setFocus(true)
    screen.ObserveField("close", "__OnScreenCloseSet")
    if lastScreen <> invalid then lastScreen.visible = false
    screen.wasShown = true
    ? "ShowScreen ";m.screenStackUI.GetChildCount()
end sub

sub __OnScreenCloseSet(event as Object)
    CloseLastScreen()
end sub

function CloseLastScreen()
    lastScreen = m.screenStackUI.getChild(m.screenStackUI.GetChildCount()-1)
    if lastScreen <> invalid then
        lastScreen.wasClosed = true
        m.screenStackUI.removeChild(lastScreen)
    end if
    lastScreen = m.screenStackUI.getChild(m.screenStackUI.GetChildCount()-1)
    if lastScreen <> invalid
        lastScreen.visible = true
        lastScreen.setFocus(true)
    end if
    ? "CloseLastScreen ";m.screenStackUI.GetChildCount()
    return m.screenStackUI.getchildcount() > 0
end function


