// @flow
import React, { useState, useEffect } from 'react';
import type { Node } from 'react';
import { I18n } from 'libs/i18n';
import { Resource } from 'components/Resource';
import { Tag } from 'components/Tag';
import { Utils } from 'utils';
import type { Checkbox } from 'components/Input/utils';
import { InputTag } from 'components/Input/InputTag';
import { LoadMoreButton } from 'components/LoadMoreButton';
import HistoryLib from 'libs/history';
import css from './Resources.scss';

const RESOURCES_PER_PAGE = 12;

type ResourceProp = {
  name: string,
  link: string,
  tags: string[],
  languages: string[],
  locations?: string[],
};

export type Props = {
  resources: ResourceProp[],
  keywords: string[],
  history?: {
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

const getPopularTags = () => {
  const tags = [
    'addiction',
    'android',
    'asian',
    'bereavement',
    'black_people',
    'black_women',
    'communities',
    'domestic_violence',
    'east_asian',
    'education',
    'goal_tracking',
    'grief',
    'ios',
    'latinx',
    'lgbt',
    'indigenous',
    'mood_tracking',
    'pacific_islander',
    'people_of_colour',
    'self_care',
    'sexual_assault_survivors',
    'south_asian',
    'southeast_asian',
    'therapy',
    'veterans',
    'women',
    'women_of_colour',
  ];

  return tags.map((tag) => (
    <Tag
      normal
      label={I18n.t(`pages.resources.tags.${tag}`)}
      key={Utils.randomString()}
      onClick={() => {
        window.location.href = `/resources?filter[]=${tag.replace(
          /_/g,
          '%20',
        )}`;
      }}
    />
  ));
};

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
    <div className={`${css.tinyTitle} ${css.smallMarginBottom}`}>
      {I18n.t('pages.resources.popular_tags')}
    </div>
    <p>{getPopularTags()}</p>
  </center>
);

const createCheckboxes = (resources: ResourceProp[], keywords: string[]) => {
  const tagsList = [
    ...new Set(
      resources
        .map((resource: ResourceProp) => [
          ...resource.tags,
          ...resource.languages,
          ...(resource.locations || []),
        ])
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

const filterList = (
  checkboxes: Checkbox[],
  resources: ResourceProp[],
): ResourceProp[] => {
  const selectedCheckboxes: Checkbox[] = checkboxes.filter(
    (checkbox: Checkbox) => !!checkbox.checked,
  );
  return resources.filter((resource: ResourceProp) => {
    const tagCheck = selectedCheckboxes.map((checkbox: Checkbox) =>
      // eslint-disable-next-line implicit-arrow-linebreak
      [
        ...resource.tags,
        ...resource.languages,
        ...(resource.locations || []),
      ].includes(checkbox.id));
    return selectedCheckboxes.length > 0 ? tagCheck.includes(true) : true;
  });
};

export const Resources = ({
  resources,
  keywords,
  history = HistoryLib,
}: Props): Node => {
  const [checkboxes, setCheckboxes] = useState<Checkbox[]>(
    createCheckboxes(resources, keywords),
  );
  const [filteredResources, setFilteredResources] = useState<ResourceProp[]>(
    filterList(checkboxes, resources),
  );
  const [resourcesDisplayed, setResourcesDisplayed] = useState<number>(
    Math.min(RESOURCES_PER_PAGE, filteredResources.length),
  );
  const [lastPage, setLastPage] = useState<boolean>(
    filteredResources.length <= RESOURCES_PER_PAGE,
  );

  useEffect(() => {
    setFilteredResources(filterList(checkboxes, resources));
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
  }, [checkboxes]);

  useEffect(() => {
    setLastPage(filteredResources.length <= RESOURCES_PER_PAGE);
    setResourcesDisplayed(
      Math.min(RESOURCES_PER_PAGE, filteredResources.length),
    );
  }, [filteredResources]);

  const checkboxChange = (box: Checkbox) => {
    setCheckboxes(
      checkboxes.filter((checkbox) => checkbox.id !== box.id).concat(box),
    );
  };

  const updateTagFilter = (tagLabel: String) => {
    const updatedBoxes = checkboxes.map((box) =>
      // eslint-disable-next-line implicit-arrow-linebreak
      (box.label === tagLabel ? { ...box, checked: true } : box));
    setCheckboxes(updatedBoxes);
  };

  const onClick = () => {
    const updatedResourcesDisplayed = Math.min(
      filteredResources.length - resourcesDisplayed,
      RESOURCES_PER_PAGE,
    ) + resourcesDisplayed;

    setResourcesDisplayed(updatedResourcesDisplayed);
    setLastPage(filteredResources.length === updatedResourcesDisplayed);
  };

  const displayTags = () => (
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
                tags={[
                  ...resource.tags,
                  ...resource.languages,
                  ...(resource.locations || []),
                ]}
                title={resource.name}
                link={resource.link}
                updateTagFilter={(tagLabel) => {
                  updateTagFilter(tagLabel);
                }}
              />
            </article>
          ))}
      </section>
      {!lastPage && <LoadMoreButton onClick={onClick} />}
    </>
  );

  return (
    <>
      {infoDescription}
      <InputTag
        key={Utils.randomString()}
        id="resourceTags"
        name="resourceTags"
        aria-label={I18n.t('search.search_by_tags')}
        placeholder={I18n.t('search.search_by_tags')}
        checkboxes={checkboxes}
        onCheckboxChange={(box) => checkboxChange(box)}
      />
      {displayTags()}
    </>
  );
};

export default ({ resources, keywords, history }: Props): Node => (
  <Resources resources={resources} keywords={keywords} history={history} />
);
