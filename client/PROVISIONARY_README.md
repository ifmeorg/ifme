# How to Run

## StoryBook
`yarn run storybook`

## Tests
`yarn test:watch`

## ESlint
`yarn eslint app`

## Flow
`yarn flow`

### NPM Packages
Some NPM packages have flow type enabled but fail the flow checks (e.g. radium). You'll want to put the package path under the `[ignore]` section of `.flowconfig`, for example:

```
[ignore]
.*/node_modules/radium/.*
```

If you're wondering why we don't just ignore the entire `node_modules` folder, it's because some NPM Packages _do_ have correct type definitions, and we don't want to ignore those.
