call _build

cd _site
git add .
git commit -m "automatic commit"
call %~dp0../push_with_auth.secret

cd ..
git add .
git commit -m "automatic commit"
call %~dp0../push_with_auth.secret

pause