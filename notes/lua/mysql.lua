require "luasql.mysql"

--������������
env = luasql.mysql()

--�������ݿ�
conn = env:connect("austin","root","123456","localhost",3306)

--�������ݿ�ı����ʽ
conn:execute"SET NAMES UTF8"

--ִ�����ݿ����
cur = conn:execute("select * from message_template")



row = cur:fetch({},"a")

for k, v in ipairs(row) do
    print('11111',k, v)
end

--�ļ�����Ĵ���
file = io.open("role.txt","w+");

while row do
    var = string.format("%d %s\n", row.id, row.name)

    print(var)

    file:write(var)

    row = cur:fetch(row,"a")
end


file:close()  --�ر��ļ�����
conn:close()  --�ر����ݿ�����
env:close()   --�ر����ݿ⻷��
