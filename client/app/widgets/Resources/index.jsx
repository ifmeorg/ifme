// @flow
import React from 'react';
import css from './Resources.scss';
import { Resource } from '../../components/Resource';
import { Utils } from '../../utils';
import type { Checkbox } from '../../components/Input/utils';
import { InputTag } from '../../components/Input/InputTag';
import { I18n } from '../../libs/i18n';
import HistoryLib from '../../libs/history';

const RESOURCES_PER_PAGE = 3;
type ResourceProp = {
  name: string,
  link: string,
  tags: string[],
  languages: string[],
  type: string,
};

export type Props = {
  resources: ResourceProp[],
  keywords: string[],
  history: {
    replace: (args: {}) => void,
  },
};

export type State = {
  checkboxes: Checkbox[],
  resourcesDisplayed: any,
  lastPage: boolean,
};

const sortAlpha = (checkboxes: Checkbox[]): Checkbox[] =>
  // eslint-disable-next-line implicit-arrow-linebreak
  checkboxes.sort((a: Checkbox, b: Checkbox) => {
    const aLabel = a.label.toLowerCase();
    const bLabel = b.label.toLowerCase();
    if (aLabel < bLabel) return -1;
    return aLabel > bLabel ? 1 : 0;
  });

export class Resources extends React.Component<Props, State> {
  // eslint-disable-next-line react/static-property-placement
  static defaultProps = {
    // eslint-disable-next-line react/default-props-match-prop-types
    history: HistoryLib,
  };

  constructor(props: Props) {
    super(props);

    this.state = {
      checkboxes: this.createCheckboxes(),
      lastPage: false,
      resourcesDisplayed: RESOURCES_PER_PAGE,
    };
  }

  componentDidUpdate() {
    const { checkboxes } = this.state;
    const { history } = this.props;
    const checkedCheckboxes = checkboxes.filter((checkbox) => checkbox.checked);

    if (checkedCheckboxes.length > 0) {
      const tags = checkedCheckboxes.map((checkbox) => checkbox.value);

      history.replace({
        pathname: '/resources',
        search: `?filter[]=${tags.join('&filter[]=')}`,
      });
    } else {
      history.replace({ pathname: '/resources', search: '' });
    }
  }

  createCheckboxes = () => {
    const { resources, keywords } = this.props;
    const tagsList = [
      ...new Set(
        resources
          .map((resource: ResourceProp) => resource.tags.concat(resource.languages))
          .reduce((acc, val) => acc.concat(val), []),
      ),
    ];
    return sortAlpha(
      tagsList.map((tag: string) => ({
        id: tag,
        key: tag,
        value: tag,
        label: tag,
        checked: keywords.some(
          (keyword) => keyword.toLowerCase() === tag.toLowerCase(),
        ),
      })),
    );
  };

  checkboxChange = (box: Checkbox) => {
    this.setState((prevState: State) => {
      const updatedBoxes = prevState.checkboxes
        .filter((checkbox) => checkbox.id !== box.id)
        .concat(box);
      return { checkboxes: updatedBoxes };
    });
  };

  filterList = (checkboxes: Checkbox[]): ResourceProp[] => {
    const { resources } = this.props;
    const selectedCheckboxes: Checkbox[] = checkboxes.filter(
      (checkbox: Checkbox) => !!checkbox.checked,
    );
    return resources.filter((resource: ResourceProp) => {
      const tagCheck = selectedCheckboxes.map((checkbox: Checkbox) =>
        // eslint-disable-next-line implicit-arrow-linebreak
        resource.tags.concat(resource.languages).includes(checkbox.id));
      return !tagCheck.includes(false);
    });
  };

  displayTags = () => {
    const { checkboxes, resourcesDisplayed } = this.state;
    const { resources } = this.props;
    const filteredResources = this.filterList(checkboxes);
    return (
      <>
        <center className={css.marginTop}>
          {`${Math.min(resourcesDisplayed, resources.length)} of ${
            filteredResources.length
          } ${I18n.t('navigation.resources').toLowerCase()}`}
        </center>
        <div className={`${css.gridThree} ${css.marginTop}`}>
          {filteredResources
            .slice(0, resourcesDisplayed)
            .map((resource: ResourceProp) => (
              <div className={css.gridThreeItem} key={Utils.randomString()}>
                <Resource
                  tagged
                  tags={resource.languages.concat(resource.tags)}
                  title={resource.name}
                  link={resource.link}
                />
              </div>
            ))}
        </div>
      </>
    );
  };

  onClick = () => {
    const { resources } = this.props;
    this.setState((prevState: State) => ({
      resourcesDisplayed: prevState.resourcesDisplayed + RESOURCES_PER_PAGE,
      lastPage:
        prevState.resourcesDisplayed + RESOURCES_PER_PAGE >= resources.length,
    }));
  };

  displayLoadMore = () => (
    <center>
      <button
        type="button"
        className={`loadMore ${css.buttonDarkM}`}
        onClick={this.onClick}
      >
        {I18n.t('load_more')}
      </button>
    </center>
  );

  render() {
    const { checkboxes, lastPage } = this.state;
    return (
      <>
        <center className={css.marginBottom}>
          {I18n.t('pages.resources.description')}
          <p>
            <a
              href={`/resources?filter[]=${I18n.t(
                'pages.resources.tags.suicide_prevention',
              )}`}
            >
              {I18n.t('pages.resources.emergency')}
            </a>
          </p>
        </center>
        <InputTag
          id="resourceTags"
          name="resourceTags"
          placeholder={I18n.t('common.form.search_by_keywords')}
          checkboxes={checkboxes}
          onCheckboxChange={(box) => this.checkboxChange(box)}
        />
        {this.displayTags()}
        {!lastPage && this.displayLoadMore()}
      </>
    );
  }
}
