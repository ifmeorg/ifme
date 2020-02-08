// @flow
import React from 'react';
import css from './Resources.scss';
import { Resource } from '../../components/Resource';
import { Utils } from '../../utils';
import type { Checkbox } from '../../components/Input/utils';
import { InputTag } from '../../components/Input/InputTag';
import { I18n } from '../../libs/i18n';
import HistoryLib from '../../libs/history';
import { LoadMoreButton } from '../../components/LoadMoreButton';

const RESOURCES_PER_PAGE = 12;

type ResourceProp = {
  name: string,
  link: string,
  tags: string[],
  languages: string[],
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
  resourcesDisplayed: number,
  lastPage: boolean,
  filteredResources: ResourceProp[],
};

const sortAlpha = (checkboxes: Checkbox[]): Checkbox[] =>
  // eslint-disable-next-line implicit-arrow-linebreak
  checkboxes.sort((a: Checkbox, b: Checkbox) => {
    const aLabel = a.label.toLowerCase();
    const bLabel = b.label.toLowerCase();
    if (aLabel < bLabel) return -1;
    return aLabel > bLabel ? 1 : 0;
  });

const infoDescription = (
  <center className={css.marginBottom}>
    {I18n.t('pages.resources.description')}
    <p>
      <a
        href={`/resources?filter[]=${I18n.t('pages.resources.tags.hotlines')}`}
      >
        {I18n.t('pages.resources.emergency')}
      </a>
    </p>
  </center>
);

export class Resources extends React.Component<Props, State> {
  // eslint-disable-next-line react/static-property-placement
  static defaultProps = {
    // eslint-disable-next-line react/default-props-match-prop-types
    history: HistoryLib,
  };

  constructor(props: Props) {
    super(props);
    this.state = this.stateWhenFiltered(this.createCheckboxes());
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

  stateWhenFiltered = (checkboxes: Checkbox[]) => {
    const filteredResources = this.filterList(checkboxes);
    return {
      checkboxes,
      filteredResources,
      lastPage: filteredResources.length <= RESOURCES_PER_PAGE,
      resourcesDisplayed: Math.min(
        RESOURCES_PER_PAGE,
        filteredResources.length,
      ),
    };
  };

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
    this.setState(({ checkboxes }: State) => this.stateWhenFiltered(
      checkboxes.filter((checkbox) => checkbox.id !== box.id).concat(box),
    ));
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

  updateTagFilter = (tagLabel: String) => {
    this.setState(({ checkboxes }: State) => {
      const updatedBoxes = checkboxes.map((box) =>
        // eslint-disable-next-line implicit-arrow-linebreak
        (box.label === tagLabel ? { ...box, checked: true } : box));
      return this.stateWhenFiltered(updatedBoxes);
    });
  };

  onClick = () => {
    this.setState(({ resourcesDisplayed, filteredResources }: State) => {
      const updatedResourcesDisplayed = Math.min(
        filteredResources.length - resourcesDisplayed,
        RESOURCES_PER_PAGE,
      ) + resourcesDisplayed;
      return {
        resourcesDisplayed: updatedResourcesDisplayed,
        lastPage: filteredResources.length === updatedResourcesDisplayed,
      };
    });
  };

  displayTags = () => {
    const { resourcesDisplayed, lastPage, filteredResources } = this.state;
    const { resources } = this.props;
    return (
      <>
        <center className={css.marginTop} aria-live="polite">
          {`${Math.min(resourcesDisplayed, resources.length)} ${I18n.t('of')} ${
            filteredResources.length
          } ${I18n.t('navigation.resources').toLowerCase()}`}
        </center>
        <section className={`${css.gridThree} ${css.marginTop}`}>
          {filteredResources
            .slice(0, resourcesDisplayed)
            .map((resource: ResourceProp) => (
              <article
                className={`Resource ${css.gridThreeItem}`}
                key={Utils.randomString()}
              >
                <Resource
                  tagged
                  tags={resource.languages.concat(resource.tags)}
                  title={resource.name}
                  link={resource.link}
                  updateTagFilter={(tagLabel) => {
                    this.updateTagFilter(tagLabel);
                  }}
                />
              </article>
            ))}
        </section>
        {!lastPage && <LoadMoreButton onClick={this.onClick} />}
      </>
    );
  };

  render() {
    const { checkboxes } = this.state;
    return (
      <>
        {infoDescription}
        <InputTag
          key={Utils.randomString()}
          id="resourceTags"
          name="resourceTags"
          placeholder={I18n.t('common.form.search_by_keywords')}
          checkboxes={checkboxes}
          onCheckboxChange={(box) => this.checkboxChange(box)}
        />
        {this.displayTags()}
      </>
    );
  }
}
