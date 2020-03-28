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

require "test_helper"

class TestGitValidationTask < Minitest::Test
  # Capture the output for the given block.
  def capture_output(&blk)
    original = $stdout
    msg = StringIO.new
    $stdout = msg

    yield blk

    str = $stdout.string.strip
    $stdout = original

    str
  end

  def test_range_flag_on_travis
    task = ::GitValidation::Task.new

    str = "commit..range"
    ENV["TRAVIS_COMMIT_RANGE"] = str
    res = task.send(:range_flag)
    ENV["TRAVIS_COMMIT_RANGE"] = nil

    assert_equal res, ["-range", str]
  end

  def test_range_flag_empty_string
    task = ::GitValidation::Task.new

    task.from = ""
    res = task.send(:range_flag)

    assert_equal res, []
  end

  def test_range_flag_not_a_string
    task = ::GitValidation::Task.new

    task.from = 1
    res = ""
    out = capture_output { res = task.send(:range_flag) }

    assert_equal res, []
    assert_equal out, "Given 'from' argument is not a string. Ignoring..."
  end

  def test_range_flag_proper_string
    task = ::GitValidation::Task.new

    task.from = "commit"
    res = task.send(:range_flag)

    assert_equal res, ["-range", "commit..HEAD"]
  end

  def test_run_flag_empty_string
    task = ::GitValidation::Task.new

    task.run = ""
    res = task.send(:run_flag)

    assert_equal res, []
  end

  def test_run_flag_not_a_string
    task = ::GitValidation::Task.new

    task.run = 1
    res = ""
    out = capture_output { res = task.send(:run_flag) }

    assert_equal res, []
    assert_equal out, "Given 'run' argument is not a string. Ignoring..."
  end

  def test_run_flag_proper_string
    task = ::GitValidation::Task.new

    task.run = "rule"
    res = task.send(:run_flag)

    assert_equal res, ["-run", "rule"]
  end

  def test_present_nil
    task = ::GitValidation::Task.new

    refute task.send(:present?, nil)
    refute task.send(:present?, "")
    assert task.send(:present?, "a")
  end
end
