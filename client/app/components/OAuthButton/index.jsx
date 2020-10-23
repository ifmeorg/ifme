// @flow
import React from 'react';
import { I18n } from 'libs/i18n';
import css from './OAuthButton.scss';
import googleIcon from './googleIcon.svg';
import facebookIcon from './facebookIcon.svg';

type Props = {
  signIn?: boolean,
  type: 'facebook' | 'google',
  action: string,
  token: string,
};

export const OAuthButton = ({
  signIn, type, action, token,
}: Props) => {
  const buttonText = I18n.t(
    `devise.shared.sign_${signIn ? 'in' : 'up'}_${type}`,
  );
  const id = `${type}OAuthForm`;

  return (
    <>
      <form id={id} method="post" action={action}>
        <input type="hidden" name="authenticity_token" value={token} />
      </form>
      <button
        type="submit"
        className={`${css.oAuthButton} ${
          type === 'google' ? css.oAuthButtonGoogle : css.oAuthButtonFacebook
        }`}
        form={id}
        value={buttonText}
      >
        <img src={type === 'google' ? googleIcon : facebookIcon} alt="" />
        {buttonText}
      </button>
    </>
  );
};

export default ({
  signIn, type, action, token,
}: Props) => (
  <OAuthButton signIn={signIn} type={type} action={action} token={token} />
);
