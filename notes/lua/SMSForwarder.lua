PROJECT = "SMS_Forwarder"
VERSION = "1.0.0"
BARK_URL = "https://api.day.app/M8xxxxxxxx/"

require "sys"
require "http"
require "sms"
require "common"
require "cc"
require "audio"
require "net"

-- HTTP 回调，显示调试信息用
function httpCallback(result, prompt, head, body)
    if result then
        print("HTTP", prompt, body)
    else
        print("HTTP Request Failed. ", prompt)
    end
end

-- 推送信息到BARK
function notifyToBark(msg)
    http.request("GET", -- BARK_URL..string.urlEncode(msg),
    BARK_URL .. string.rawurlEncode(msg), -- 对内容中文进行编码
    nil, -- 不指定证书
    nil, nil, 30000, -- 发送超时，ms
    httpCallback, -- 回调
    nil)
end

--[[
num：短信号码，ASCII码字符串格式
data：短信内容，字符串格式
datetime：短信日期和时间，ASCII码字符串格式
]]
function smsCallback(num, data, datetime)
    print("SMS FROM ", num, " IN ", datetime)
    print(data)

    data = common.gb2312ToUtf8(data) -- 短信编码要转换为目标平台支持的UTF-8
    -- data = string.gsub(data, "*", "\\*") -- Telegram 特殊字符转义
    -- data = string.gsub(data, "_", "\\_") -- Telegram 特殊字符转义
    notifyToBark(data .. "。from：" .. num)
end

call_in = false

-- 电话拨入回调，在这里发送通知并接通电话
function call_incoming(num)
    print("CALL FROM ", num)
    if not call_in then
        call_in = true
        notifyToBark(num .. " 给您来电")
        cc.accept(num)
    end
end

-- 电话接通回调，这里播放TTS通知对方
function call_connected(num)
    print("CALL CONNECTED")
    call_in = false
    -- 通话中向对方播放TTS
    audio.play(7, "TTS", "您好，机主无法接听您的来电，请使用短信联系机主。", 7, nil, true, 2000)
    -- 30秒之后主动结束通话
    sys.timerStart(cc.hangUp, 30000, num)
end

-- 电话挂断回调，停止TTS
function call_disconnected(discReason)
    print("CALL DISCONNECTED")
    call_in = false
    sys.timerStopAll(cc.hangUp)
    audio.stop()
end

-- 定时任务：每天发送短信到10001查询流量
sys.timerLoopStart(function()
    sms.send("10001", "108", nil, nil)
end, 24 * 60 * 60 * 1000)

-- 加载网络指示灯和LTE指示灯功能模块
-- 根据自己的项目需求和硬件配置决定：1、是否加载此功能模块；2、配置指示灯引脚
-- 合宙官方出售的Air720U开发板上的网络指示灯引脚为pio.P0_1，LTE指示灯引脚为pio.P0_4
require "netLed"
pmd.ldoset(2, pmd.LDO_VLCD)
netLed.setup(true, pio.P0_1, pio.P0_4)

-- 设置短信回调
sms.setNewSmsCb(smsCallback)

-- 禁用RNDIS，防止跑流量
ril.request("AT+RNDISCALL=0,1")

-- 注册电话回调
sys.subscribe("CALL_INCOMING", call_incoming)
sys.subscribe("CALL_CONNECTED", call_connected)
sys.subscribe("CALL_DISCONNECTED", call_disconnected)

-- 每1分钟查询一次GSM信号强度
-- 每1分钟查询一次基站信息
net.startQueryAll(60000, 60000)

-- 系统初始化
sys.init(0, 0)
sys.run()
