# Getting Started: a quick introduction to Rails

Rails projects can be super intimidating at first, with all the gems and models and controllers and views to look through. Hopefully this file helps give you some understanding of how everything works!

For documentation that goes into each model and controller more specifically, run the command `rake doc:app` from the root project directory, then open the generated file `doc/app/index.html`.

## General Layout

All rails apps come with a very set, pre-defined setup. Here I'll go over what you'll find for this app specifically, but generally you'll find some combination of the same:

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
+ `.rspec` specifies custom options for Rspec, the testing tool.
+ `.ruby-version` is used by rvm to know which version of ruby to use.
+ `Gemfile` is a listing of the gems required by this app. This is what you will edit to add additional gems; when you run `bundle install` bundler is looking through it to find out what it needs to get.
+ `Gemfile.lock` is created by bundler when you run `bundle install`; it lists the exact versions of each gem you're currently using, as well as their dependencies.
+ `Guardfile` is used by the guard gem, which allows for automated testing whenever a file is changed. It basically just tells guard what files to watch and what tests to run when they're modified.
+ `Procfile` I don't really understand myself; all I know is I followed the instructions [here](https://devcenter.heroku.com/articles/getting-started-with-rails4#webserver) haha
+ `README.rdoc` is the README file for the project, displayed by default on GitHub and shown when generating documentation with `rake doc:app`. It's standard for an app to have one so that people new to the app can get an idea of how to work with it.
+ `Rakefile` is used by Rails to load the commands available through `rake`, which is like `make` only for Ruby. You could define your own `rake` tasks here if you wanted to.
+ `config.ru` is used by Rack-based servers to start the application (according to the file comment lolol)

## MVC Pattern

