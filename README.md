While evaluating Ruby PEG grammar libraries for a recent project, two contenders stood out among all of the Ruby PEG libraries we evaluated: [Treetop](https://rubygems.org/gems/treetop) and [Parslet](https://rubygems.org/gems/parslet).

![ketchup-catsup](https://user-images.githubusercontent.com/21250/83815758-ef628700-a68e-11ea-8db2-6aa9e47d8ae7.png)

Both have a number of benefits:

## Treetop

### Pros

- Grammar DSL is very readable
- Extensible
  - can nest treetop files and include other modules
  - can assign custom subclasses to nodes
- It's a popular repository (204 stars, 107 forks, as of 2020-06-04)
- It's a popular gem (63.8m downloads, 2.2m for the current version, as of 2020-06-04)
- Good ratio of open to closed issues and PRs
- Writing a test parser as a spike recently was a positive experience

### Cons

- Requires committing a `treetop` file
  - This grammar file can be loaded directly and parsed on the fly, or one can generate a static Ruby parser from it.
- The library hasn't been updated in over a year (compared to the other Ruby libraries we evaluated, a year is relatively recent.)
- The last release (1.6.10) was 2 years ago
- Has one primary maintainer and contributor
- Required digging through source code and old tutorials to understand advanced options

## Parslet

### Pros

- Version 2.0 was introduced in February 2020
- Grammar files are Ruby files
- It's a popular repository (709 stars, 85 forks, as of 2020-06-04)
- Multiple contributors
- Grammar definitions are done in Ruby, and can be very powerful.
- Uses a simple DSL

### Cons

- Less popular gem compared to Treetop
- Most recent performance tests found online (~2011) indicated earlier versions were typically 2x slower than Treetop at the time (see next section)

## Performance

Both are popular libraries. Both have readable DSLs and support complex logic including transforming parse trees. But what about performance? Are they enjoyable to write grammar definitions with?

All of the existing performance comparisons I could find were done around 2011 when Parlset was between versions 1.3 and 1.4. In those tests, Treetop typically performed at least 2x better for different sized strings against a complex grammar. Very early versions of Parslet were extremely slow. Unfortunately the test files were not provided so the experiment cannot be reproduced against the current versions without extensive setup.

- [press play on tape – Parslet and its friends](http://blog.absurd.li/2011/02/02/parslet_and_its_friends.html)
- [parslet 1.3.0 vs. treetop · GitHub](https://gist.github.com/kschiess/2788364)
- [parslet 1.4.0 vs. treetop · GitHub](https://gist.github.com/kschiess/2788349)

This repo is intended to serve as a benchmarking and DSL comparison for a simple string parser implemented with Parslet 2.0 and Treetop 1.6.

## Setup

Run `bin/setup` to install the dependencies. Use `bundle exec rake` to run the test suite.

## Benchmarking

Run `bin/benchmark` to run a set of benchmark tests for varying length strings against both grammar parsers. Output will be reported to STDOUT.
