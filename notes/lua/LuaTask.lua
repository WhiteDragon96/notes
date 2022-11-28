-- LuaTask框架，利用协程，在Lua中实现了多任务功能。开发者可以用最简单的方式，
-- 新建多个任务，而不是像传统的开发方式一样，只能用定时器进行延时。
-- 当使用LuaTask框架时，需要在代码中引用sys库（_G.sys=require("sys")），
-- 并且在代码的最后一行，调用sys.run()以启动LuaTask框架，框架内的任务代码会在sys.run()中运行。
sys = require("sys")
-- 第一个任务
sys.taskInit(function()
    while true do
        log.info("task1", "wow")
        sys.wait(1000) -- 延时1秒，这段时间里可以运行其他代码
    end
end)

-- 第二个任务
sys.taskInit(function()
    while true do
        log.info("task2", "wow")
        sys.wait(500) -- 延时0.5秒，这段时间里可以运行其他代码
    end
end)

hello = function()
    print('hello luatask')
end

sys.taskInit(hello)

-- 第一个任务
sys.taskInit(function()
    while true do
        log.info("task1", "wow")
        sys.wait(1000) -- 延时1秒，这段时间里可以运行其他代码
        sys.publish("TASK1_DONE") -- 发布这个消息，此时所有在等的都会收到这条消息
    end
end)

-- 第二个任务
sys.taskInit(function()
    while true do
        sys.waitUntil("TASK1_DONE") -- 等待这个消息，这个任务阻塞在这里了
        log.info("task2", "wow")
    end
end)

-- 第三个任务
sys.taskInit(function()
    while true do
        local result = sys.waitUntil("TASK1_DONE", 500) -- 等待超时时间500ms，超过就返回false而且不等了
        log.info("task3", "wait result", result)
    end
end)

-- 单独订阅，可以当回调来用
sys.subscribe("TASK1_DONE", function()
    log.info("subscribe", "wow")
end)

sys.run()

sys.run()
