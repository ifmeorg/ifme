import React from 'react';
import css from './Header.scss';

type Props = {
isLoggedIn?: boolean;
link?: string;
firstTextHolder?: string;
secondTextholder?: string;
};

class UrlLink extends React.Component<Props, {}> {
  render() {
    const { link = '', firstTextHolder, secondTextholder } = this.props;
    const urllink = link ? '#' : '';
    const cssLink = css.dashboard ? css.dashboard : '';
    return (
      <li><a href={urllink}><span className={cssLink}>{firstTextHolder}</span>{secondTextholder}</a></li>
    );
  } 
}

export default class Header extends React.Component<Props, {}> {
  render() {
    const { isLoggedIn } = this.props;
    return (
      <div className={css.header}>
        <nav>
          <span className={css.logo}>
          if me
          </span>
          <ul>
            <UrlLink urllink="" secondTextholder="ABOUT" />
            <UrlLink urllink="" secondTextholder="BLOG" />
            <UrlLink urllink="" secondTextholder="RESOURCES" />
            {
              isLoggedIn
                ? <UrlLink urllink="" firstTextHolder="DASHBOARD" secondTextholder= " / SIGN OUT" />
                :
                <UrlLink urllink="" secondTextholder="JOIN / SIGN IN" />
            }
          </ul>
        </nav>
      </div>
    );
  }
}

Header.propTypes = { isLoggedIn: React.PropTypes.isRequired };
UrlLink.propTypes = { link: React.PropTypes.isRequired };
UrlLink.propTypes = { firstTextHolder: React.PropTypes.isRequired };
