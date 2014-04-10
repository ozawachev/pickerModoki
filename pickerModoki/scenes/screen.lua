--screen
local composer = require("composer")
local scene = composer.newScene()
local data  = require('lib.data')
local txt,key,position

function scene:create(event)
    local center = data.center
    local h = data.h
    local w = data.w
    local view = self.view
    local position = {}

    local bg = display.newRect(view,center,h/2,w,data.bgHeight)
    bg:setFillColor(0.9,0.9,0.9)

    local roundedRect = display.newRoundedRect( view,center,h/3,  w*0.8, h/10, 10) 
    local text = display.newText(view,'▼select',center,h/3,native.systemFontBold,40)
    text:setFillColor(0,0,0)

    local todofuken = {
            {text="北海道",value=1},
            {text="青森県",value=2},
            {text="秋田県",value=3},
            {text="岩手県",value=4},
            {text="宮城県",value=5},
            {text="山形県",value=6},
            {text="福島県",value=7},
            {text="栃木県",value=8},
            {text="茨城県",value=9},
            {text="新潟県",value=10},
            {text="埼玉県",value=11},
            {text="長野県",value=12},
            {text="千葉県",value=13},
            {text="東京都",value=14},
            {text="神奈川県",value=15},
            {text="山梨県",value=16},
            {text="富山県",value=17},
            {text="石川県",value=18},
            {text="福井県",value=19},
            {text="岐阜県",value=20},
            {text="愛知県",value=21},
            {text="滋賀県",value=22},
            {text="三重県",value=23},
            {text="京都府",value=24},
            {text="奈良県",value=25},
            {text="和歌山県",value=26},
            {text="兵庫県",value=27},
            {text="鳥取県",value=28},
            {text="大阪府",value=29},    
    }
    local showData
    

    local showData = function(selected)
        if selected ~= nil then
            if txt ~= nil then
                display.remove(txt)
                txt = nil
            end
            txt = display.newText(view,selected.text,data.center,h/2,native.systemFontBold,30)
            txt:setFillColor(0,0,0)
            position.key = selected.key
            position.posY = selected.posY
        end        
    end
    
    local options = {
        isModal = true,
        effect = 'slideUp',
        time = 400,
        params = {data=todofuken,func=showData,position=position}
    }
    
    roundedRect:addEventListener('touch', 
        function(event)
            if event.phase == 'began' then
                composer.showOverlay('scenes.picker',options)
            end
            
        end
    )
end

function scene:destroy(event)
    display.remove(self.view)
    self.view = nil
end


scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene


