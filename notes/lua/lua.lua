a,b,c,e = 1,2,"hello",'500'
print("hello world!")
print(a,type(b),type(c),type(e))

print(tonumber(e)+a)

print(e+a)
print(tostring(b)..c)



print('true and false的结果',true and false)
print('true or false的结果',true or false)
print('true and true的结果',true and true)
print('false or false的结果',false or false)
print('not false的结果',not false)
print('123 and 345的结果',123 and 345)
print('nil and true的结果',nil and true)


function gt10( num )
if num<10 then
    print("num 小于10")
else 
    print("num 大于10")
end
end

aa = gt10
gt10(2)
aa(50)

aaa = function()
print('hello lua')
end

aaa()


str = 'hello'

aaaa = function()
local str1 = str..'lua'
print(str1)
end

aaaa()
print(str,str1)

function add(a,b )
    return a+b
end

print(add(1,2))

t1 = {1,2,3,4,5,6,7,8}
print(t1[8])

t2 = {
    ['banana'] = 1,
    apple = 2
}
print(t2['apple'])
print(t2['banana'])
print(t2.apple)
t2.new = 'new table'
print('t2.new :',t2.new)


print('_G 为全局变量：',_G)
_G.hello = 'hello'
print(_G.hello)
_G.print("hello ")


_G["@#$"] = 123

result = _G["@#$"]
print("result值为",result)

print(table.concat(t1,','))

n = 1
while(n<100) do
    t1[n] = n
    n = n+1
end

print(table.concat(t1))
 
 result = 0

 for i =1 ,100,10 do
 result = result + i
  if result>100 then
    break
    end
 end

 print(result)

 -- 循环测试题1（自测题）
 -- 前面我们学习了循环语句，我们需要完成下面的任务
 -- 我们知道，print函数可以打印一行完整的输出
 -- 那么，已知变量a，请打印出下面的结果：
 --（a为大于0的整数，且需要输出a行数据，数据从1开始，每行与上一行的差为2）

function printa(a) 
	a = 1
	b = 1
	while(a<100) do
		if b > a then
			break
		end
		print(a)
		a = a +2
		b = b+1
	end
 end
printa(5)