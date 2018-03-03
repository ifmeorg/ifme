import React from 'react';
import css from './Button.scss';

type Props = {
    onClick?: () =>any;
    color?: string;
    size?: string;
    buttonText?: string;
}
export default class Button extends React.Component{
    render(){
        const {onClick, color, size, buttonText} = this.props;
        const linkClass = onClick ? 'link' : '';
        const containerClass = `${css[size] || ''} ${css[color] || ''} ${linkClass}`;
        return(<button className={containerClass} onClick={onClick}></button>);
    }
}