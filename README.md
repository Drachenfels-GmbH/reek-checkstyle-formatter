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

Overwrite the formatter options in your `Rakefile`.
E.g To map a smell to a different severitiy (default *warning*):

```ruby
Reek::CheckstyleFormatter.rake_task_options = {
  :smell_severities => {
        'IrresponsibleModule' => 'error'
  }
}
```

Please look at [Reek::CheckstyleFormatter#initialize](lib/reek-checkstyle-formatter.rb) for available options.