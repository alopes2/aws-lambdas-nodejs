let myModule;

if (process.env.NODE_ENV === 'prod') {
  myModule = await import('/opt/nodejs/layer/index.js');
} else {
  myModule = await import('../../layer/src/index.js');
}

export default myModule;
