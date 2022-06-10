@echo off

set/p message=请输入同步内容：

echo message : %message%

git add .
git commit -m '%message%'
git push origin notes

pause