// @flow
import React from 'react';
import { Modal } from '../../components/Modal';
import { Input } from '../../components/Input';
import type { Checkbox } from '../../components/Input/utils';
import { Utils } from '../../utils';
import css from './QuickCreate.scss';
import { DynamicForm } from '../../components/Form/DynamicForm';

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

const alpha = (a: string, b: string) => {
  if (a.toLowerCase() > b.toLowerCase()) return 1;
  if (a.toLowerCase() < b.toLowerCase()) return -1;
  return 0;
};

const sortAlpha = (checkboxes: Checkbox[]): Checkbox[] =>
  // eslint-disable-next-line implicit-arrow-linebreak
  checkboxes.sort((a: Checkbox, b: Checkbox) => alpha(a.label, b.label));

export class QuickCreate extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      checkboxes: sortAlpha(props.checkboxes),
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

  addToCheckboxes = (data: { name: string, id: string, slug: string }) => {
    const { checkboxes } = this.state;
    const { name, id, slug } = data;
    const newCheckboxes = checkboxes.slice(0);
    newCheckboxes.push({
      id: slug,
      label: name,
      value: id,
      checked: true,
    });
    return sortAlpha(newCheckboxes);
  };

  onCreate = (response: any) => {
    const { data } = response;
    if (data && data.success) {
      this.setState({
        open: false,
        accordionOpen: true,
        modalKey: Utils.randomString(),
        tagKey: Utils.randomString(),
        checkboxes: this.addToCheckboxes(data),
      });
    }
  };

  displayQuickCreateForm = (nameValue: string) => {
    const { formProps } = this.props;
    return (
      <DynamicForm
        nameValue={nameValue}
        formProps={formProps}
        onCreate={this.onCreate}
      />
    );
  };

  onChange = (data: { label: string, checkboxes: Checkbox[] }) => {
    const { label, checkboxes } = data;
    if (!this.labelExists(label)) {
      this.setState({
        open: true,
        modalKey: Utils.randomString(),
        body: this.displayQuickCreateForm(label),
        checkboxes: sortAlpha(checkboxes),
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
    const { label } = this.props;
    const { open, modalKey, body } = this.state;
    return (
      <div>
        {this.displayInputTag()}
        <div className={css.modal}>
          <Modal body={body} title={label} open={open} key={modalKey} />
        </div>
      </div>
    );
  }
}