The Model-View-Controller pattern is at the heart of how Rails operates. You can find a better explanation [here](http://betterexplained.com/articles/intermediate-rails-understanding-models-views-and-controllers/), but the general idea is that every url route maps to a specific method of a Controller, and each Controller method (usually, if it's a GET not a POST) has a corresponding view. When the controller method is called, it gets the data it needs by calling methods from the model and storing it as an instance variable, where it can be accessed by the view.

**Controllers** pass the needed data from the model to the view by storing it as instance variables. Every (public) controller method has a corresponding route; if it is a GET route it has a corresponding view as well.

**Models** should handle all of the "business logic" of figuring out how to get certain information. They will be the ones querying the database and reformatting data to fit the controller's needs. They also handle things like input validation and slug generation.

**Views** are the templates that build up the actual display users see. They should handle only formatting and view logic, ie "show this only if user logged in" or "display all members like this" kind of stuff. Though you can write ruby code in views, any kind of data-manipulation should be handled in the model.

### Views in more detail

Views are generally written in html with erb, which stands for "embedded-ruby." I switched over from html & erb to [haml](http://haml.info/), since I think it's much easier to write and read. The original erb files can be found in the `erb` directory; if you're having trouble reading the haml files try finding their corresponding erb equivalent and comparing them (the erb ones might become oudated after a while though).

Rather than having each view create the entire page, Rails makes it very easy to have a general page layout where only the content changes. On each webpage, the template `app/views/layouts/application.html.haml` is *always* used. This has many advantages, including that you don't need to rewrite the head every file. If you notice, in that file is a `yield` statement. This `yield` basically tells Rails to pause from reading `application.html.haml` and jump to whatever view the route specifies. 

## Resources

A **resource** is the rails term for a type of object, such as an article or a user. Resources generally have corresponding tables in the database, and have defined CRUD (create, read, update, destory) operations specified in their controller.

Resources also have defined parameters that correspond to columns in their database table. For instance, a Performances resource might have title, location, date, and description parameters.

## Routing

One of the most important files in a Rails app is `config/routes.rb`, which tells Rails how everything is connected. If you look at the file, you'll see the very first (non-commented) line is setting the root of the app, with `root 'front_page#main'`. This tells rails that when the user navigates to the site with nothing after the domain, ie just `www.example.com`, the `main` method of the FrontPageController wil be run. (This doesn't necessarily need to be the first line, but the earlier a route is listed the higher it's priority, meaning it will override a route with the same path listed below it)

Root gets a special command, but the general layout is `get 'a_path' => 'controller_x#method_y'`, where if the user navigates to `www.example.com/a_path` the `method_y` method of the `controller_x` controller will be run, and the view `app/views/controller_x/method_y.html.haml` will be displayed.

Any symbols used in the path will be accessible to the controller method through the params hash. For instance, the route `get 'members/gen/:id' => 'members#gen` will call the `gen` method of the MembersController no matter what `:id` is. Inside the `gen` method, calling `params[:id]` will return that corresponding portion of the path.

Resources get a little helper command to more easily set up their routes. The command `resources :articles` will automatically create GET routes for `article/show/:id`, `article/edit/:id`, `article/new`, and `article/index`, where each of those routes to the corresponding method in the ArticlesController (show, edit, new, or index). It also creates POST routes for delete and update.

## Assets

Assets are things like images, javascript files, or styling files, and are located in either the `app/assets`, `vendor/assets`, or `lib/assets` directories. Rails uses a framework known as the asset pipeline to make these assets easily available to your app, as well as to minify them as much as possible. For instance, in order to embed an image `app/assets/images/banner.png` in a view, you could use the command `image_tag("banner.png")`, and Rails will automatically look for a file named `banner.png` in all three asset locations. What happens if you have multiple files named `banner.png` you ask? ...Why would you do that? Stop trying to break things on purpose you butt.

## Javascripts

If you look at the `app/javascripts` directory, you'll see a number of javascript (or coffeescript rather) files. Yet if you look at the Page Source of the actual website, you'll see that only one javascript file is loaded on the page, an `application-XXXXXXXXXX.js`. Ignoring the `XXXXXXXXX` for the moment, this is because Rails concatenates all of the javascript files in your asset directories into that single file. The reason for this has to do with how browsers load webpages, but basically all you need to know is that it's faster. If you look at `app/assets/application.js` you'll see that it does not actually contain any code, but rather a bunch of require statements (or at least it shouldn't contain any code; you can put stuff in there but it's not good practice). Those `require` statements tell Rails what files it needs to smoosh into the single `application-XXX.js` file. Any files in the `app/assets/javascripts` directory are included by default, because of the `require_tree .` line. For files such as `facebook.js.coffee`, which is in the `vendor/assets/javascripts` directory, you need a `require facebook` line. Note that you only need the part of the filename before the extensions, and since `vendor/assets/javascripts` is on the asset pipeline, you don't need any more path than the filename.

Going back to the `XXXX` whatever, this is a hash generated from the contents of the single combined `application.js` file. This lets Rails know when the contents have been changed, so that if necessary it can send the new file. Note that when it concatenates the files Rails also "uglifies" them with the `uglifier` gem. Basically this just means it strips whitespace wherever possible, so that the file is as small as possible.

This whole process of concatenating and minifying only occurs in production mode, which means when you're testing your code locally in development mode each file will be linked in individually. But Rails is smart enough that any required file is still linked.

## Styling

A very similar process occurs for stylesheets. The `app/assets/stylesheets` directory contains an `application.css` file with a few `require` statements, including a `require_tree .` line that ensures all files in the directory are bundled in. It differs a bit from the `application.js` file in that you're free to add styling to the `application.css` file, with the only downside that you won't be able to use SASS.

Since all pages receive only the single `application-XXXXX.css` file, every single styling file you create will apply to all pages of the website. This makes clear use of classes and ids very important, as otherwise things will affect parts of the website you didn't intend them to.

## Environments

Rails has three environments: production, development, and testing. Each of these three environments is treated a bit differently, has their own databases, and even has their own gems. 

**Production** is where the code is run when it's actually being deployed; assets are compiled and minified, all queries go to the production database, and the logs go into `log/production.log`. You will rarely, if ever, be in production mode yourself, unless you want to make absolutely sure something doesn't display differently in production from development (it shouldn't). If you want to, though, you can enter production mode with `rails server -e production`. Just make sure you precompile your assets with `rake assets:precompile`.

**Development** is where you will almost always be working. This is the default mode, and it's what rails starts up in with the `rails s` command. Development is also the environment used when generating files through commands such as `rails g resource Article title:string`.

**Testing** is used when running tests. Testing also has it's own database and gems. The tests database doesn't actually get populated though; it's flushed after every test is run.

## Testing

I set up this app to use Rspec for all testing. All test files are contained in the `spec` directory, broken down into types such as `models` or `controllers`. The main idea of Rspec tests are that they should read like a dialogue. For instance, in the `spec/models/article_spec.rb` test file, imagine a dialogue that goes something like this:

>"Describe an Article"
>
>"It has a valid factory"
>
>"It is invalid without a title"
>
>"It is invalid without a date"
>
>etc

The tests also use a gem called FactoryGirl to create test data. FactoryGirl uses factories to create resource instances with default values. All the factories are contained in `spec/factories`, with a factory for each resource. I used the faker gem to create random data, so that each resource instance you create is given random parameters.

Looking again at `spec/models/article_spec.rb`, you'll see a number of `create(:article)` or `build(:article)` commands throughout. Those `create` and `build` commmands are actually short for `FactoryGirl.create` and `FactoryGirl.build`, usable in that short form because of the line `config.inlude FactoryGirl::Syntax::Methods` in `spec/rails_helper.rb`. Though they seem synonymous, there are a couple key differences between them:

1. `create` saves the resource instance to the database with the inputted parameters, allowing it to be accessed by a later test in the same frame. It does not test validations before creation.

1. `build` tests the inputted parameters for validity against the models validations before creating the instance. It does not save to the database, and thus as soon as that test finishes the instance is gone.

If you create or build a resource using only `create(:resource_name)` (or build), it will be created using the default values given in the corresponding factory file. Any of those parameters can be freely overwritten, however, by simply passing them in as a symbol.

The actual testing statements are written using the `expect(____).to` syntax. Looking at a few examples should make it pretty clear how it works, but basically it checks whatever is in the `expect` statement against the statement to the right. `be_valid`, one of the check statements you'll see often, checks to make sure the instance was created without raising any validation errors.

Tests are run using the `rspec` command from the root directory. You can either run all the tests at once with just plain `rspec`, or you can give a specific file, such as `rspec spec/models/article_spec.rb`. You may notice that testing is generally pretty slow; to speed it up, prepend the command `spring` to your test commands. This will cause the tests to be run through Spring, an app preloader that keeps it running in the background. Spring will stop when you close the terminal window, or you can just run `spring stop` to manually kill it.

If you are going to be making a lot of changes you can automate the testing to run whenever you make a change to a file that has a corresponding spec file. Run the command `guard` to enter the testing interface. Now, whenever you modify (and save) a file it's test will automically be run. You can exit out of the guard interpreter with `quit`.

Make sure to always run `rspec` before pushing changes to deployment!!