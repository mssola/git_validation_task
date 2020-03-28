# git_validation_task [![Build Status](https://travis-ci.org/mssola/git_validation_task.svg?branch=master)](https://travis-ci.org/mssola/git_validation_task) [![Gem Version](https://badge.fury.io/rb/git_validation_task.svg)](https://badge.fury.io/rb/git_validation_task)

`git_validation_task` TODO

## Using it

Simply include it in your Rakefile like so:

```ruby
require "git_validation/task"

GitValidation::Task.new(:"git-validation")
```

You can pass two options:

1. `from`: the inital SHA for the `-range` flag. If this is not used, then the
   `-range` is not used (except for what is described in the `CI` section of
   this document).
2. `run`: the values to be passed to the `run` flag. If this is not used, then
   the `-run` flag is not used.

Thus, a more complete example would be something like:

```ruby
require "git_validation/task"

GitValidation::Task.new(:"git-validation") do |t|
  t.from = "74a6c20fc4d3"
end
```

Or:

```ruby
require "git_validation/task"

GitValidation::Task.new(:"git-validation") do |t|
  t.from = "74a6c20fc4d3"
  t.run  = "DCO,message_regexp"
end
```

## CI

If the `TRAVIS_COMMIT_RANGE` environment variable is set, then this value will
be used for the `-range` flag. Thus, any value from the `from` option will be
ignored in this context.

## Contributing

Read the [CONTRIBUTING.md](./CONTRIBUTING.md) file.

## [Changelog](https://pbs.twimg.com/media/DJDYCcLXcAA_eIo?format=jpg&name=small)

Read the [CHANGELOG.md](./CHANGELOG.md) file.

## License

This project is based on work I did for the
[Portus](https://github.com/SUSE/Portus) project. I've extracted my code into a
gem so it can be also used for other projects that might be interested in this.

```
Copyright (C) 2020 Miquel Sabaté Solà <mikisabate@gmail.com>

git_validation_task is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

git_validation_task is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with git_validation_task.  If not, see <http://www.gnu.org/licenses/>.
```
