// @flow
import React from 'react';

export interface Props {
  children: any;
  action: Function;
}

export interface State {
  allChecked: string[];
}

export class CheckboxGroup extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    const { children } = this.props;
    const allChecked = [];

    if (Array.isArray(children)) {
      children.forEach((child: any) => {
        const { checked, id } = child.props;
        if (checked) {
          allChecked.push(id);
        }
      });
    } else {
      allChecked.push(children.props.id);
    }
    this.state = { allChecked };
  }

  updateAllChecked = (id: string, checked: boolean) => {
    const { allChecked } = this.state;
    const index = allChecked.indexOf(id);
    if (index > -1) {
      allChecked.splice(index, 1);
    }
    if (checked) {
      allChecked.push(id);
    }
    this.setState({ allChecked });
    this.props.action(allChecked);
  };

  childrenWithUpdateAllChecked = () => {
    const { children } = this.props;
    let newChildren;
    if (Array.isArray(children)) {
      newChildren = children.map((child: any) =>
        React.cloneElement(child, {
          updateAllChecked: this.updateAllChecked,
          key: child.props.id,
        }),
      );
    } else {
      newChildren = React.cloneElement((children: any), {
        updateAllChecked: this.updateAllChecked,
      });
    }
    return newChildren;
  };

  render() {
    return (
      <div className="checkboxGroup">{this.childrenWithUpdateAllChecked()}</div>
    );
  }
}
