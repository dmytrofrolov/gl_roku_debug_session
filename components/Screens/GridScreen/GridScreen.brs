
sub init()
    m.grid = m.top.findNode("grid")

    m.top.ObserveField("content", "OnContentSet")
    m.top.ObserveField("focusedChild", "OnFocusedChildChanged")
end sub


sub OnFocusedChildChanged(event as Object)
    if m.top.IsInFocusChain() and not m.grid.hasFocus() and m.top.visible
        m.grid.SetFocus(true)
    end if
end sub


sub OnContentSet(event as Object)
    content = event.getData()
    m.grid.content = content
end sub


function fun(a as Dynamic)
    ? "GlobalContainer a == ";a
    return RND(10)
end function
