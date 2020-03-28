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

require "rake"
require "rake/file_utils"
require "rake/tasklib"

module GitValidation
  # Task implements the task for the git-validation tool.
  class Task < Rake::TaskLib
    include ::FileUtils

    attr_accessor :from
    attr_accessor :run
    attr_accessor :quiet

    def initialize(name = :"git-validation", *args, &block)
      set_ivars

      desc "Run git-validation" unless ::Rake.application.last_description

      task(name, *args) do |_, task_args|
        abort("The git-validation command could not be found") unless git_validation?

        yield(*[self, task_args].slice(0, block.arity)) if block_given?

        abort("Bad type for 'from' option") unless @from.is_a?(String)
        execute!
      end
    end

    protected

    # Initialize the ivars that are relevant to us.
    def set_ivars
      @from  = nil
      @run   = nil
      @quiet = false
    end

    # Execute the actual shell command with all the needed flags.
    def execute!
      sh("git-validation", *range_flag, *run_flag, *quiet_flag)
    end

    # Returns an array containing the arguments to be passed to the
    # git-validation command for the '-range' flag (where '-range') is already
    # included.
    def range_flag
      return ["-range", ENV["TRAVIS_COMMIT_RANGE"]] if present?(ENV["TRAVIS_COMMIT_RANGE"])
      return [] unless present?(@from)

      unless @from.is_a?(String)
        puts "Given 'from' argument is not a string. Ignoring..."
        return []
      end

      ["-range", "#{@from}..HEAD"]
    end

    # Returns an array containing the arguments to be passed to the
    # git-validation command for the '-run' flag (where '-run') is already
    # included.
    def run_flag
      return [] unless present?(@run)

      unless @run.is_a?(String)
        puts "Given 'run' argument is not a string. Ignoring..."
        return []
      end

      ["-run", @run]
    end

    # Returns an array containing the `-q` flag if it was specified.
    def quiet_flag
      return ["-q"] if @quiet

      []
    end

    # Returns true if the given string is not blank (nil nor empty).
    def present?(str)
      !str.nil? && str != ""
    end

    # Returns true if `git-validation` could be found in the filesystem and it's
    # executable.
    def git_validation?
      ENV["PATH"].split(File::PATH_SEPARATOR).each do |path|
        bin = File.join(path, "git-validation")
        return true if File.executable?(bin) && !File.directory?(bin)
      end
      nil
    end
  end
end
