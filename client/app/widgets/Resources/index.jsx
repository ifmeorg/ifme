// @flow
import React from 'react';
import css from './Resources.scss';
import { Resource } from '../../components/Resource';
import { Utils } from '../../utils';
import type { Checkbox } from '../../components/Input/utils';
import { InputTag } from '../../components/Input/InputTag';
import { I18n } from '../../libs/i18n';

type ResourceProp = {
  name: string,
  link: string,
  tags: string[],
  languages: string[],
  type: string,
};

export type Props = {
  resources: ResourceProp[],
};

export type State = {
  checkboxes: Checkbox[],
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
  constructor(props: Props) {
    super(props);
    this.state = { checkboxes: this.createCheckboxes() };
  }

  createCheckboxes = () => {
    const { resources } = this.props;
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
        checked: false,
      })),
    );
  };

  checkboxChange = (box: Checkbox) => {
    this.setState((prevState: State) => {
      const updatedBoxes = prevState.checkboxes
        .filter(checkbox => checkbox.id !== box.id)
        .concat(box);
      return { checkboxes: updatedBoxes };
    });
  };

  filterList = (checkboxes: Checkbox[]) => {
    const { resources } = this.props;
    const selectedCheckboxes = checkboxes.filter(
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
    const { checkboxes } = this.state;
    const filteredResources = this.filterList(checkboxes);
    return (
      <div className={`${css.gridThree} ${css.marginTop}`}>
        {filteredResources.map((resource: ResourceProp) => (
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
    );
  };

  render() {
    const { checkboxes } = this.state;
    return (
      <React.Fragment>
        <InputTag
          id="resourceTags"
          name="resourceTags"
          placeholder={I18n.t('common.form.search_by_keywords')}
          checkboxes={checkboxes}
          onCheckboxChange={box => this.checkboxChange(box)}
        />
        {this.displayTags()}
      </React.Fragment>
    );
  }
}
