import myModule from './dependencies.js';
import _ from 'lodash';

export const handler = async (event) => {
  return {
    lodash: _.random(true) * 100,
    myModule: myModule.capitalize(event.name),
  };
};
