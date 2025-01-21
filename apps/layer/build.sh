# If you have multiple runtime versions, specify under each runtime folder
# mkdir -p nodejs/node20
# cp -r node_modules nodejs/node20/

mkdir -p nodejs/
cp -r src nodejs/
cp package.json nodejs/
cd nodejs/
npm install
cd ../
zip -r layer_content.zip nodejs