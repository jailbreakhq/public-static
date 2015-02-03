bower install
grunt deploy
echo "Moving build files into a deploy artifact folder"
mkdir artifact
cp -r static/dist artifact/dist
cp -r static/images artifact/images
cp -r static/favicons artifact/favicons
