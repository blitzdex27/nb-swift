# Working with git tags

- Git tags are useful when versioning your builds.
- You can directly use `git checkout <tag>` if you need to go back and check specific build on your repository

## Adding git tags

Tagging latest commit:

```
git tag -a 1.0.0 -m <description>
```

Tagging specific commit:

```
git tag -a 1.0.0 <commit-hash> -m <description>
```

Without annotation:

```
git tag 1.0.0 #latest commit
git tag 1.0.0 <commit-hash> #specific commit
```

## Deleting git tags

1. List all tags, then copy the tag

```
git tag
```

2. delete the tag locally

```
git tag -d 1.0.0
```

3. delete the tag on remote

```
git push origin :refs/tags/1.0.0

#or
git push --delete origin 1.0.0
```

## Best practices:
- List tags before deleting tag to make sure you delete the right tag
- Communicate with your team before deleting tags
