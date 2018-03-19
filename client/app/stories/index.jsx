import 'chartjs';
import React from 'react';
import { withInfo } from '@storybook/addon-info';

// eslint-disable-next-line import/no-extraneous-dependencies
import { storiesOf } from '@storybook/react';
import { defaultMessages, defaultLocale } from 'libs/i18n/default';
import { getMessages } from 'libs/i18n/I18nUtils';
import { loadLocales } from 'libs/i18n/I18nSetup';
import { IntlProvider, injectIntl } from 'react-intl';

import Chart from '../bundles/momentDashboards/components/Chart';
import ChartControl from '../bundles/momentDashboards/components/ChartControl';

import Logo from '../bundles/shared/components/Logo';
import Input from '../bundles/shared/components/Input';
import Textarea from '../bundles/shared/components/Textarea';
import DropdownGhost from '../bundles/shared/components/Dropdown/DropdownGhost';
import DropdownGhostSmall from '../bundles/shared/components/Dropdown/DropdownGhostSmall';
import DropdownFillSmall from '../bundles/shared/components/Dropdown/DropdownFillSmall';
import Footer from '../bundles/shared/components/Footer/Footer';

import Tag from '../bundles/shared/components/Tag';

import Heading from '../bundles/shared/components/Heading';

loadLocales();

storiesOf('Headings', module)
  .add('Heading Large', withInfo({})(() =>
    <Heading large label={'Better Communication with loved ones leads to better mental health.'} />,
  ))
  .add('Heading Normal', withInfo({})(() =>
    <Heading label={'A community for mental health experiences.'} />,
  ))
  .add('Heading Small', withInfo({})(() =>
    <Heading small label={'A community for mental health experiences.'} />,
  ))
  .add('Text', withInfo({})(() =>
    <Heading text label={'We need each others support to break down stigmas.'} />,
  ));

storiesOf('Tags', module)
  .add('TagGhostXs', withInfo({})(() =>
    <Tag label={'Self-Injury'} />,
  ))
  .add('TagDarkXs', withInfo({})(() =>
    <Tag dark label={'Self-Injury'} />,
  ))
  .add('Tag', withInfo({})(() =>
    <Tag normal label={'Self-Injury'} />,
  ));

storiesOf('Logo', module)
  .add('Small', withInfo({})(() =>
    <Logo size="small" />,
  ))
  .add('Medium', withInfo({})(() =>
    <Logo />,
  ));

const sampleChartData = { '2013-02-10 00:00:00 -0800': 11, '2013-02-11 00:00:00 -0800': 6 };

storiesOf('Chart', module)
  .add('Chart Display Area', withInfo({})(() =>
    <Chart title="Sample" data={sampleChartData} chartType="Area" />,
  ))
  .add('Chart Display Line', withInfo({})(() =>
    <Chart title="Sample" data={sampleChartData} chartType="Line" />,
  ))
  .add('Chart Control', withInfo({})(() =>
    (<ChartControl
      types={['Moments', 'Categories', 'Moods']}
      initialParams={{
        type: 'Categories',
        data: {
          Categories: [
            { name: 'School', data: { '2013-02-10': 2, '2013-02-11': 4, '2013-02-12': 50 } },
            { name: 'Job', data: { '2013-02-10': 11, '2013-02-11': 6, '2013-02-12': 15 } },
            { name: 'Relationship', data: { '2013-02-10': 5, '2013-02-11': 6, '2013-02-12': 5 } },
          ],
          Moods: [
            { name: 'Anxious', data: { '2013-02-10': 5, '2013-02-11': 12, '2013-02-12': 1 } },
            { name: 'Shy', data: { '2013-02-10': 10, '2013-02-11': 16, '2013-02-12': 15 } },
          ],
          Moments: { '2013-02-10': 10, '2013-02-11': 16, '2013-02-12': 2 },
        },
      }}
    />),
  ));

storiesOf('Input', module)
  .add('Input Light', withInfo({})(() =>
    <Input label="Hello" placeholder="Placeholder" />,
  ))
  .add('Input Dark', withInfo({})(() =>
    <Input dark label="Hello" placeholder="Placeholder" />,
  ))
  .add('Input Light (Large)', withInfo({})(() =>
    <Input large label="Hello" placeholder="Placeholder" />,
  ))
  .add('Input Dark (Large)', withInfo({})(() =>
    <Input dark large label="Hello" placeholder="Placeholder" />,
  ));

class I18nWrapper extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      locale: defaultLocale,
    };
  }

  render() {
    const TitleComponent = injectIntl(({ intl }) => (
      <div>
        {intl.formatMessage(defaultMessages.appDescription)}
      </div>
    ));

    return (
      <IntlProvider
        locale={this.state.locale}
        key={this.state.locale}
        messages={getMessages(this.state.locale)}
      >
        <div>
          <TitleComponent />
          <DropdownGhost
            onChange={selectedLocale => this.setState({ locale: selectedLocale })}
            locale={this.state.locale}
          />
        </div>
      </IntlProvider>
    );
  }
}

storiesOf('Textarea', module)
  .add('Textarea', withInfo({})(() =>
    <Textarea rows={6} label="What happened and how do you feel?" placeholder="I felt..." />,
  ));

storiesOf('Dropdown', module)
  .add('DropdownGhost', withInfo({})(() =>
    (<DropdownGhost
      onChange={() => {}}
      locale={'en'}
      localeList={{ en: 'English', fr: 'French' }}
    />),
  ))
  .add('DropdownGhostSmall', withInfo({})(() =>
    (<DropdownGhostSmall
      onChange={() => {}}
      locale={'it'}
      localeList={{ en: 'English', fr: 'French', it: 'Italian' }}
    />),
  ))
  .add('DropdownFillSmall', withInfo({})(() =>
    (<DropdownFillSmall
      onChange={() => {}}
      locale={'ptbr'}
    />),
  ))
  .add('ChangingLocales', withInfo({})(() =>
    <I18nWrapper />,
  ));

storiesOf('Footer', module)
  .add('View', withInfo({})(() =>
    <Footer />,
  ));
