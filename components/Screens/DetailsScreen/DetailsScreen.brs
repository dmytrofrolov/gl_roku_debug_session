
sub init()
    m.title = m.top.findNode("title")
    m.poster = m.top.findNode("poster")
    m.button = m.top.findNode("button")

    m.top.ObserveField("content", "OnContentSet")
    m.top.ObserveField("focusedChild", "OnFocusedChildChanged")
end sub


sub OnFocusedChildChanged(event as Object)
    if m.top.IsInFocusChain() and m.top.visible and not m.button.HasFocus()
        m.button.SetFocus(true)
    end if
end sub


sub OnContentSet(event as Object)
    content = event.getData()
    m.title.text = content.title
    m.poster.uri = content.hdposterurl

    ? "DetailScreen fun == ";m.global.globalContainer.CallFunc("fun",[])
end sub


