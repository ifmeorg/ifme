import React from 'react';
import FacebookLogin from 'react-facebook-login';

export class Facebook extends React.Component{
  state = {
    isLoggedIn: false,
    user_id: '',
    name: '',
    email: '',
    picture: '',
  };

  responseFacebook = response => {
    this.setState({
      isLoggedIn: true,
      user_id: response.user_id,
      name: response.name,
      email: response.email,
      picture: response.picture.data.url,
    })
  }

  componentClicked = () => console.log("Clicked!");

  render(){
    let fbContent;
    if(this.state.isLoggedIn){
      fbContent = (<div>
                      <img src={this.state.picture} alt={this.state.name} />
                      <p>Authenticated</p>
                        {this.state.email}
                        <button type="submit" className="button">
                            Log out
                        </button>
                   </div>);
    }
    else{
      fbContent = (<FacebookLogin
                    appId="617409215779627"
                    autoLoad={true}
                    fields="name,email,picture"
                    onClick={this.componentClicked}
                    callback={this.responseFacebook} />);
    }
    return <div>{fbContent}</div>;
    // sign_in_and_redirect @user, event: :authentication
  }
}
