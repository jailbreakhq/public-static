# Deploy the index.html to my nginx server on EC2 by simply SCP'ing the file over
chmod 600 .travis/deploy_key.pem
ssh-add .travis/deploy_key.pem

if [ "$TRAVIS_BRANCH" = "production" ]
then
  scp static/index.html ubuntu@e32designs.com:~/jailbreakhq.org/www/index.html
else
  scp static/index.html ubuntu@e32designs.com:~/qa.jailbreakhq.org/www/index.html
fi