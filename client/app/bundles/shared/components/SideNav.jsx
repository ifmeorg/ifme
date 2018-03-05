import React from 'react';
import css from './SideNav.scss';


export default class SideNavBar extends React.Component{
constructor(props){
    super(props);
    this.state = { showMenu: true};

this.handleClick = this.handleClick.bind(this);
}

handleClick(){
    this.setState(prevState =>({
        showMenu: !prevState.showMenu
    }));
}

        render(){
            const containerClass = `${css.container}`;
            const secondaryListClass = `${css.secondaryList}`;
            return(
                <div className={containerClass}>
                <ul>
                    <li><a href="#">Dashboard</a></li>
                    <li onClick={this.handleClick}><a href="#">Moments</a></li>
                    <div className={secondaryListClass} style = {{display: this.state.showMenu ? 'none' : 'block'}}>
                        <li><a href="#">Categories</a></li>
                            <li><a href="#">Moods</a></li>
                            </div>
                    <li><a href="#">Strategies</a></li>
                    <li><a href="#">Medications</a></li>
                    <li><a href="#">Groups</a></li>
                    <li><a href="#">Allies</a></li>
                    </ul>
                </div>
            );
        }
    }