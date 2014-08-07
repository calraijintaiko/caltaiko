# Getting Started: a quick introduction to Rails

Rails projects can be super intimidating at first, with all the gems and models and controllers and views to look through. Hopefully this file helps give you some understanding of how everything works!

## General Layout

All rails apps come with a very set, pre-defined setup. Generally you'll find some combination of the following:

+ `app` is where most of the work will be happening: here are all the views, models, and controllers, as well as assets such as images, javascript, and styling files.
+ `bin` has the scripts used to start and run the app; you can safely ignore it.
+ `config` has all of the configuration files, dealing with things like routing, initialization, and environment settings.
+ `db` contains all the database creation/setup information. You generally won't edit anything in here directly, except for maybe a migration every once in a while. But *never* change the `db/schema.rb` file directly; it will be automatically updated when new migrations are run.
+ `lib` can be useful in certain situations, but we probably won't need it at all. It is automatically added to the load path, so that anything inside is accessible by the rest of the app. See [this article](http://reefpoints.dockyard.com/ruby/2012/02/14/love-your-lib-directory.html) for more details.
+ `log` keeps a log of the sessions you run for each environment (development, test, and production). You can ignore it unless using it for debugging. The log files are ignored by git.
+ `public` is the only folder that the public can see as-is. It's also on the asset pipeline, so can also contain images and the like.
+ `spec` contains all of the test scripts. By default these would be in a `test` directory, but since we're using [Rspec](http://rspec.info/) to test we have `spec`.
+ `vendor` contains all external assets, such as the google-analytics or facebook javascript code.
+ `.gitignore` is used by git to know which files it can ignore (duh). Anything you list here will not be checked into the version control system.
+ `.ruby-version` is used by Heroku to know which version of ruby it should use when deploying.
+ `Gemfile` is a listing of the gems required by this app. This is what you will edit to add additional gems; when you run `bundle install` bundler is looking through it to find out what it needs to get.
+ `Gemfile.lock` is created by bundler when you run `bundle install`; it lists the exact versions of each gem you're currently using, as well as their dependencies.
+ `Procfile` I don't really understand myself; all I know is I followed the instructions [here](https://devcenter.heroku.com/articles/getting-started-with-rails4#webserver) haha
+ `README.rdoc` is the README file for the project, displayed by default on GitHub and shown when generating documentation with `rake doc:app`

## MVC Pattern

The Model-View-Controller pattern is at the heart of how Rails operates. You can find a better explanation [here](http://betterexplained.com/articles/intermediate-rails-understanding-models-views-and-controllers/), but the general idea is that every url route maps to a specific method of a Controller, and each Controller method (usually, if it's a get not a post) has a corresponding view. When the controller method is called, it gets the data it needs by calling methods from the model and storing it as an instance variable, where it can be accessed by the view.

**Models** should handle all of the "business logic" of figuring out how to get certain information. They will be the ones querying the database and reformatting data to fit the controller's needs. They also handle things like input validation and slug generation.

**Views** should handle only formatting and view logic, ie "show this only if user logged in" or "display all members like this" kind of stuff. Though you can write ruby code in views, any kind of data-manipulation should be handled in the model.

Views are generally written in html with erb, which stands for "embedded-ruby." I switched over from html & erb to [haml](http://haml.info/), since I think it's much easier to write and read. The original erb files can be found in the `erb` directory; if you're having trouble reading the haml files try finding their corresponding erb equivalent and comparing them (the erb ones might become oudated after a while though).

## Resources

A **resource** is the rails term for a type of object, such as an article or a user. Resources generally have corresponding tables in the database, and have defined CRUD (create, read, update, destory) operations specified in their controller.

Resources also have defined parameters that correspond to columns in their database table. For instance, a Performances resource might have title, location, date, and description parameters.

## Routing

One of the most important files is `config/routes.rb`, which tells Rails how everything is connected. If you look at the file, you'll see the very first (non-commented) line is setting the root of the app, with `root 'front_page#main'`. This tells rails that when the user navigates to the site with nothing after the domain, ie just `www.example.com`, the `main` method of the FrontPageController wil be run.

Root gets a special command, but the general layout is `get 'path' => 'controller#method'`, where if the user navigates to `www.example.com/path` the `method` method of the `controller` controller will be run, and the view `app/views/controller/method.html.haml` will be displayed.

Any symbols used in the path will be accessible to the controller method through the params hash. For instance, the route `get 'members/gen/:id' => 'members#gen` will call the `gen` method of the MembersController no matter what `:id` is. Inside the `gen` method, calling params[:id] will return that corresponding portion of the path.

Resources get a little helper command to more easily set up their routes. The command `resources :articles` will automatically create get routes for `article/show/:id`, `article/edit/:id`, `article/new`, and `article/index`, where each of those routes to the corresponding method in the ArticlesController (show, edit, new, or index). It also creates post routes for delete and update.

## Assets

Assets are things such as images, javascript files, or styling files, and are located in either the `app/assets`, `vendor/assets`, or `lib/assets` directories. 