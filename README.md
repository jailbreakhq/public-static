# Jailbreak Admin Static App
A simple backbone single-page app for managing Jailbreak. It is protected by Facebook auth and uses the `JailbreakApi` RESTful API.


## Development
#### Setup
First step is to setup the development environment. You need to have node, npm and bower installed. Then run in the root of this repository to install all development dependencies.

```
./setup.sh
```

#### Developing
In a terminal window run and leave it running while developing.

```
grunt watch
```

to start the Grunt filewatcher that will regenerate the coffeescript, sass, and jade files whenever you change them. Otherwise when you change source files they will have no affect.

## Contributing
If you want to join the contributing team you should email the Jailbreak 2015 Tech Officer at tech@jailbreakhq.org.