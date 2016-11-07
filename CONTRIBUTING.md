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
  
  
