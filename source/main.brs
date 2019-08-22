
sub RunUserInterface(args)
    screen = CreateObject("roSGScreen")
    scene = screen.createScene("MainScene")
    screen.show()
    scene.args = args
    port = CreateObject("roMessagePort")
    while(true)
        wait(0, port)
    end while
end sub
