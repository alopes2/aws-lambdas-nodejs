import myModule from './dependencies.js';
import _ from 'lodash';

const handler = (event) => {
  return {
    lodash: _.random(true) * 100,
    myModule: myModule.capitalize(event.name),
  };
};

console.log(handler({ name: 'yay' }));
