
sub init()
    m.video = m.top.findNode("video")

    m.video.ObserveField("state", "OnStateChanged")
    m.top.ObserveField("content", "OnContentSet")
    m.top.ObserveField("focusedChild", "OnFocusedChildChanged")
    m.top.ObserveField("wasShown", "OnVideoScreenWasShown")
    m.top.ObserveField("wasClosed", "OnVideoScreenWasClosed")
end sub


sub OnFocusedChildChanged(event as Object)
    if m.top.IsInFocusChain() and m.top.visible
        m.video.SetFocus(true)
    end if
end sub


sub OnContentSet(event as Object)
    content = event.getData()
    m.video.content = content
    ' m.video.control = "play"
    ? "VideoScreen fun == ";m.global.globalContainer.CallFunc("fun",[])
end sub

sub OnVideoScreenWasShown()
    m.rafTask = CreateObject("roSGNode", "RAFTask")
    m.rafTask.video = m.video
    m.rafTask.control = "RUN"
end sub

sub OnVideoScreenWasClosed()
    m.rafTask.control = "stop"
    m.rafTask = invalid
end sub


sub OnStateChanged(event as Object)
    state = event.getData()
    if state = "finished" or state = "error"
        m.top.close = true
    end if
end sub
