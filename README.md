# Ripples

Entry for the 2nd Riot Games API Challenge, showing the changes in AP item
usage across patches 5.11 and 5.14.

We decided to use machine learning and data visualization to look at the changes
brought on champion builds by the AP Item changes.  But not just the AP item
builders -- let's look at the Ripples of those changes and how they affect the
rest of the LoL world.

You can play with the app [here](http://riot-ripples.herokuapp.com/).

## Methods

*Note: You can read this [here](http://riot-ripples.herokuapp.com/pages/methods)*

### Data

Our dataset was seeded by the awesome API devs at Riot Games.  They provided
sets of 10,000 match IDs for each region's Ranked and Normal queues for each
patch.  We currently only use the Ranked information for the NA, EUW, and KR
servers.  You can see what we started with at the
[Riot Games API Challenge,](https://developer.riotgames.com/discussion
/announcements/show/2lxEyIcE) announcement.

We wrote a simple script to request match information for each of the given
matches from the Riot API.  We ended up with a giant, but well structured JSON
file of the captured data.  We could then play with that data and reimport it
to development databases on multiple computers without having to redownload it,
keeping the API servers happy.

### App

The heart of the project is a Ruby on Rails app.  Our giant JSON files get
turned into database entries: one for each match and one for each participant
in every match.  Each `participant` `belongs_to` a `match`, and we can leverage
Rails' Associations to do stuff like this:

    participants = Participant.includes(:match)
      .where(
        matches: {
          match_version: '5.14.0.329'
        }
      )
    .references(:matches)

Basically, the infrastructure made slicing and dicing the data a breeze.

### Processing

The simplest way to expose interesting things in the data is to count and
compare things like how often champions or items were used and how much they
won.  This sort of information can be pretty interesting to start with and can
be seen on our [results](http://riot-ripples.herokuapp.com/pages/results), page.
But we want ripples and
[prettier things than bar charts](http://riot-ripples.herokuapp.com/pages/explore),
so that requires a little something extra.

### Clustering

Our little something extra was clustering!  Clustering is one of many machine
learning techniques -- a way of letting a computer figure out how a dataset is
structured and find cool things.  It's used in everything from search engines to
biology and is a great way of condensing a ton of pieces of information into
something a person can interpret and understand.

There are a lot of different clustering algorithms out there.  Since we didn't
know what the ripples we were looking for would be, we chose to use hierarchical
agglomerative clustering to group champions by their builds.  HAC is an
unstructured and deterministic technique -- it doesn't need to know anything
about the data before it starts in order to always come to the mathematically
optimal result.  The trade-off is that it's a lot slower than other techniques,
 even using optimizations like priority queues.  Since there are only about 150
champions though, the difference isn't a big deal, especially since we don't
need to update the results in real time.

[Our implementation of HAC](https://github.com/maryschmidt/ripples/blob/master/app/models/concerns/clusterable.rb#L11)
starts by building vector representations of champions from all of the
participant data we have.  A champion vector is just a list of numbers.  Each
number corresponds to the importance of a particular item to that champion.  The
importance is determined by how many people who played that champion built that
item.

The clustering algorithm takes all those champion vectors and put each of them
in their own cluster.  It figures out which two are the most similar and
combines them.  Then it does it again.  And again.  Until there are no more
clusters that are anything like each other.  In the end, we can build a tree
that represents the relative similarities of different champions and groups of
champions.  We can back out the most significant items for each champion and
cluster and turn it into something people can understand, rather than just a
bunch of numbers.

### Visualization

Any data processing is only as good as the insights you can glean from it.
Visualizing is one of the best ways to give people a window into the data.
Plus it's pretty.  We used the industry-standard
[D3 visualization library](https://github.com/mbostock/d3)
to build our interactive Bar Charts and Sunburst.

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
