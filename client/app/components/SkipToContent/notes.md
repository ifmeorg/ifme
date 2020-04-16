# Issues

1. Component file: added a variable instead of a fixed id for href: 
  ______
  function SkipToContent(props) {
  return <a className={css.test} href={"#", props.id}>Skip to main content</a>;
  }

  export default SkipToContent;
  ___
    
  In the html file, we have: 
  <%= react_component('SkipToContent', props: { id: "maincontent" }) %>

  
  and we are finding the following console error: Uncaught Error: ReactOnRails encountered an error while rendering component: SkipToContent.Original message: Could not find component registered with name SkipToContent.
   
  Could you please help????

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