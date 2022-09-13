I think `git-worktree`, and deployment from a seperate branch, is a cleaner alternative, since I won't have commits in my `main` branch, intermingled with commits from re-deployment, which I find more succinct, and I won't have to delete the remote branch every time, if I use `git subtree`, which is unnecessary. 

`git-worktree` mounts your sub-directory, `dist`, in this example, to a separate branch, `gh-pages`.

Here's how:

```console
git branch --track gh-pages origin/gh-pages # Create new gh-pages branch; Add tracking    
git checkout --orphan gh-pages              # Initialize gh-pages without main's history
git reset --hard                            # Remove all history
git commit --allow-empty -m "Init"          # First commit without any files
git checkout main                           # Go back to main (or master) branch
git worktree add dist gh-pages              # Mount dist and bind it to the gh-pages branch
```

 `dist` is an `npm` build script which looks like:
```javascript
"scripts": {
  ...
  "dist": "ng build --configuration production && echo 'gitdir: /home/<user>/<repo>/.git/worktrees/dist' > ./dist/.git"
  ...
}
```
All it does is re-creates the `git-worktree` reference, because the `.git` file in `dist` was removed by `ng build` by default. 
This reference is needed by `git` to link `dist` to the index.

And the workflow goes something like this:
```console
npm run dist            # Build website with new changes; Removes dist and re-creates it
cd dist                 # Move to gh-pages branch by switching into a directory (cool huh)
git add .               # Add all generated files to staging area
git commit -m "v0.0.3"  # Update the version history of the gh-pages branch
git push                # Push changes to gh-branch
```
If you run `git status` it will reply `On branch  gh-pages`.  
And `git log` will show one commit `"Init"`.

But when you `cd ..` and run `git status` again, the response will be `On branch main`.  
And `git log` will show all of your original commits to `main`.

So what's happened here is quite interesting. The folder `dist` now has a separate branch, with it's own, unrelated history to `main`, 
and all you have to do to switch is `cd dist` to access that branch (`gh-pages`).

This is unlike `git checkout dist`, which would append the `dist` directory, with the auto generated build files to your working tree, intermingling your `main` and deployment histories, which is inconvenient. 

Here your `src` files will be untouched, along with their own history in `main`, or `cd ..`, and only the files needed for deployment, will be on this branch, which is really convenient, because it keeps the `src` history seperate from the deployment history.

Now you'd deploy **not** from a folder, but from a branch, which holds the latest compiled version of your site in GitHub pages, and is built from `/(root)`.

> index.html is under build/, so I want to make that the default www path.

Here make certain that the repo that you've created is `<username>.github.io`. I made this same mistake, by having a different repo name, and was frustrated.

> So when users hit username.github.io it renders the content within that subdirectory and yet it doesn't show "/build/" on the URL, cause that's set as the root folder.

Of course there's probably an improvement that could be done here as well. 
For example make `npm run dist` do all of this, but my personal preference is to do these steps manually.

Read more about this method [here](https://sangsoonam.github.io/2019/02/08/using-git-worktree-to-deploy-github-pages.html).

But I'd agree, that if you're working on a team, it's probably better to use a tool like [gh-pages](https://www.npmjs.com/package/gh-pages), to enforce standards in your project.
 
I hope my explanation is somewhat of a contribution as well, and not just a re-statement of the mentioned methods above.