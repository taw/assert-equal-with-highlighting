assert-equal-with-highlighting
==============================

Have you ever done something like this:

    assert_equal foo.some.methods, bar.other.methods

only to see a huge pile of text with a tiny difference hidden somewhere deep inside?

assert-equal-with-highlighting solves such problems by, as the name says on the tin,
highlighting differences between actual and expected value.

TextMate support
================

The library produces ANSI color codes which should work on any Terminal.

If you want to see properly highlighted results in TextMate test runner,
copy `escape.rb` from `textmate/` directory to whichever of these two locations
old `escape.rb` is on your system:

* `/Library/Application Support/TextMate/Support/lib/escape.rb`
* `/Applications/TextMate.app/Contents/SharedSupport/Support/lib/escape.rb`

TODO
====

assert-equal-with-highlighting started as an old-style Rails plugin, it could really use
turning it into a proper gem.

Since order of hashes is unpredictable in 1.8.x (and predictable, but not in useful way in 1.9),
highlighting of hashes is pretty bad.
