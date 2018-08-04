// @flow
import React from 'react';

export interface Props {
  children: any;
}

export interface State {
  options: string[];
  children: any;
}

export class RadioButtonGroup extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    const { children } = this.props;
    const options = [];
    children.forEach((child: any) => {
      const { id } = child.props;
      options.push(id);
    });
    this.state = { options, children };
  }

  componentDidMount() {
    this.setupChildren();
  }

  uncheckAllAndCheck = (id: string) => {
    const { children } = this.state;
    const newChildren = children.map((child: any) =>
      React.cloneElement(child, {
        updateAll: this.updateAll,
        key: child.props.id,
        checked: child.props.id === id,
      }),
    );
    this.setState({ children: newChildren });
  };

  updateAll = (id: string) => {
    this.uncheckAllAndCheck(id);
  };

  setupChildren = () => {
    const { children } = this.state;
    let newChildren;
    if (Array.isArray(children)) {
      const numChecked = children.filter((child: any) => child.props.checked)
        .length;
      if (numChecked > 1) {
        newChildren = children.map((child: any) =>
          React.cloneElement(child, {
            updateAll: this.updateAll,
            key: child.props.id,
            checked: false,
          }),
        );
      } else {
        newChildren = children.map((child: any) =>
          React.cloneElement(child, {
            updateAll: this.updateAll,
            key: child.props.id,
          }),
        );
      }
    } else {
      newChildren = React.cloneElement((children: any), {
        updateAll: this.updateAll,
      });
    }
    this.setState({ children: newChildren });
  };
  render() {
    const { children } = this.state;
    return <div className="RadioButtonGroup">{children}</div>;
  }
}
