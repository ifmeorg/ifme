// @flow
import React from 'react';
import { BrowserRouter as Router, Route, NavLink } from 'react-router-dom';
import css from './SideNav.scss';

const routes = [
    {
        path: "/dashboard",
        exact: true,
    },
    {
        path: "/moments",
        exact: true,
        routes: [
            {
            path: '/categories'
            },
            {
                path: '/moods'
            }
        ]
    },
    {
        path: "/strategies",
        exact: true,
    },
    {
        path: "/medication",
        exact: true,
    },
    {
        path: "/groups",
        exact: true,
    },
    {
        path: "/allies",
        exact: true,
    }
];
const navColor = `${css.bg}`;
const navTwoColor = `${css.secondarybg}`;


export default class SideNavBar extends React.Component{
    constructor(props){
            super(props);
            this.state = { showMenu: false};
        
        this.handleClick = this.handleClick.bind(this);
        this.handleCloseClick = this.handleCloseClick.bind(this);
        }
        
        handleClick(){
            this.setState({showMenu: true});
        }

        handleCloseClick(){
            this.setState({showMenu: false});
        }

    render(){
        return(
    <Router>
        <div className = {navColor}>
        <li activeclassName="active" onClick={this.handleCloseClick}><NavLink activeStyle={{backgroundColor: 'white', color: '#6d0839b3'}} to ="/dashboard">Dashboard</NavLink></li>
                    <li activeclassName="active" onClick={this.handleClick}><NavLink activeStyle={{backgroundColor: 'white', color: '#6d0839b3'}} to ="/moments">Moments</NavLink></li>
                    <div className ={navTwoColor} style = {{display: this.state.showMenu ? 'block' : 'none'}}>
                        <li activeclassName="selected"><NavLink activeStyle={{backgroundColor: '#ffffff91', color: 'white'}} to ="/moment/categories">Categories</NavLink></li>
                            <li activeclassName="selected"><NavLink activeStyle={{backgroundColor: '#ffffff91', color: 'white'}} to ="/moments/moods">Moods</NavLink></li>
                            </div>
                    <li activeclassName="active" onClick={this.handleCloseClick}><NavLink activeStyle={{backgroundColor: 'white', color: '#6d0839b3'}} to="/strategies">Strategies</NavLink></li>
                    <li activeclassName="active" onClick={this.handleCloseClick}><NavLink activeStyle={{backgroundColor: 'white', color: '#6d0839b3'}} to="/medications">Medications</NavLink></li>
                    <li activeclassName="active" onClick={this.handleCloseClick}><NavLink activeStyle={{backgroundColor: 'white', color: '#6d0839b3'}} to="/groups">Groups</NavLink></li>
                    <li activeclassName="active" onClick={this.handleCloseClick}><NavLink activeStyle={{backgroundColor: 'white', color: '#6d0839b3'}} to="/allies">Allies</NavLink></li>
                    {routes.map((route, index) =>(
                        <Route
                        key={index}
                        path={route.path}
                        exact={route.exact}
                        component={route.SideNavBar}
                        />
                    ))}
                    </div>
                    </Router>
        );
    }
                }
