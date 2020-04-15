# Issues observed

Reaction 1: 
1. erb file: SkipToContent component is above the Header component:
2. logo is attaching to menu instead of hanging in the left OR

Reaction 2: 
1. erb file: SkipToContent component is below the Header:
2. SkipToContent component doesn't work 😭

Hypothesis: SCSS is bloody affecting things

# To solve the issue we still need...

1. To know what Main Content is 😫
2. What we did: we added an id inside of:
   <div class="dashboardSection" id="mainContent"> &
   <div class="staticContent" id="mainContent">

Issue perceived: 
1. Tabbing into Contributers creates a "pop up" that is too much and also stops when tabbing back (shift + tab)

# References

https://webaim.org/techniques/css/invisiblecontent/#skipnavlinks
https://webaim.org/techniques/keyboard/