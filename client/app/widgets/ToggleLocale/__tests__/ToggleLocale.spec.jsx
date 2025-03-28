// @flow
import React from 'react';
import axios from 'axios';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Cookies from 'js-cookie';
import { ToggleLocale } from 'widgets/ToggleLocale';

const locales = ['en', 'es', 'it', 'nb', 'nl', 'pt-BR', 'sv', 'vi'];
const component = <ToggleLocale locale="en" locales={locales} />;

describe('ToggleLocale', () => {
  beforeEach(() => {
    jest.spyOn(Cookies, 'get').mockImplementation(() => 'en');
    jest.spyOn(Cookies, 'set');
  });

  it('does nothing if the previous locale is the same as the selected', async () => {
    const axiosPostSpy = jest
      .spyOn(axios, 'post')
      .mockImplementation(() => Promise.resolve());
    render(component);
    await userEvent.selectOptions(screen.getByRole('combobox'), 'en');
    expect(axiosPostSpy).not.toHaveBeenCalled();
  });

  it('sets the locale cookie and makes a post request if the selected locale is different from the previous', async () => {
    const axiosPostSpy = jest
      .spyOn(axios, 'post')
      .mockImplementation(() => Promise.resolve());
    render(component);
    await userEvent.selectOptions(screen.getByRole('combobox'), 'es');
    expect(Cookies.set).toHaveBeenCalledWith('locale', 'es');
    expect(axiosPostSpy).toHaveBeenCalledWith('/toggle_locale', {
      locale: 'es',
    });
  });
});
