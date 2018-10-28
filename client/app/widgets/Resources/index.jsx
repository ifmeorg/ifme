// @flow
import React from 'react';
import css from './Resources.scss';
import { Resource } from '../../components/Resource';
import { Utils } from '../../utils';
import { InputTag } from '../../components/Input/InputTag';
import { I18n } from '../../libs/i18n';

export type Props = {
  resources: any,
};

export type State = {
  checkboxes: any,
};

export type Selected = {
  checked: boolean,
  id: string,
  key: string,
  label: string,
  value: string,
};

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
          .map(res => res.tags.concat(res.languages))
          .reduce((acc, val) => acc.concat(val), []),
      ),
    ];
    return tagsList.map<any>((tag: string) => ({
      id: tag,
      key: tag,
      value: tag,
      label: tag,
      checked: false,
    }));
  };

  checkboxChange = (box: Selected) => {
    this.setState((prevState: State) => {
      const updatedBoxes = prevState.checkboxes
        .filter(checkbox => checkbox.id !== box.id)
        .concat(box);
      return { checkboxes: updatedBoxes };
    });
  };

  filterList = (check: Array<*>) => {
    const { resources } = this.props;
    const selectedTags = check.filter(c => c.checked === true);
    const matchingResources = resources.filter((r) => {
      const tagCheck = selectedTags.map((t: Selected) => r.tags.concat(r.languages).includes(t.id));
      return !tagCheck.includes(false);
    });
    return matchingResources;
  };

  render() {
    const { checkboxes } = this.state;
    const filteredResources = this.filterList(checkboxes);
    return (
      <React.Fragment>
        <InputTag
          id="resourceTags"
          name="resourceTags"
          placeholder={I18n.t('common.form.press_enter')}
          checkboxes={checkboxes}
          onCheckboxChange={box => this.checkboxChange(box)}
        />
        <div className={`${css.gridThree} ${css.marginTop}`}>
          {filteredResources.map(resource => (
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
      </React.Fragment>
    );
  }
}
