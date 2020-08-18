import React from 'react';
import { render, waitForElement, fireEvent } from '@testing-library/react';
import { userEvent } from '@testing-library/user-event';
import axios from 'axios';
import Cookies from 'js-cookie';
import { act } from 'react-dom/test-utils';
import { ToggleLocale } from '../index';

const locales = ['en', 'es', 'it', 'nb', 'nl', 'pt-BR', 'sv', 'vi'];
const component = <ToggleLocale locale="en" locales={locales} />;

describe('ToggleLocale', () => {
  beforeEach(() => {
    jest.spyOn(Cookies, 'get').mockImplementation(() => 'en');
    jest.spyOn(Cookies, 'set');
    jest.spyOn(axios, 'post').mockImplementation(() => Promise.resolve());
  });

  it('does nothing if the previous locale is the same as the selected', () => {
    const { wrapper, getByTestId } = render(component);

    const selectInput = getByTestId('inputSelect');

    fireEvent.change(selectInput, { target: { currentTarget: 'en' } });

    expect(axios.post).not.toHaveBeenCalled();
  });

  it('sets the locale cookie and makes a post request if the selected locale is different from the previous', () => {
    const { wrapper, getByTestId } = render(component);

    const selectInput = getByTestId('inputSelect');

    fireEvent.change(selectInput, { target: { currentTarget: 'es' } });

    expect(Cookies.set).toHaveBeenCalledWith('locale', 'es');

    expect(axios.post).toHaveBeenCalledWith('/toggle_locale', { locale: 'es' });
  });
});
