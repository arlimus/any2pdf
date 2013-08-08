Any2Pdf
========

Convert things to PDF. This is a quick and dirty collection of scripts I have grown accustomed to coupled with an inherent lazyness to enter tedious commands. Remember: it is dirty by design.

Currently supports:

* Markdown
* HTML

(Ok, it is currently not really *Any*2Pdf yet... The motivation is clear.)

It uses available tools to do so, it just glues them together.

Requirements
============

* Ruby
* Pandoc
* wkhtmltopdf
* gems: pdfkit trollop, nokogiri
* fonts
    * Google Web Fonts: [ OpenSans ]( http://www.google.com/webfonts/specimen/Open+Sans )
* monospace fonts
    * [ Consolas ]( http://www.ascenderfonts.com/font/consolas-regular.aspx ) (the preferred monospace font)
    * [ Droid Sans Mono ]( http://www.google.com/webfonts/specimen/Droid+Sans+Mono ) (alternative; part of Google Web Fonts)
    * [ DejaVu Sans Mono ]( http://dejavu-fonts.org/wiki/Main_Page ) (another alternative for monospace)

Installation
============

**1.** **Install requirements**

Eg for **Ubuntu**:

```bash
# in case you don't have ruby:
apt-get install ruby1.9.3
# or use any other ruby version / rvm / etc you like

apt-get install pandoc wkhtmltopdf
```

Eg for **Arch Linux**: Get `pandoc` from AUR, easiest done via `yaourt`

```bash
yaourt -S ruby
yaourt -S pandoc wkhtmltopdf
```

**2.** **Install this app**

Get the files and install:

```bash
git clone <this-git-repo>
cd any2pdf
gem build *.gemspec && gem install *.gem
```

It will pull in dependencies. If everything is correctly configured, you can use the command now.


Usage
=====

Read the help

```bash
any2pdf --help
```

Try it

```bash
any2pdf test.md
```

View `test.pdf`. View `test.html`.

Try styles:

```bash
# have mystyle.css in your folder
any2pdf test.md -s mystyle.css
```

Try global styles:

```bash
any2pdf test.md -s blue
```


Custom Global Styles
====================

This is for the very lazy (like me). Put your own styles into the installed gem folder under `data/`, eg:

```bash
cd ~/.gem/ruby/1.9.1/gems/any2pdf-1.0.0/data/
ls
touch mysexystyle.css
```

And now you can use it with either:

```bash
any2pdf test.md -s mysexystyle.css
```

Or just:

```bash
any2pdf test.md -s mysexystyle
```

You can also replace `default.css` if you like. It's called if you don't use the `-s` option, eg:

```bash
any2pdf test.md
```


License and Author
==================
Author: Dominik Richter <dominik.richter@googlemail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
