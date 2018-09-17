// @flow
import React from 'react';
import { BrowserRouter as Router, Route, NavLink } from 'react-router-dom';
import css from './SideNav.scss';

const routes = [
  {
    path: '/dashboard',
    exact: true,
  },
  {
    path: '/moments',
    exact: true,
    routes: [
      {
        path: '/categories',
      },
      {
        path: '/moods',
      },
    ],
  },
  {
    path: '/strategies',
    exact: true,
  },
  {
    path: '/medication',
    exact: true,
  },
  {
    path: '/groups',
    exact: true,
  },
  {
    path: '/allies',
    exact: true,
  },
];
const navColor = `${css.bg}`;
const navTwoColor = `${css.secondarybg}`;

export interface Props {
  color: string;
}

export interface State {
  showMenu: boolean;
}

export class SideNav extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { showMenu: false };
  }

  handleClick() {
    this.setState({ showMenu: true });
  }

  handleCloseClick() {
    this.setState({ showMenu: false });
  }

  render() {
    return (
      <Router>
        <div className={navColor}>
          <li activeclassName="active">
            <NavLink
              activeStyle={{ backgroundColor: 'white', color: '#6d0839b3' }}
              to="/dashboard"
              onClick={() => this.handleCloseClick()}
            >
              Dashboard
            </NavLink>
          </li>
          <li activeclassName="active">
            <NavLink
              activeStyle={{ backgroundColor: 'white', color: '#6d0839b3' }}
              to="/moments"
              onClick={() => this.handleClick()}
            >
              Moments
            </NavLink>
          </li>
          <div
            className={navTwoColor}
            style={{ display: this.state.showMenu ? 'block' : 'none' }}
          >
            <li activeclassName="selected">
              <NavLink
                activeStyle={{ backgroundColor: '#ffffff91', color: 'white' }}
                to="/moment/categories"
              >
                Categories
              </NavLink>
            </li>
            <li activeclassName="selected">
              <NavLink
                activeStyle={{ backgroundColor: '#ffffff91', color: 'white' }}
                to="/moments/moods"
              >
                Moods
              </NavLink>
            </li>
          </div>
          <li activeclassName="active">
            <NavLink
              activeStyle={{ backgroundColor: 'white', color: '#6d0839b3' }}
              to="/strategies"
              onClick={this.handleCloseClick}
            >
              Strategies
            </NavLink>
          </li>
          <li activeclassName="active">
            <NavLink
              activeStyle={{ backgroundColor: 'white', color: '#6d0839b3' }}
              to="/medications"
              onClick={this.handleCloseClick}
            >
              Medications
            </NavLink>
          </li>
          <li activeclassName="active">
            <NavLink
              activeStyle={{ backgroundColor: 'white', color: '#6d0839b3' }}
              to="/groups"
              onClick={this.handleCloseClick}
            >
              Groups
            </NavLink>
          </li>
          <li activeclassName="active">
            <NavLink
              activeStyle={{ backgroundColor: 'white', color: '#6d0839b3' }}
              to="/allies"
              onClick={this.handleCloseClick}
            >
              Allies
            </NavLink>
          </li>
          {routes.map(route => <Route path={route.path} exact={route.exact} />)}
        </div>
      </Router>
    );
  }
}
