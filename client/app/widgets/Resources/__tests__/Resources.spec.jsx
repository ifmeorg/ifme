// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import React from 'react';
import Resources from 'widgets/Resources';

const resourcesData = [
  {
    name: '7 Cups',
    link: 'https://www.7cups.com',
    tags: ['counseling', 'paid', 'free', 'texting', 'android', 'ios'],
    languages: ['en', 'es'],
  },
  {
    name: 'A Canvas of the Minds',
    link: 'https://acanvasoftheminds.com/',
    tags: ['free', 'blog'],
    languages: ['en'],
  },
  {
    name: 'Bloom',
    link: 'http://www.getbloom.net/',
    tags: ['ios', 'paid', 'game', 'colouring', 'stress'],
    languages: ['en'],
  },
];

// eslint-disable-next-line react/prop-types
const getComponent = ({ history } = {}) => (
  <Resources keywords={[]} resources={resourcesData} history={history} />
);

/**
 * Each resource can have multiple associated tags,
 * and each tag can be clicked to filter related resources.
 * So to test we:
  - pick a tag at random to test, i.e. 'counseling'
  - query the occurrences of that tag
  - select the tag, which applies a filter
  - and check that the view updates
 */
describe('Resources', () => {
  it('adds tags to filter when tag labels are clicked', () => {
    render(getComponent());

    // Check that an article exists for each resource in the initial render
    let resourcesArticles = screen.getAllByRole('article');
    expect(resourcesArticles).toHaveLength(3);
    // results count/pagination
    expect(screen.getByText(new RegExp(`${3} of ${3}`))).toBeInTheDocument();

    // Check that all the expected tags from resourcesData are rendered:
    // both resource.languages and resource.tags are displayed among related tags
    resourcesData
      .flatMap(({ languages, tags }) => [...languages, ...tags])
      .forEach((tag) => {
        expect(screen.getAllByText(tag)).not.toHaveLength(0);
      });

    let tagText = 'counseling';
    let queryOptions = { name: tagText };

    // only expect 1 'counseling' tag from initial resourcesData
    let selectedTags = screen.getAllByRole('button', queryOptions);
    expect(selectedTags).toHaveLength(1);
    // select the tag to filter resources
    let [selectedTag] = selectedTags;
    userEvent.click(selectedTag);

    /*
     * Expected view updates:
     * - resources are filtered down around the selected tag
     * - the selected tag is listed among the filtered resources
     * - a corresponding checkbox is shown for the selected tag
     */
    resourcesArticles = screen.getAllByRole('article');
    expect(resourcesArticles).toHaveLength(1);
    // results count/pagination
    expect(screen.getByText(new RegExp(`${1} of ${1}`))).toBeInTheDocument();
    selectedTag = screen.getByRole('button', queryOptions);
    expect(selectedTag).toBeInTheDocument();
    let checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
    /*
     * From among the already filtered tags, pick another tag at random
     * and repeat the above test
     */
    tagText = 'ios';
    queryOptions = { name: tagText };
    // only 1 resource with 'ios' tag when 'counseling' filter is applied
    selectedTags = screen.getAllByRole('button', queryOptions);
    expect(selectedTags).toHaveLength(1);
    [selectedTag] = selectedTags;
    // select the new tag
    userEvent.click(selectedTag);

    // observe the expected view updates for the newly selected 'ios' tag
    resourcesArticles = screen.getAllByRole('article');
    expect(resourcesArticles).toHaveLength(2);
    // results count/pagination
    expect(screen.getByText(new RegExp(`${2} of ${2}`))).toBeInTheDocument();
    // with the new filter applied, expect 2 'ios' tags
    selectedTags = screen.getAllByRole('button', queryOptions);
    expect(selectedTags).toHaveLength(2);
    // new checkbox also exists
    checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
  });

  it('filters when tags are selected', () => {
    render(getComponent());
    // initial render has select menu and resources
    const combobox = screen.getByRole('combobox');
    expect(combobox).toBeInTheDocument();
    let resourcesArticles = screen.getAllByRole('article');
    expect(resourcesArticles).toHaveLength(3);
    // results count/pagination
    expect(screen.getByText(new RegExp(`${3} of ${3}`))).toBeInTheDocument();

    // focuses the InputTag select
    let input = screen.getByRole('textbox');
    userEvent.click(input);

    // first tag selection
    let tagText = 'android';
    let queryOptions = { name: tagText };

    // click tag option
    let option = screen.getByRole('option', queryOptions);
    userEvent.click(option);

    // expected view updates:
    // test resources count
    resourcesArticles = screen.getAllByRole('article');
    expect(resourcesArticles).toHaveLength(1);
    expect(screen.getByText(new RegExp(`${1} of ${1}`))).toBeInTheDocument();
    // test tag buttons count
    let selectedTag = screen.getByRole('button', queryOptions);
    expect(selectedTag).toBeInTheDocument();
    // test checkbox exists
    let checkbox = screen.queryByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
    // re-query input as its key prop has been refreshed
    input = screen.getByRole('textbox');
    userEvent.click(input);

    // check second tag selection
    // and expected view updates
    tagText = 'colouring';
    queryOptions = { name: tagText };
    option = screen.getByRole('option', queryOptions);
    userEvent.click(option);

    resourcesArticles = screen.getAllByRole('article');
    expect(resourcesArticles).toHaveLength(2);
    expect(screen.getByText(new RegExp(`${2} of ${2}`))).toBeInTheDocument();
    selectedTag = screen.getByRole('button', queryOptions);
    expect(selectedTag).toBeInTheDocument();
    checkbox = screen.queryByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
  });

  it('unfilters when a tag is unselected', () => {
    render(getComponent());
    let resourcesArticles = screen.getAllByRole('article');
    expect(resourcesArticles).toHaveLength(3);
    expect(screen.getByText(new RegExp(`${3} of ${3}`))).toBeInTheDocument();

    const input = screen.getByRole('textbox');
    userEvent.click(input);

    // tag selection and expected view updates
    const tagText = 'android';
    const queryOptions = { name: tagText };

    const option = screen.getByRole('option', queryOptions);
    userEvent.click(option);

    resourcesArticles = screen.getAllByRole('article');
    expect(resourcesArticles).toHaveLength(1);
    expect(screen.getByText(new RegExp(`${1} of ${1}`))).toBeInTheDocument();
    const selectedTag = screen.getByRole('button', queryOptions);
    expect(selectedTag).toBeInTheDocument();
    const checkbox = screen.queryByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();

    // unselect selected tag via its checkbox
    userEvent.click(checkbox);

    resourcesArticles = screen.getAllByRole('article');
    expect(resourcesArticles).toHaveLength(3);
    expect(screen.getByText(new RegExp(`${3} of ${3}`))).toBeInTheDocument();
  });

  describe('when the component updates', () => {
    const history = { replace: () => null };
    let historyMock;

    beforeEach(() => {
      historyMock = jest.spyOn(history, 'replace');
    });

    afterEach(() => {
      historyMock.mockRestore();
    });

    describe('and the resources are being filtered', () => {
      it('sends the selected tags to the URL', () => {
        render(getComponent({ history }));

        // choose two filters at once and expect the search string to update accordingly
        userEvent.click(screen.getAllByRole('button', { name: 'ios' })[0]);
        userEvent.click(screen.getByRole('button', { name: 'counseling' }));

        expect(historyMock).toHaveBeenCalledWith({
          pathname: '/resources',
          search: '?filter[]=counseling&filter[]=ios',
        });
      });
    });

    describe('and there is no filters selected', () => {
      it('resets the search query parameter', () => {
        render(getComponent({ history }));

        expect(historyMock).toHaveBeenCalledWith({
          pathname: '/resources',
          search: '',
        });
      });
    });
  });
});
