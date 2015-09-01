# Ripples

Entry for the 2nd Riot Games API Challenge, showing the changes in AP item
usage across patches 5.11 and 5.14.

We decided to use machine learning and data visualization to look at the changes
brought on champion builds by the AP Item changes.  But not just the AP item
builders -- let's look at the Ripples of those changes and how they affect the
rest of the LoL world.

You can play with the app [here](http://riot-ripples.herokuapp.com/).

## So you want to run this app...

Hooray!

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [foreman]:

    % foreman start

If you don't have `foreman`, see [Foreman's install instructions][foreman]. It
is [purposefully excluded from the project's `Gemfile`][exclude].

[foreman]: https://github.com/ddollar/foreman
[exclude]: https://github.com/ddollar/foreman/pull/437#issuecomment-41110407

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
