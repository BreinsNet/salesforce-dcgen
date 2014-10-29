# Dcgen

dcgen is a simple tool that generates a destructiveChanges.xml by comparing
two salesforce source directories. 

A typical usage example is if you use an SCM to manage your salesforce code and
metadata. You can compare your repository contents against what is in a sandbox. 
Any element that is in you sandbox but is not on your SCM will be included in the
destructiveChange.xml.

## Installation

```
# gem install salesforce-dcgen
```
## Usage

To get destructiveChanges.xml between two directories just run:

```
$ dcgen -m dir/to/scm/repo -d dir/to/sandbox/source/code
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dcgen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
