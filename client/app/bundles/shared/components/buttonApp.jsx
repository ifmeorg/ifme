import React from 'react';

class buttonApp extends React.Component {
   render() {
       
       var buttonStyle = {
         fontSize: 18,
         color: '#6D0839',
         fontWeight: "bold",
         backgroundColor: '#FFFFFF',
         paddingTop: 17,
         paddingBottom: 16,
         paddingLeft: 15,
         paddingRight: 15,
         width: 203,
         borderRadius: 5,
         borderColor: '#FFFFFF'
      }
      return (
          <div>
          <ButtonFilledM/>
          <ButtonGhostM/>
          <ButtonFilled/>
          <ButtonGhost/>
          <ButtonGhostXS/>
          </div>
      );
   }
}
class ButtonFilledM extends React.Component {
   render() {
       
       var buttonStyle = {
         fontSize: 18,
         color: '#6D0839',
         fontWeight: "bold",
         backgroundColor: '#FFFFFF',
         paddingTop: 17,
         paddingBottom: 16,
         paddingLeft: 15,
         paddingRight: 15,
         width: 203,
         borderRadius: 5,
         borderColor: '#FFFFFF'
      }
      return (
          <div>
         <button style= {buttonStyle}>
            Join
         </button>
          </div>
      );
   }
}
class ButtonGhostM extends React.Component {
   render() {
       
       var buttonStyle = {
             fontSize: 18,
             color: '#FFFFFF',
             fontWeight: "bold",
             paddingTop: 17,
             paddingBottom: 16,
             paddingLeft: 48,
             paddingRight: 47,
             borderRadius: 5,
             opacity: 0.95,
      }
      return (
          <div>
         <button style= {buttonStyle}>
            Join
         </button>
          </div>
      );
   }
}
class ButtonFilled extends React.Component {
   render() {
       
       var buttonStyle = {
         fontSize: 24,
         color: '#6D0839',
         fontWeight: "bold",
         backgroundColor: '#FFFFFF',
         paddingTop: 17,
         paddingBottom: 22,
         paddingLeft: 15,
         paddingRight: 15,
         width: 203,
         borderRadius: 5,
         borderColor: '#FFFFFF'
      }
      return (
          <div>
         <button style= {buttonStyle}>
            Learn More
         </button>
          </div>
      );
   }
}
class ButtonGhost extends React.Component {
   render() {
       
       var buttonStyle = {
         fontSize: 24,
         color: '#FFFFFF',
         fontWeight: "bold",
         paddingTop: 17,
         paddingBottom: 22,
         paddingLeft: 48,
         paddingRight: 47,           
         borderRadius: 5,
         opacity: 0.95,
      }
      return (
          <div>
         <button style= {buttonStyle}>
            Join
         </button>
          </div>
      );
   }
}
class ButtonGhostXS extends React.Component {
   render() {
       
       var buttonStyle = {
         fontSize: 14,
         color: '#FFFFFF',
         fontWeight: "bold",
         paddingTop: 17,
         paddingBottom: 22,
         paddingLeft: 48,
         paddingRight: 47,
         width: 149,
         borderRadius: 5,
         opacity: 0.95,
      }
      return (
          <div>
         <button style= {buttonStyle}>
            Join
         </button>
          </div>
      );
   }
}
export default buttonApp;
