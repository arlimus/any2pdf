Any2Pdf
========

Convert things to PDF.

Currently supports:
* Markdown
* HTML

(Ok, it is currently not really **Any**2Pdf yet... The motivation is clear.)

It uses available tools to do so, this is just a lazy framework to glue it together.

Requirements
============

* Ruby
* Pandoc
* Gems: pdfkit, trollop, nokogiri

Installation
============

Install requirements on your system.

Eg for Ubuntu:

    # in case you don't have ruby:
    apt-get install ruby1.9.3
    # or use any other ruby version / rvm / etc you like

    apt-get install pandoc

Eg for Arch Linux: Get `pandoc` from AUR, easiest done via `yaourt`

    yaourt -S ruby
    yaourt -S pandoc

Now on any system:

    git clone <this-git-repo>
    cd any2pdf
    gem build *.gemspec && gem install *.gem

It will pull in dependencies. If everything is correctly configured, you can use the command now.

Usage
=====

Read the help

    any2pdf --help

Try it

    any2pdf test.md

View the pdf. View the html.

Try styles

    # have mystyle.css in your folder
    any2pdf test.md -s mystyle.css

    # use default styles
    any2pdf test.md -s blue


License and Author
==================
Author:: Dominik Richter <dominik.richter@googlemail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
