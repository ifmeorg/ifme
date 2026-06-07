# CONTRIBUTION_ROADMAP.md

## 1. Context and Diagnosis

if-me.org is an open source mental health platform that allows users to share experiences with trusted people. The project uses Ruby on Rails on the backend and React on the frontend, integrated through the `react-on-rails` gem.

### Current State

The project carries significant accumulated technical debt. React was gradually inserted into the project — which originally was pure Rails with ERB — without a clear architectural strategy. The result is an inconsistent integration between the two layers, where Rails frequently assumes responsibilities that should belong to React.

### Identified Problems

**Architectural:**

- Rails builds complete form schemas, including field types, labels, validations and UI flags — responsibilities that belong to React's View layer
- React components act as passive renderers, receiving excessively processed data from Rails
- The Moment detail page uses 6 separate `react_component` calls interspersed with ERB, fragmenting the layout between two rendering engines. The same pattern exists in `strategies/show.html.erb` with 4 calls
- Pre-rendered HTML is passed as props to React components, creating XSS vectors and making testing and styling impossible

**Technical:**

- `babel-plugin-flow-react-proptypes` has known incompatibilities with imported Flow types and modern syntax, causing crashes in development
- Outdated stack: React 17, Jest 26, ESLint 7, Storybook 6.5, chart.js 2 — with growing incompatibility risks
- Deprecated webpack plugins: `optimize-css-assets-webpack-plugin`, `extract-css-chunks-webpack-plugin`, `url-loader`, `file-loader`
- Babel plugins with deprecated names: `@babel/plugin-proposal-class-properties`, `@babel/plugin-proposal-private-methods`, `@babel/plugin-proposal-private-property-in-object` — moved to `@babel/plugin-transform-*` in Babel 7.22+
- The axios package was the target of a supply chain attack in March 2026 (versions 1.14.1 and 0.30.4 compromised); although the project's current version (`^1.15.0`) was not directly affected, the incident highlights the risk of this dependency
- `stylelint ^13.7.2` — very outdated, current version is 16.x
- Font Awesome across 3 different packages with outdated versions: `@fortawesome/react-fontawesome ^0.1.4`, `@fortawesome/free-solid-svg-icons ^5.10.2`, and still `font-awesome ^4.7.0` (legacy CSS version)
- `history ^4.9.0` — legacy; React Router v6+ requires history v5
- `node-polyfill-webpack-plugin` present in webpack — may be unnecessary depending on actual usage
- `exact_by_default=false` in `.flowconfig` — allows inexact objects by default, reducing type safety

**Performance:**

- N+1 queries in `ViewersHelper` and `CommentsFormHelper` — one query per viewer per form
- `@babel/polyfill` and `es5-shim` unnecessary with current configurations

### Positive Points

Components that already follow the ideal architecture — `CrisisPrevention`, `MomentTemplates`, `CarePlanContacts`, `Notifications` — serve as reference for the correct Rails/React integration pattern.

---

## 2. Guiding Principles

These principles guide all contribution decisions:

1. **Rails is a data provider, not a UI builder** — Rails should provide structured and clean data; React is responsible for the entire presentation layer
2. **Small and explicit contracts** — each integration point between Rails and React must be minimal, clear and well-defined
3. **Autonomous components** — each React component must be able to function and be tested independently of Rails
4. **Stability before modernization** — the development environment must be stable before any architectural refactoring
5. **Small and focused PRs** — each PR must have a clear and unique scope, facilitating review and rollback
6. **Verify before submitting** — no PR should be opened without local verification that nothing broke

---

## 3. Architectural Strategy

### Short-term Vision

Stabilize the development environment and modernize critical dependencies, ensuring the project works consistently across development, testing and production.

### Medium-term Vision

Clearly delineate responsibility layers — Rails as data API, React as the complete presentation layer. Strengthen existing contracts and eliminate unnecessary coupling.

### Long-term Vision

