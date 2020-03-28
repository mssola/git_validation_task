# frozen_string_literal: true

# Copyright (C) 2020 Miquel Sabaté Solà <mikisabate@gmail.com>
#
# This file is part of git_validation_task
#
# git_validation_task is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# git_validation_task is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with git_validation_task.  If not, see <http://www.gnu.org/licenses/>.

require "rake/testtask"
require "rubocop/rake_task"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ["--display-cop-names"]
end

# TODO: bootstrap

#GitValidation::RakeTask.new(:"git-validation") do |t|
#t.from = ["74a6c20fc4d3"]
#end

task default: :all
# TODO
#task all: %i[test rubocop git-validation]
task all: %i[test rubocop]