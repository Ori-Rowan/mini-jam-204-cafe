

function spr_dark(spr_n, x, y, w, h, vis_colors)
    vis_colors = vis_colors or {}
    for i=1,15 do
        if not has_value(vis_colors, i) then
            palt(i, true)
        end
    end
    pal(0,2)
    spr(spr_n,x,y,w,h)
    pal(0,0)

    for i=0,15 do
        palt(i, false)
    end
    palt(_CONFIG.default_bg_col, true)
end