Complete migration to TypeScript, which will be natural and efficient after contracts are clean and well-defined. With autonomous components and small contracts, typing is precise and migration is incremental. The project maintainer has confirmed interest in this migration.

### Ideal Architecture

```
Rails (Model + Controller)
    ↓ clean and minimal data
react-on-rails (initialization bridge)
    ↓ initial props
React (complete View)
    → manages state
    → defines UI
    → controls forms
    → makes requests via native fetch (after B3)
```

---

## 4. Tasks

### CATEGORY A — Environment Stabilization

---

#### A1 — Remove babel-plugin-flow-react-proptypes

**Summary:** Remove the plugin that automatically generates PropTypes from Flow types, eliminating development crashes caused by known incompatibilities.

**Context:** The `babel-plugin-flow-react-proptypes` plugin is configured only in development (`.babelrc`). It has two critical incompatibilities: it does not support the `...$Exact<>` Flow syntax and cannot resolve types imported from other modules, generating `ReferenceError: bpfrpt_proptype_* is not defined` at runtime. Both issues are known limitations of the plugin — [issue #157](https://github.com/brigand/babel-plugin-flow-react-proptypes/issues/157) in the official repository. The project already uses Flow for static compile-time validation, making runtime-generated PropTypes redundant.

> **Note:** The project maintainer is investigating a fix for Flow that may resolve some of these instabilities. Wait for her response before executing this task.

**What to do:**

1. Remove `flow-react-proptypes` from the `development.plugins` section in `client/.babelrc`
2. Restart the development container
3. Navigate through all app pages checking the browser console for errors
4. Verify all tests pass with `docker compose run app yarn test`
5. Revert previously applied workarounds: remove the `'no babel-plugin-flow-react-proptypes'` flag from `InputTag.jsx` and restore the original syntax in `Form/utils.js`

**Impact:** Stable development environment, without crashes caused by the plugin. Consistent behavior between development, testing and production.

**Complexity:** Low

**Dependencies:** None

**Completion criteria:**

- [ ]  Plugin removed from `.babelrc`
- [ ]  No errors related to `bpfrpt_proptype_*` in browser console
- [ ]  All forms rendering correctly
- [ ]  Tests passing

---

#### A2 — Update Jest 26 → 29 - [COMPLETED ✔]

**Summary:** Update the testing framework to a version compatible with Node 20, eliminating known instabilities.

**Context:** The project uses Jest 26 with Node 20. Jest 26 was not designed for Node 20 and exhibits unstable behavior. Additionally, the plugin is disabled in tests, creating divergence between the development environment and CI — bugs that appear in the browser may not be caught by tests.

**What to do:**

1. Update `jest` and `babel-jest` from `^26.x` to `^29.x` in `client/package.json`
2. Update `@testing-library/react` to `^14.x`
3. Update `react-test-renderer` to the same React version (required if D1 is executed)
4. Add `jest-environment-jsdom` as an explicit dependency — it became a separate package in Jest 28+
5. Check breaking changes between Jest 26 and 29 in the official documentation
6. Run `yarn install` and `yarn test` verifying all tests pass
7. Fix any breaks caused by the update

**Impact:** Reliable test suite compatible with Node 20. Solid foundation for adding new tests.

**Complexity:** Low/Medium

**Dependencies:** None

**Completion criteria:**

- [ ]  Jest 29 installed
- [ ]  `jest-environment-jsdom` added as explicit dependency
- [ ]  All existing tests passing
- [ ]  No incompatibility warnings with Node 20

---

#### A3 — Add test coverage with thresholds - [COMPLETED ✔]

**Summary:** Configure minimum test coverage and mandatory thresholds, establishing a quality baseline.

**Context:** The project has moderate unit tests but no minimum coverage configuration. After updating Jest (A2), it is the ideal time to establish thresholds that prevent coverage regressions.

**What to do:**

1. Configure `collectCoverageFrom` in `jest.config.js` with appropriate globs (e.g.: `app/**/*.{js,jsx}`, excluding stories and mocks)
2. Define conservative initial minimum thresholds (e.g.: 50% statements/branches/functions/lines)
3. Add `yarn test:coverage` script to `package.json`
4. Integrate coverage verification in CI (GitHub Actions)

**Impact:** Quality baseline established, coverage regressions automatically detected in CI.

**Complexity:** Low

**Dependencies:** A2

**Completion criteria:**

- [ ]  `collectCoverageFrom` configured
- [ ]  Thresholds defined and passing
- [ ]  `yarn test:coverage` script working
- [ ]  CI verifying coverage

---

### CATEGORY B — Dependency Modernization

---

#### B1 — Replace deprecated webpack plugins and update Babel plugins - [COMPLETED ✔]

**Summary:** Replace deprecated Webpack 5 plugins and loaders with modern alternatives, and update Babel plugins with old names.

**Context:** The project uses Webpack 5 but still uses Webpack 4 era plugins that have been deprecated. Additionally, `.babelrc` uses `@babel/plugin-proposal-*` that were renamed to `@babel/plugin-transform-*` in Babel 7.22+, generating unnecessary warnings.

**What to do:**

1. Replace `optimize-css-assets-webpack-plugin` with `css-minimizer-webpack-plugin`
2. Replace `extract-css-chunks-webpack-plugin` with `mini-css-extract-plugin`
3. Replace `url-loader` and `file-loader` with native Webpack 5 Asset Modules
4. Update `client/webpack.config.js` with new configurations
5. Rename in `.babelrc`:
   - `@babel/plugin-proposal-class-properties` → `@babel/plugin-transform-class-properties`
   - `@babel/plugin-proposal-private-methods` → `@babel/plugin-transform-private-methods`
   - `@babel/plugin-proposal-private-property-in-object` → `@babel/plugin-transform-private-property-in-object`
6. Verify build and visual functionality of the app

**Impact:** More modern build, without deprecation warnings, lower risk of future incompatibilities.

**Complexity:** Medium

**Dependencies:** None

**Completion criteria:**

- [ ]  Deprecated webpack plugins removed
- [ ]  Babel plugins renamed
- [ ]  Build working without deprecation warnings
- [ ]  App functioning visually identical to before

---

#### B2 — Update ESLint 7 → 9 and Stylelint 13 → 16

**Summary:** Update linters to current versions, adopting new configuration formats.

**Context:** ESLint 9 completely changed the configuration format — from `.eslintrc` to `eslint.config.js`. Stylelint 13.7 is also very outdated (current is 16.x). Both should be updated together as complementary linting tools.

**What to do:**

1. Update `eslint` to `^9.x` in `client/package.json`
2. Migrate `.eslintrc` to `eslint.config.js` following the official migration guide
3. Update related ESLint plugins (airbnb config, etc.)
4. Update `stylelint` to `^16.x`
5. Migrate `.stylelintrc` to the new configuration format
6. Verify and fix any new warnings/errors in both

**Impact:** Updated linting, better detection of code and style problems.

**Complexity:** Medium

**Dependencies:** None

**Completion criteria:**

- [ ]  ESLint 9 installed and configured
- [ ]  Stylelint 16 installed and configured
- [ ]  No unexpected linting errors

---

#### B3 — Replace axios with native fetch

**Summary:** Replace the axios library with native Node.js/browser fetch, eliminating a critical external dependency.

**Context:** The axios package was the target of a supply chain attack in March 2026 (versions 1.14.1 and 0.30.4 compromised with RAT attributed to a North Korean state actor). Although the project's current version (`^1.15.0`) was not directly affected, the incident highlights the risk of external dependencies for critical operations like HTTP requests. Node 20 and modern browsers already have native `fetch` with full support.

**What to do:**

1. Map all axios usages in the project
2. Create a custom fetch wrapper with the same interfaces used by axios in the project
3. Gradually replace each usage — starting with the simplest components
4. Remove axios from `package.json` after all replacements

**Impact:** Elimination of critical external dependency, bundle size reduction, supply chain risk elimination.

**Complexity:** Medium

**Dependencies:** None — but recommended after A1 and A2

**Completion criteria:**

- [ ]  No references to axios in code
- [ ]  All requests working with native fetch
- [ ]  Tests passing

---

#### B4 — Update Storybook 6.5 → 8

**Summary:** Update Storybook to the current version, making it usable for component development.

**Context:** Storybook 6.5 is EOL. The current version is 8.x with a completely new configuration API and native Webpack 5 builder. After architectural stabilization, Storybook will be essential for developing React components in isolation, without backend dependency.

**What to do:**

1. Follow the official Storybook 6 → 8 migration guide
2. Migrate configuration files
3. Adopt the native Webpack 5 builder
4. Verify all existing stories work
5. Update broken stories

**Impact:** Storybook usable for component development and documentation.

**Complexity:** Medium

**Dependencies:** Recommended after B1 (webpack plugins updated)

**Completion criteria:**

- [ ]  Storybook 8 running
- [ ]  Existing stories working
- [ ]  Webpack 5 builder configured

---

#### B5 — Remove unnecessary polyfills and investigate node-polyfill-webpack-plugin - [COMPLETED ✔]

**Summary:** Remove unnecessary polyfills that increase bundle size without real benefit.

**Context:** The project already uses `@babel/preset-env` with `useBuiltIns: 'usage'` and `core-js@3`, which automatically manage polyfills based on browserslist. `@babel/polyfill` is deprecated and `es5-shim` is unnecessary for modern targets. Additionally, `node-polyfill-webpack-plugin` is present in `webpack.config.js` and may be unnecessary depending on actual Node API usage in client code.

**What to do:**

1. Remove `@babel/polyfill` and `es5-shim`/`es5-sham` from `package.json` and webpack entry point
2. Verify `core-js@3` is covering necessary polyfills
3. Investigate which Node.js APIs `node-polyfill-webpack-plugin` is polyfilling
4. If there is no real usage, remove the plugin as well
5. Test the app in target browsers

**Impact:** Smaller bundle, less unnecessary code.

**Complexity:** Low

**Dependencies:** None

**Completion criteria:**

- [ ]  Polyfills removed
- [ ]  `node-polyfill-webpack-plugin` evaluated and removed if unnecessary
- [ ]  App working in target browsers
- [ ]  Bundle size reduced

---

#### B7 — Update Font Awesome 5 → 6

**Summary:** Consolidate and update Font Awesome packages to the current version.

**Context:** The project uses Font Awesome across 3 different packages with mixed versions: `@fortawesome/fontawesome-svg-core ^1.2.22`, `@fortawesome/free-solid-svg-icons ^5.10.2`, `@fortawesome/react-fontawesome ^0.1.4`, and still `font-awesome ^4.7.0` (legacy CSS version). FA6 is the current version. Some icon names changed between v5 and v6.

**What to do:**

1. Map all Font Awesome icon usages in the project
2. Update all `@fortawesome/*` packages to v6
3. Remove `font-awesome ^4.7.0` (legacy CSS version)
4. Fix icon names that changed between v5 and v6
5. Visually verify all pages

**Impact:** Consolidated and updated icon dependency, removal of legacy CSS package.

**Complexity:** Low/Medium

**Dependencies:** None

**Completion criteria:**

- [ ]  All `@fortawesome/*` packages at v6
- [ ]  `font-awesome ^4.7.0` removed
- [ ]  All icons displaying correctly

---

#### B8 — Update history 4 → 5

**Summary:** Update the `history` library to the version compatible with React Router v6.

**Context:** `history ^4.9.0` is legacy. React Router v6+ requires history v5. If there are plans to adopt React Router v6, this update will be necessary.

**What to do:**

1. Check all `history` usages in the project
2. Evaluate whether there are plans for React Router v6 migration
3. Update to `history ^5.x` adjusting the API where necessary

**Impact:** Compatibility with React Router v6, updated dependency.

**Complexity:** Low/Medium

**Dependencies:** Evaluate together with D1 (React 18)

**Completion criteria:**

- [ ]  `history` updated to v5
- [ ]  No navigation breaks
- [ ]  Tests passing

---

### CATEGORY C — Contract Strengthening

---

#### C0 — Enable exact_by_default=true in Flow

**Summary:** Enable exact types by default in Flow, increasing type safety while the project still uses Flow.

**Context:** The `.flowconfig` has `exact_by_default=false`, which allows objects to accept extra undeclared properties. This reduces the effectiveness of type checking and can cause inconsistencies with generated PropTypes. Enabling `exact_by_default=true` will make types safer and more consistent.

**What to do:**

1. Change `exact_by_default=false` to `exact_by_default=true` in `.flowconfig`
2. Run `yarn flow` to identify all introduced errors
3. Fix errors incrementally — start with the simplest components
4. Verify tests continue passing

**Impact:** Safer and more consistent Flow types, reduction of silent bugs.

**Complexity:** Medium

**Dependencies:** Recommended after A1

**Completion criteria:**

- [ ]  `exact_by_default=true` in `.flowconfig`
- [ ]  No pending Flow errors
- [ ]  Tests passing

---

#### C1 — Create JSON endpoints for domain data

**Summary:** Create JSON endpoints that return clean and structured data, preparing the foundation for architectural migration.

**Context:** Currently Rails serializes data directly in form helpers, mixing data with UI logic. For React to take responsibility for forms and lists, Rails needs to provide data via clean JSON endpoints. This is Phase 1 of the migration path defined by the audit.

**What to do:**

1. Check which JSON endpoints already exist (`.json` format in routes)
2. Create or complete endpoints for: moments, strategies, medications, groups, meetings, categories, moods, users (lightweight), moment_templates, comments
3. Ensure each endpoint returns only data — no UI flags, no pre-rendered HTML
4. Document the contract of each endpoint

**Impact:** Clean and accessible data foundation for React. Prerequisite for all subsequent architectural tasks.

**Complexity:** Medium

**Dependencies:** None technical, but recommended after Category A

**Completion criteria:**

- [ ]  JSON endpoints working for each domain
- [ ]  Data returned without UI logic
- [ ]  Documentation of each endpoint contract

---

#### C2 — Migrate Form to React-owned schema

**Summary:** Transfer form construction responsibility from Rails to React, eliminating form helpers.

**Context:** This is the highest impact and highest ROI task in the project. Currently 7 Rails helpers build complete form schemas: `MomentsFormHelper`, `StrategiesFormHelper`, `MedicationsFormHelper`, `GroupsFormHelper`, `MeetingsFormHelper`, `CommentsFormHelper`, and the base `FormHelper`. React receives these schemas and only renders. This violates MVC and creates N+1 queries in the database. `CrisisPrevention` and `MomentTemplates` are examples of the correct pattern that should be replicated here.

**What to do:**

1. Create React schema components per domain: `MomentForm`, `StrategyForm`, `MedicationForm`, etc.
2. Each component defines its own fields, types, labels, validations and UI flags
3. Update Rails helpers to return only `{ action, record, associations }` via JSON
4. Migrate one form at a time — start with the simplest (suggestion: `CategoryForm`)
5. Gradually eliminate Rails form helpers

**Impact:** Eliminates N+1 queries, enables form development in Storybook, makes forms testable independently of Rails, removes critical coupling.

**Complexity:** High

**Dependencies:** C1

**Completion criteria:**

- [ ]  Each form defined as an autonomous React component
- [ ]  Rails passes only data — no field types, labels or validations
- [ ]  Rails form helpers eliminated or drastically simplified
- [ ]  Tests covering each FormSchema

---

#### C3 — Migrate Story to React-owned presentation

**Summary:** Move Story presentation logic from Rails to React, eliminating pre-rendered HTML in props.

**Context:** The `present_moment_or_strategy` helper mixes data with presentation — generates HTML links with `link_to`, resolves viewer names with N+1 queries, calculates visibility labels. The `storyBy.author` field contains HTML generated by Rails — XSS vector and impossible to test. This pattern affects all index pages and the home page.

**What to do:**

1. Simplify `present_moment_or_strategy` to return only raw data
2. Move link generation to React
3. Move viewer name resolution to React
4. Move date formatting to React
5. Move draft and visibility labels to React
6. Eliminate pre-rendered HTML in props

**Impact:** Eliminates XSS vector, eliminates N+1 queries, makes Story testable, enables Storybook development.

**Complexity:** High

**Dependencies:** C1

**Completion criteria:**

- [ ]  No pre-rendered HTML in Story props
- [ ]  Rails returns only raw data for Story
- [ ]  N+1 queries eliminated
- [ ]  Tests covering presentation logic in React

---

#### C4 — Migrate Comments to React-owned form and viewer resolution

**Summary:** Complete the Comments widget migration by transferring form construction and viewer resolution to React.

**Context:** Comments already has autonomous React behavior — submit and delete via axios. But the form is still built by Rails (`CommentsFormHelper`) and viewer names are resolved with database queries. It is a half-finished migration that needs to be completed.

**What to do:**

1. Create comment form schema directly in the React component
2. Replace viewer resolution in Rails with a `GET /viewers` endpoint that returns `[{id, name}]`
3. Update the widget to fetch viewers via API
4. Simplify `CommentsFormHelper` until it can be eliminated

**Impact:** Fully autonomous Comments, N+1 queries eliminated, testable form.

**Complexity:** Medium

**Dependencies:** C1

**Completion criteria:**

- [ ]  Form schema defined in React
- [ ]  Viewers fetched via API
- [ ]  `CommentsFormHelper` eliminated
- [ ]  Tests covering the complete widget

---

#### C5 — Convert dashboard_nav_mobile to React component

**Summary:** Convert the Rails partial `_dashboard_nav_mobile.html.erb` to a React component, eliminating injected HTML in the Header.

**Context:** The Header receives a `mobileOnly` prop containing pre-rendered HTML from the `_dashboard_nav_mobile` partial (confirmed in `header_helper.rb` line 51). This breaks the React component model and prevents proper testing and styling. Affects all pages of the application.

**What to do:**

1. Create `DashboardNavMobile` React component
2. Pass only necessary data (links, current user) as props
3. Update Header to use the new component
4. Remove ERB partial

**Impact:** Header completely in React, without injected HTML, testable and styleable.

**Complexity:** Medium

**Dependencies:** None technical

**Completion criteria:**

- [ ]  ERB partial removed
- [ ]  React component working in all screen sizes
- [ ]  Header without `mobileOnly` prop

---

#### C6 — Consolidate fragmented detail pages

**Summary:** Replace multiple separate `react_component` calls on detail pages with a single React page component.

**Context:** The pages `moments/show.html.erb` and `strategies/show.html.erb` use multiple `react_component` calls interspersed with ERB (6 calls in moments/show, 4 in strategies/show). This divides the layout between two rendering engines, making it impossible to test and maintain the page as a unit.

**What to do:**

1. Create `MomentShow` and `StrategyShow` components
2. Each component receives the complete record and renders all sub-components internally
3. Replace multiple `react_component` calls with a single call per page
4. Remove interspersed ERB

**Impact:** Detail pages completely in React, testable as a unit, layout controlled by React.

**Complexity:** High

**Dependencies:** C2, C3

**Completion criteria:**

- [ ]  A single `react_component` call per detail page
- [ ]  No ERB interspersed with React
- [ ]  Layout working identically to current in `moments/show` and `strategies/show`

---

### CATEGORY D — Stack Modernization

---

#### D1 — Update React 17 → 18

**Summary:** Update React to the current version, enabling Concurrent Features and maintaining ecosystem compatibility.

**Context:** React 17 is out of mainstream support. React 18 introduced Concurrent Mode and changed `ReactDOM.render` to `createRoot`. `react-on-rails` is fixed at version `12.0.1` (without `^`), suggesting sensitivity to updates — verifying React 18 compatibility will be critical before proceeding.

**What to do:**

1. Verify compatibility of `react-on-rails` version `12.0.1` with React 18
2. Update `react` and `react-dom` to `^18.x`
3. Migrate `ReactDOM.render` to `createRoot` where necessary
4. Update `react-test-renderer` to the same React version
5. Update `@testing-library/react` to compatible version
6. Test the entire application

**Impact:** Current React, modern ecosystem compatibility, access to Concurrent Features.

**Complexity:** High

**Dependencies:** A1, A2

**Completion criteria:**

- [ ]  React 18 installed
- [ ]  Compatibility with `react-on-rails 12.0.1` verified
- [ ]  No legacy `ReactDOM.render` usage
- [ ]  Tests passing
- [ ]  App functioning completely

---

#### D2 — Migrate chart.js 2 → 4

**Summary:** Update the charting library to the current version, which has a completely different API.

**Context:** chart.js 2.x is EOL. Version 4.x has a breaking API — all components using charts will need to be rewritten. It is the most labor-intensive migration in the dependency category.

**What to do:**

1. Map all chart.js usages in the project
2. Study API differences between v2 and v4
3. Rewrite chart components using the new API
4. Update `react-chartkick` or replace with direct Chart.js usage

**Impact:** Current and maintained charting library.

**Complexity:** High

**Dependencies:** D1 recommended

**Completion criteria:**

- [ ]  chart.js 4 installed
- [ ]  All charts working correctly
- [ ]  No usage of old API

---

### CATEGORY E — Long Term

---

#### E1 — TypeScript Migration

**Summary:** Migrate the frontend from Flow to TypeScript, unifying the type system and eliminating all identified inconsistencies.

**Context:** This is the definitive solution for the project's typing problems. The maintainer has confirmed interest in this migration. With clean contracts and autonomous components (result of categories A, B and C), the migration will be natural and incremental. TypeScript eliminates the need for Flow + PropTypes + babel-plugin, unifying everything in a single consistent typing layer across all environments.

**What to do:**

1. Configure TypeScript + Webpack + Babel for coexistence with Flow during migration
2. Migrate file by file — starting with the simplest and most autonomous components
3. Create TypeScript types for each Rails/React contract defined in previous tasks
4. Gradually eliminate Flow as migration progresses
5. Remove Flow and related configurations after complete migration (the `babel-plugin-flow-react-proptypes` will already have been removed in A1)

**Impact:** Unified, safe and consistent type system. Eliminates all current complexity of Flow + PropTypes. Dramatically improves development experience.

**Complexity:** Very High

**Dependencies:** All previous categories recommended

**Completion criteria:**

- [ ]  No `.js` or `.jsx` files with Flow annotations
- [ ]  All files in `.ts` or `.tsx`
- [ ]  `tsconfig.json` configured
- [ ]  Flow and related configurations removed
- [ ]  Tests passing with ts-jest

---

## 5. Execution Sequence

```
PHASE 1 — Stabilization (start here)
A1 → A2 → A3 → B5

PHASE 2 — Dependency Modernization
B1 → B2 → B3 → B4 → B7 → B8

PHASE 3 — Architectural Foundation
C0 → C1

PHASE 4 — Contracts (execute per domain)
C2 → C3 → C4 → C5 → C6

PHASE 5 — Modern Stack
D1 → D2

PHASE 6 — Long Term
E1
```

---

## 6. Quality Criteria

Before opening any PR:

- [ ]  Code tested locally
- [ ]  No new errors in browser console
- [ ]  No new errors in container terminal
- [ ]  Existing tests passing
- [ ]  PR with single and clear scope
- [ ]  Complete PR description with context and motivation
- [ ]  Issue linked when applicable
- [ ]  Screenshots when there are visual changes

---

**Document created:** April 2026

**Last updated:** April 2026
