import React, { Component } from 'react';
import './Blockquote.css';

export default class Blockquote extends React.Component {
  render() {
    return (
      <div className="Blockquote">      
        <blockquote>"It's not just all in your head, it's all around you. We 
          can heal together."{"\u2764\uFE0F"}</blockquote>
       </div>
    );
  }
}
