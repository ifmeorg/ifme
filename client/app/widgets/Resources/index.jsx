// @flow
import React from 'react';
import css from './Resources.scss';
import { Resource } from '../../components/Resource';
import { Utils } from '../../utils';
import { InputTag } from '../../components/Input/InputTag';

export type Props = {
  resources: any,
};

export type State = {
  checkboxes: any
};

export class Resources extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checkboxes: this.createCheckboxes() };
  }
  
  createCheckboxes = () => {
    const { resources } = this.props;
    const tagsList = [...new Set(resources.map(res => res.tags.concat(res.languages)).reduce((acc, val) => acc.concat(val), []))];
    return tagsList.map(tag => {return {id: tag, key: tag, value: tag, label: tag, checked: false}});
  };
  
  checkboxChange = (box) => {
    this.setState((prevState: State) => {
      const updatedBoxes = prevState.checkboxes.filter(checkbox => checkbox.id !== box.id).concat(box);
      return { checkboxes: updatedBoxes };
    });
  };
  
  filterList = (res, check) => {
    const selectedTags = check.filter(c => c.checked === true);
    const matchingResources = res.filter(r => {
      const tagCheck = selectedTags.map(t => 
        r.tags.concat(r.languages).includes(t.id)
      );
      if(tagCheck.includes(false)) {
        return false;
      } else {
        return true;
      } 
    });
    return matchingResources;
  };
  
  render() {
    const { resources } = this.props;
    const { checkboxes } = this.state;
    const filteredResources = this.filterList(resources, checkboxes);
  
    return (
      <React.Fragment>
          <InputTag
            id='resourceTags'
            name='resourceTags'
            placeholder='Press ENTER to add'
            checkboxes={checkboxes}
            onCheckboxChange = {(box) => this.checkboxChange(box)}
          />
        <div className={css.gridThree}>
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
  };
};
