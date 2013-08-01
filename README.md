# description

Checkstyle formatter for [reek](https://github.com/troessner/reek)


# usage

Load the rake task into your `Rakefile`.

```ruby
require 'reek-checkstyle-formatter/rake_task'
```

`rake -T`

```
[...]
rake reek             # Check for code smells
rake reek:checkstyle  # Generate checkstyle XML for code smells analyzed by reek
[...]
```

# customize

See options documented in [Reek::CheckstyleFormatter#initialize](lib/reek-checkstyle-formatter.rb).
