Library "Roku_Ads.brs"

sub init()
    m.top.functionName = "run"
end sub

sub run()
    raf = Roku_Ads()
    raf.setAdUrl("https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/single_ad_samples&ciu_szs=300x250&impl=s&gdfp_req=1&env=vp&output=vast&unviewed_position_start=1&cust_params=deployment%3Ddevsite%26sample_ct%3Dlinear&correlator="+RND(100).toStr())
    ads = raf.getAds()
    isPlayed = raf.showAds(ads, invalid, m.top.video.getParent())
    if isPlayed then
        m.top.video.control = "play"
    else
        m.top.video.GetParent().close = true
    end if
end sub
