--picker
local composer = require('composer')
local scene = composer.newScene()
local data  = require('lib.data')
local widget = require('widget')

function scene:create(event)
    local center = data.center
    local h = data.h
    local w = data.w
    local view = self.view
    
    local rectTop   = h/2
    local rectWidth = w*0.9
    local rectHeight = h*0.8
    
    local fontSize = 20

    local params = event.params.data
    local func    = event.params.func
    local position    = event.params.position
    local key = position.key
    local posY = position.posY
    
    local scrollView = widget.newScrollView
    {
        horizontalScrollDisabled = true,
        top = 0,
        left = 0,
        width = w,
        height = h,
        scrollWidth = 0,
        scrollHeight =h,
        listener = function()

        end,
    }
    view:insert(scrollView)
    local k,v,checked
    for k,v in pairs(params) do
        local grp = display.newGroup()
        scrollView:insert(grp)
        
        local rect = display.newRect(grp,
                                     w-fontSize*2*0.8,
                                     fontSize*0.2,
                                     fontSize*2*0.8,
                                     fontSize*2*0.8
                                     )
        rect.anchorY = 0
        if key ~= nil and k==key then
            checked = rect
            rect:setFillColor(0.6,0.6,0,0.5)   
        else
            rect:setFillColor(1,1,1,0.5)
        end
        
        rect:setStrokeColor( 0.8, 0.8, 0.8,0.5)
        rect.strokeWidth = 1
        
        rect:addEventListener(
            'touch' ,
            function(event)
                if event.phase == 'began' then
                    if checked ~= nil then
                        checked:setFillColor(1,1,1,0.5)
                    end
                    rect:setFillColor(0.6,0.6,0,0.5)   
                end
            end
        )
        rect:addEventListener(
            'tap' ,
             function(event)
                local x,y = scrollView:getContentPosition()
                print(y)
                local selected = {
                                  key=k,
                                  posY=y,
                                  text=v.text,
                                  value=v.value
                                  }
                if func ~= nil then
                    func(selected)
                end
                composer.hideOverlay( 'slideDown', 400 ) 
            end
        )
        
        local line = display.newLine(grp,0,fontSize*2,w,fontSize*2)
        line:setStrokeColor( 0.8, 0.8, 0.8 )
        line.strokeWidth = 1
        
        local text = display.newText(grp,v.text,0,fontSize,native.systemFont,fontSize)
        text.anchorX = 0
        text.x = w - w*0.96
        text:setFillColor(0,0,0)
        grp.y = fontSize*2*(k-1)
    end    
    
    if posY ~= nil then
        local options = {
            y=posY
        }
        scrollView:scrollToPosition(options)
    end
    
end

function scene:destroy(event)
    display.remove(self.view)
    self.view = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
