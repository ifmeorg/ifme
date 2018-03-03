import React from 'react';
import css from './SideNav.scss';

type Props = {
    color?: string;
}

export default class SideNavBar extends React.Component{

        render(){
            const {color} = this.props;
            const containerClass = `${css[color] || ''}`;
            return(
                <div className={containerClass}>
                <nav>
                <ul>
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Moments</a></li>
                    <li><a href="#">Strategies</a></li>
                    <li><a href="#">Medications</a></li>
                    <li><a href="#">Groups</a></li>
                    <li><a href="#">Allies</a></li>
                </ul>
                </nav>
                </div>
            );
        }
    }