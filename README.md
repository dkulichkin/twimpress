Twimpress
=========

Twimpress has been considered initially as a hobby-time Angularjs/Nodejs project with a purpose of having in my portfolio some Brain Computer Interface (BCI) development experience, based from the other hand on various outstanding Single Page Application (SPA) development practices, which I do not have a chance to evolve on my regular career work time.

Thus I decided to buy and perform something around <a href="http://store.neurosky.com/products/brainwave-starter-kit" target="_blank">Mindwave</a> by <a href="http://neurosky.com/" target="_blank">Neurosky</a>. It provides a raw EEG data, plus metrics of attention, concentration and 8 basic mind wave frequencies from Delta to High Gamma, delivering it either via JSON or binary-based protocol mode. The former one in fact up to the actual for the moment firmware was not exposing raw EEG component and has been naturally loosing from perspective of data delivery speed comparing to the latter, so I dug into the low-level documentation and created a <a href="https://github.com/dkulichkin/mindset-js-binary-parser" target="_blank">binary-based nodejs parser module</a>.

So on the Home page in the form of Gauge/Column charts Twimpress exposes all the mentioned above data signals, providing also connection quality metric in the form of UI icon signs, recommended by a specification. The application is easy to install and thus might be a good point for bootstrapping various further Mindset/Mindwave SPA projects.

From the other hand (though in a sandbox and dummy manner) I tried to scene some "business" value beyond as well. For a long time I was pondering an idea to perform some dynamic data's flow mind evaluation and didn't invent any better demonstrational-purpose example than to pick a Twitter API with a user-provided query, forming a selection of matching relevant authors with a basic profile info and latest tweets grabbed up to it. Then looping and rotating it one by one and measuring an attention level on a background, considering all in all the final impression for the author by detecting an average attantion been stucking over 65/100 for a certain period of time. From this perspective it give some basement for the future investigations as for the impressions obtained from the particular author been shown. Please watch the video (coming soon) I'm gonna shot to demonstrate it in action.


Architecture and installation
=========

Twimpress was seeded on the top of <a href="http://yeoman.io/" target="_blank">Yeoman</a> <a href="https://github.com/yeoman/generator-angular" target="_blank">Angular generator</a>, following Coffeescript syntax on its front-end part. From the other hand a provider of the data via TCP socket is ran via separate nodejs process under Neurosocketserver.js. All dependencies are grabbed via Nodejs package mannager and Bower. Overall here's the full list of technologies been used:

  1. Angularjs (Coffeescript-style, based on Yeoman's generator)
  2. Express.js (for trigerring Twitter API and opening TCP socket to ThinkGear Connector utility)
  3. Socket.io (for transferring data from back-end)
  4. Twitter bootstrap 2
  5. Sass, Compass
  6. Highcharts

To install Twimpress follow these steps:

  1. Clone it and run <code>npm install</code> to grab Node's dependencies
  2. Run <code>bower install</code> to pull all the front-end components
  3. Assure you've got your TGC running and start a data provider server script: <code>node neurosocketserver</code>. This should start an http server and web socket on the port 8080. Note that connecting to TGC doesn't happen at this moment but takes place only after client's connection from the step below. In a case of getting any complications at this point follow to a page of the <a href="https://github.com/dkulichkin/mindset-js-binary-parser" target="_blank">mindset-js-binary-parser</a> module.
  4. On the separate shell's tab Run the client environment by <code>grunt server</code>. This should run the client server on the port 9000 and automatically open the browser. The repository becomes to be under live reload mode, watching and reacting to all changes been made.
  5. After client will establish a web socket handshake the serial port will be opened, and blue indicator on the headset should start lighting up with no blinking. As soon as a signal's quality will be 100% (green icon) the data should start reflecting a stream on the charts and provider's shell tab.


Notices
=========

To proceed to tweets evaluation tab you should sign in and grant an access to TweetsEvaluator app to use your account for triggering Twitter's API (a standard workflow assumed now by Twitter). Thus due to Twimpress's open source license you've got an access to its consumer key and secret. I encourage you create your own Twitter app and substitute these keys with your appropriate own ones.

This project has been considered in demonstrational purposes only so I do not plan to develop it somehow further. However I appreciate any tips and comments and opened to assist you with some related demands.


Demonstrational Video
=========

Comming soon...
