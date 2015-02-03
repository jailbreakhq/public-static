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
mkdir index
cp static/index.html index/index.html