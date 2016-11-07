# Contributing to pcl-compiler

These are recommendations. They should be followed in the absence of good, justifiable reasons to do things differently.

## Branches

* Feature branches are named like "[developer initials]-[feature-name]", e.g. __kg-new-settings-page__
* feature branches are cut from the __development__ branch, and get merged into it
* the __master__ branch matches what is in production

### Start a new feature branch

```shell
$ git checkout development
$ git pull --rebase
$ git checkout -b [new feature branch name] #-b causes a new branch and then checkout it
$ git push -u origin [new feature branch name] #To push it to the remote repository
```

## Commits

* Each commit into the main branch should contain only one particular change.
* Commit frequently during your work,
  each time a dedicated change is done and the tests pass (if required).
  Don't accumulate dozens of changes before committing.
  Rather, get into the habit of doing one thing at a time,
  reviewing and committing it when done,
  then doing the next.
* Always review your work before committing it.
* Squash the commits on your feature branch,
  or do a squash commit when merging/rebasing into the main branch,
  so that it appears there as a single atomic commit.
* Write [good commit messages](http://chris.beams.io/posts/git-commit):
  A 50 character summary written in imperative ("fix signup")
  or as a short summary for features ("logout button"),
  followed by an empty line,
  followed by an optional longer description.
  
  ## Staying in sync

It is important that you keep your feature branches in sync with the main _development_ branch.
This prevents merge conflicts from building up, and lets you deal with them one at a time. The goal is
to avoid fixing conflicts all at once when you want to merge your feature branch into development.

```shell
$ git checkout development
$ git pull --rebase
$ git checkout [feature branch]
$ git pull --rebase
$ git merge-base [feature branch] development
$ git rebase -i ${HASH}  # Read ${HASH} meaning below
$ git rebase development # You may get conflicts while doing this step so: if you do, read "Resolving conflicts" section
$ git push -f # Read "Force-push to update your pull request" section, first
# To Finish: Create the pull request on the Github page of the project
```

Note that you should *replace* `${HASH}` with the actual commit hash from the previous command. For example, if your merge-base is `abc123`, you would run `$ git rebase -i abc123`. (Your hash will be a lot longer than 6 characters. Also, do NOT include a `$`!)

## Squash your changes

Once you've run a `git rebase -i` command, your text editor will open with a file that lists all the commits in your branch, and in front of each commit is the word "pick". It looks something like this:

```
pick 1fc6c95 do something
pick 6b2481b do something else
pick dd1475d changed some things
pick c619268 fixing typos
```

For every line *except the first*, you want to replace the word "pick" with the word "squash". It should end up looking like this:

```
pick 1fc6c95 do something
squash 6b2481b do something else
squash dd1475d changed some things
squash c619268 fixing typos
```

Save and close the file, and a moment later a new file should pop up in your editor, combining all the commit messages of all the commits. Reword this commit message as you want, and then save and close that file as well. This commit message will be the commit message for the one, big commit that you are squashing all of your larger commits into. Once you've saved and closed that file, your commits have been squashed together, and you're done with this step!

## Resolving conflicts

Conflicts happen when two developers change the same line in the same file at the same time.
To resolve them
* use `git status` to see which files have conflicts
* open the conflicting files in your editor and resolve the conflicts. Make sure you consider that both sides of the conflict contain changes that happened at the same time, so both changes should be present in your resolved code.

```shell
# resolve conflicts in your text editor
$ git add [path of resolved file]
$ git rebase --continue
```
## Force-push to update your pull request

When doing force pushes, it is *highly* recommended that you set your `push.default` config setting to `simple`, which is the default in Git 2.0. To make sure that your config is correct, run:

```shell
$ git config --global push.default simple
```

Once it's correct, you can just run:
```shell
$ git push -f
```

And check your pull request. It should be updated!
