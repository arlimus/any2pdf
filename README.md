Any2Pdf
========

[![RubyGems][gem_version_badge]][ruby_gems]

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

# and any other applications
apt-get install pandoc wkhtmltopdf
```

Eg for **Arch Linux**: Get `pandoc` from `haskell-core`. It requires in your `pacman.conf`:

    [haskell-core]
    Server = http://xsounds.org/~haskell/core/$arch

Then you can:

```bash
pacman -S ruby haskell-pandoc wkhtmltopdf
```

**2.** **Install this app**

```bash
gem install any2pdf
```

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
License: see `LICENSE` file
