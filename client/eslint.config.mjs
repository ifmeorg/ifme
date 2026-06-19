import { defineConfig, globalIgnores } from "eslint/config";
import { fixupConfigRules } from "@eslint/compat";
import * as importX from "eslint-plugin-import-x";
import jest from "eslint-plugin-jest";
import globals from "globals";
import babelParser from "@babel/eslint-parser";
import path from "node:path";
import { fileURLToPath } from "node:url";
import js from "@eslint/js";
import { FlatCompat } from "@eslint/eslintrc";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all
});

export default defineConfig([
  globalIgnores(["**/flow/", "**/flow-typed/", "**/default.js", "**/translations.js"]),
  ...fixupConfigRules(
    compat.extends("airbnb", "plugin:ft-flow/recommended", "plugin:react-hooks/recommended"),
  ),
  {
    plugins: {
      "import-x": importX,
      jest,
    },
    files: ["app/**/*.js", "app/**/*.jsx"],
    languageOptions: {
      globals: {
        ...globals.browser,
        ...jest.environments.globals.globals,
      },
      parser: babelParser,
      ecmaVersion: "latest",
      sourceType: "module",
      parserOptions: {
        requireConfigFile: false,
      },
    },
    settings: {
      "import/resolver": {
        node: {
          paths: ["./app", ".."],
        },
      },
    },
    rules: {
      "linebreak-style": ["off"],
      "import/no-named-as-default": ["off"],
      "import/no-named-as-default-member": ["off"],
      "import-x/no-named-as-default": ["error"],
      "import-x/no-named-as-default-member": ["error"],
      "import/prefer-default-export": ["off"],
      "react/require-default-props": ["off"],
      "jsx-a11y/label-has-for": ["off"],
      "no-alert": ["off"],
      "react/sort-comp": [2, {
        order: [
          "type-annotations",
          "static-methods",
          "lifecycle",
          "everything-else",
          "/^render.+$/",
          "render",
        ],
      }],
      "react/prefer-stateless-function": ["off"],
      "react/prop-types": ["off"],
    },
  },
]);
