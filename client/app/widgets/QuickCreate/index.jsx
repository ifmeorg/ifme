// @flow
import React from 'react';
import { Modal } from '../../components/Modal';
import { Input } from '../../components/Input';
import type { Checkbox } from '../../components/Input';
import { Utils } from '../../utils';
import css from './QuickCreate.scss';
import { QuickCreateForm } from './QuickCreateForm';

// value - e.g. category.id
// label - e.g. category.name
// checked - i.e. is category used in Moment?

export type Props = {
  checkboxes: Checkbox[],
  placeholder?: string,
  name: string,
  id: string,
  label: string,
  formProps: any,
};

export type State = {
  checkboxes: Checkbox[],
  open: boolean,
  modalKey?: string,
  tagKey?: string,
  body?: any,
  accordionOpen: boolean,
};

export class QuickCreate extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      checkboxes: props.checkboxes,
      open: false,
      accordionOpen: false,
    };
  }

  getCheckboxes = () => {
    const { checkboxes } = this.state;
    const checkboxesProp = [];
    checkboxes.forEach((checkbox: Checkbox) => {
      const checkboxProp = {
        id: checkbox.id,
        label: checkbox.label,
        value: checkbox.value,
        checked: checkbox.checked,
      };
      checkboxesProp.push(checkboxProp);
    });
    return checkboxesProp;
  };

  labelExists = (label: string) => {
    const { checkboxes } = this.state;
    return checkboxes.filter(
      (checkbox: Checkbox) => checkbox.label.toLowerCase() === label.toLowerCase(),
    ).length;
  };

  onCreate = (checkbox: { label: string, value: number, id: string }) => {
    const { label, value, id } = checkbox;
    this.setState((prevState: State) => {
      const { checkboxes } = prevState;
      checkboxes.push({
        id,
        label,
        value,
        checked: true,
      });
      return {
        open: false,
        accordionOpen: true,
        modalKey: Utils.randomString(),
        tagKey: Utils.randomString(),
        checkboxes,
      };
    });
  };

  displayQuickCreateForm = (nameValue: string) => {
    const { formProps } = this.props;
    return (
      <QuickCreateForm
        nameValue={nameValue}
        formProps={formProps}
        onCreate={this.onCreate}
      />
    );
  };

  onChange = (nameValue: string) => {
    if (!this.labelExists(nameValue)) {
      this.setState({
        open: true,
        modalKey: Utils.randomString(),
        body: this.displayQuickCreateForm(nameValue),
      });
    }
  };

  displayInputTag = () => {
    const {
      placeholder, name, id, label,
    } = this.props;
    const { tagKey, accordionOpen } = this.state;
    return (
      <Input
        id={id}
        type="tag"
        name={name}
        label={label}
        checkboxes={this.getCheckboxes()}
        placeholder={placeholder}
        onChange={this.onChange}
        key={tagKey}
        accordionOpen={accordionOpen}
        accordion
        dark
      />
    );
  };

  render() {
    const { id, label } = this.props;
    const { open, modalKey, body } = this.state;
    return (
      <div id={id}>
        {this.displayInputTag()}
        <div className={css.modal}>
          <Modal body={body} title={label} open={open} key={modalKey} />
        </div>
      </div>
    );
  }
}
