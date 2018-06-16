require 'mdl'
require 'json'

class Mdl
  def mdl(string)
    received_errors = []
    doc = MarkdownLint::Doc.new(string)
    ruleset = MarkdownLint::RuleSet.new
    ruleset.load_default
    rules = ruleset.rules
    rules.sort.each do |_, rule|
      error_lines = rule.check.call(doc)
      if error_lines and not error_lines.empty?
        received_errors << rule.description
      end
    end
    received_errors
  end
  def call(env)
    req = Rack::Request.new(env)
    if req.post?
      [200, {'Content-Type' => 'text/plain', 'Access-Control-Allow-Origin' => '*'}, StringIO.new(self.mdl(req.body.read).to_json)]
    else
      [200, {'Content-Type' => 'text/plain'}, StringIO.new('Submit your Markdown as a POST body to lint it.')]
    end
  end
end

run Mdl.new
