git branch --track gh-pages origin/gh-pages
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Init"
git checkout main
git worktree add _site gh-pages
pause