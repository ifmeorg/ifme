module.exports = {
  extends: ["stylelint-config-standard-scss"],
  customSyntax: "postcss-scss",
  ignoreFiles: [
    "../node_modules/**/*.scss",
    "./node_modules/**/*.scss",
    "./app/styles/_global_font.scss"
  ],
  rules: {
    "at-rule-no-unknown": null,
    "no-descending-specificity": null,
    "selector-pseudo-class-no-unknown": [
      true,
      { "ignorePseudoClasses": ["global", "export"] }
    ],
    "selector-class-pattern": null,
    "scss/at-mixin-pattern": null,
    "scss/dollar-variable-pattern": null,
    "selector-id-pattern": null,
    "scss/load-no-partial-leading-underscore": null,
    "keyframes-name-pattern": null,
  }
};
