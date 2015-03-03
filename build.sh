bower install

if [ "$TRAVIS_BRANCH" == "production" ]
then
  grunt deploy:prod
else
  grunt deploy
fi

echo "Moving build static bunldes into a deployable artifact folder"
mkdir artifact
cp -r static/dist artifact/dist
cp -r static/images artifact/images
cp -r static/favicons artifact/favicons

echo "Move environment specific index.html and iframe.html into place"
mkdir index
if [ "$TRAVIS_BRANCH" == "production" ]
then
  cp static/index.html index/prod.html
  cp static/iframe.html index/iframe-prod.html
else
  cp static/index.html index/qa.html
  cp static/iframe.html index/iframe-qa.html
fi