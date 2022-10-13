// @flow
import React from 'react';
import { fireEvent, render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Modal from 'components/Modal';

const title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';

const bodyText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis commodo erat quis ipsum sodales condimentum. Vestibulum nec posuere lorem. Nulla condimentum, dui et sagittis hendrerit, enim sapien luctus orci, non vehicula nibh massa vel risus. Nunc vitae aliquam lacus. Donec dolor velit, blandit eu erat luctus, aliquam congue augue. Curabitur interdum leo id orci porttitor, eget dictum nibh gravida. Praesent facilisis, justo non convallis consectetur, tellus est egestas erat, quis commodo risus tellus consequat est. Curabitur quis massa non est pharetra mollis. Proin finibus ipsum massa, et semper ipsum ultricies vel. Mauris dignissim auctor egestas. Aenean elit ante, egestas eu ligula a, tincidunt suscipit diam. Nulla ultrices tempus turpis ac cursus. Suspendisse congue sem nec ex vehicula, in vestibulum leo ultricies. Morbi ac faucibus lorem. Donec vitae tellus id quam aliquet iaculis. Nam aliquet quis ante faucibus convallis.';

const bodyHTML = (
  <div>
    <button type="button">Here is a button</button>
    <p>{bodyText}</p>
  </div>
);

const openListener = () => {
  window.alert("Hey look it's listening");
};

const handleKeyPress = (e: any) => {
  window.alert('Key pressed', e);
};

const handleMouseOver = () => {
  window.alert('Mouse did enter');
};

const handleMouseLeave = () => {
  window.alert('Mouse did enter');
};

const handleOnClick = () => {
  window.alert('Mouse clicked');
};

describe('Modal', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  describe('has open prop as false', () => {
    describe('has text values for element and body', () => {
      it('toggles correctly', async () => {
        const { container } = render(
          <Modal element="Hello" body={bodyText} title={title} />,
        );
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(screen.getByRole('button', { name: 'Hello' }));
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.click(screen.getByRole('button', { name: 'close' }));
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();
      });
    });

    describe('has text values for element and body with openListener', () => {
      it('toggles correctly', async () => {
        const component = (
          <Modal
            element="Hello"
            body={bodyText}
            title={title}
            openListener={openListener}
          />
        );
        const { container } = render(component);
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(screen.getByRole('button', { name: 'Hello' }));
        expect(window.alert).toHaveBeenCalledWith("Hey look it's listening");
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.click(screen.getByRole('button', { name: 'close' }));
        expect(window.alert).toHaveBeenCalledWith("Hey look it's listening");
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();
      });
    });

    describe('has HTML values for element and body', () => {
      it('toggles correctly', async () => {
        const component = (
          <Modal
            element={<button type="button">Hello</button>}
            body={bodyHTML}
            title={title}
          />
        );
        const { container } = render(component);
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(
          screen.getAllByRole('button', { name: 'Hello' })[1],
        );
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.click(screen.getByRole('button', { name: 'close' }));
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();
      });
    });

    describe('has HTML values for element and body with openListener', () => {
      it('toggles correctly', async () => {
        const component = (
          <Modal
            element={<button type="button">Hello</button>}
            body={bodyHTML}
            title={title}
            openListener={openListener}
          />
        );
        const { container } = render(component);
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(
          screen.getAllByRole('button', { name: 'Hello' })[1],
        );
        expect(window.alert).toHaveBeenCalledWith("Hey look it's listening");
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.click(screen.getByRole('button', { name: 'close' }));
        expect(window.alert).toHaveBeenCalledWith("Hey look it's listening");
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();
      });
    });

    describe('closes when escape key is pressed', () => {
      const component = (
        <Modal
          element="Hello"
          body={bodyText}
          title={title}
          openListener={openListener}
          onKeyPress={handleKeyPress}
        />
      );
      it('toggles correctly', async () => {
        const { container } = render(component);
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(screen.getByRole('button', { name: 'Hello' }));
        expect(window.alert).toHaveBeenCalledWith("Hey look it's listening");
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        fireEvent.keyDown(container.querySelector('.modalBackdrop'), {
          key: 'Escape',
        });
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();
      });
    });

    describe('closes when back drop is clicked', () => {
      const component = (
        <Modal
          element="Hello"
          body={bodyText}
          title={title}
          openListener={openListener}
          onMouseLeave={handleMouseLeave}
          onClick={handleOnClick}
        />
      );
      it('toggles correctly', async () => {
        const { container } = render(component);
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(screen.getByRole('button', { name: 'Hello' }));
        expect(window.alert).toHaveBeenCalledWith("Hey look it's listening");
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.unhover(screen.getByRole('dialog'));
        await userEvent.click(container.querySelector('.modalBackdrop'));
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();
      });
    });

    describe('does not close when back drop is clicked', () => {
      const component = (
        <Modal
          element="Hello"
          body={bodyText}
          title={title}
          role="button"
          openListener={openListener}
          onMouseOver={handleMouseOver}
          onFocus={handleMouseOver}
          onClick={handleOnClick}
        />
      );
      it('toggles correctly', async () => {
        const { container } = render(component);
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(screen.getByRole('button', { name: 'Hello' }));
        expect(window.alert).toHaveBeenCalledWith("Hey look it's listening");
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.click(screen.getByRole('dialog'));
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();
      });
    });
  });

  describe('has open prop as true', () => {
    describe('has text values for element and body', () => {
      const component = (
        <Modal element="Hello" body={bodyText} title={title} open />
      );
      it('toggles correctly', async () => {
        const { container } = render(component);
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.click(screen.getByRole('button', { name: 'close' }));
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(screen.getByRole('button', { name: 'Hello' }));
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();
      });
    });

    describe('has text values for element and body with openListener', () => {
      it('toggles correctly', async () => {
        const component = (
          <Modal
            element="Hello"
            body={bodyText}
            title={title}
            openListener={openListener}
            open
          />
        );
        const { container } = render(component);
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.click(screen.getByRole('button', { name: 'close' }));
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(screen.getByRole('button', { name: 'Hello' }));
        expect(window.alert).toHaveBeenCalledWith("Hey look it's listening");
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();
      });
    });

    describe('has HTML values for element and body', () => {
      it('toggles correctly', async () => {
        const component = (
          <Modal
            element={<button type="button">Hello</button>}
            body={bodyHTML}
            title={title}
            open
          />
        );
        const { container } = render(component);
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.click(screen.getByRole('button', { name: 'close' }));
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(
          screen.getAllByRole('button', { name: 'Hello' })[1],
        );
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();
      });
    });

    describe('has HTML values for element and body with openListener', () => {
      it('toggles correctly', async () => {
        const component = (
          <Modal
            element={<button type="button">Hello</button>}
            body={bodyHTML}
            title={title}
            openListener={openListener}
            open
          />
        );
        const { container } = render(component);
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.click(screen.getByRole('button', { name: 'close' }));
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        await userEvent.click(
          screen.getAllByRole('button', { name: 'Hello' })[1],
        );
        expect(window.alert).toHaveBeenCalledWith("Hey look it's listening");
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();
      });
    });

    describe('uses an Avatar component for an element and HTML values for the body', () => {
      it('renders correctly', async () => {
        const component = (
          <Modal
            element={{
              component: 'Avatar',
              props: { src: 'https://via.placeholder.com/75x75' },
            }}
            body={bodyHTML}
            title={title}
          />
        );

        const { container } = render(component);
        expect(container.querySelector('.avatar')).toBeInTheDocument();
        await userEvent.click(container.querySelector('.avatar'));
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();
      });
    });

    describe('closes when escape key is pressed', () => {
      const component = (
        <Modal
          element="Hello"
          body={bodyText}
          title={title}
          openListener={openListener}
          onKeyPress={handleKeyPress}
          open
        />
      );
      it('toggles correctly', () => {
        const { container } = render(component);
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        fireEvent.keyDown(container.querySelector('.modalBackdrop'), {
          key: 'Escape',
        });
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();
      });
    });

    describe('closes when back drop is clicked', () => {
      const component = (
        <Modal
          element="Hello"
          body={bodyText}
          title={title}
          role="button"
          openListener={openListener}
          onMouseLeave={handleMouseLeave}
          onBlur={handleMouseLeave}
          onClick={handleOnClick}
          open
        />
      );
      it('toggles correctly', async () => {
        const { container } = render(component);
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();

        await userEvent.unhover(screen.getByRole('dialog'));
        await userEvent.click(container.querySelector('.modalBackdrop'));
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();
      });
    });

    describe('does not close when back drop is not clicked', () => {
      const component = (
        <Modal
          element="Hello"
          role="button"
          body={bodyText}
          title={title}
          openListener={openListener}
          onMouseOver={handleMouseLeave}
          onFocus={handleMouseLeave}
          onClick={handleOnClick}
          open
        />
      );
      it('toggles correctly', async () => {
        const { container } = render(component);
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();
        await userEvent.hover(screen.getByRole('dialog'));

        await userEvent.click(container.querySelector('.modalBackdrop'));
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();
      });
    });

    describe('opens when enter key is pressed', () => {
      const component = (
        <Modal
          element="Hello"
          body={bodyText}
          title={title}
          openListener={openListener}
          onKeyPress={handleKeyPress}
        />
      );
      it('toggles correctly', () => {
        const { container } = render(component);
        expect(
          container.querySelector('.modalBackdrop'),
        ).not.toBeInTheDocument();
        expect(screen.queryByRole('dialog')).toBeNull();

        fireEvent.keyDown(container.querySelector('.modalElement'), {
          key: 'Enter',
        });
        expect(container.querySelector('.modalBackdrop')).toBeInTheDocument();
        expect(screen.getByRole('dialog')).toBeInTheDocument();
      });
    });
  });
});
