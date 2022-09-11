call _build

cd _site
git add .
git commit -m "automatic commit"
call %~dp0../push_with_auth.cmd

cd ..
git add .
git commit -m "automatic commit"
call %~dp0../push_with_auth.cmd

pause