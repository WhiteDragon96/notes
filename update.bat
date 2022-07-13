@echo off

set/p message=input commit message ：

echo message : %message%

git add .
git commit -m %message%
git push origin notes

pause