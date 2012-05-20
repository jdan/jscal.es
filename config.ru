require 'toto'
require 'time-ago-in-words'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  def time_ago(t)
    d = (Time.now - Time.parse(t.to_s)) / 24 / 60 / 60
    d = d.to_i

    if d < 1
      'today'
    else
      case d
        when 1
          'yesterday'
        when 2..6
          d.to_s + ' days ago'
        when 7..29
          amt = (d / 7).to_i
          "#{amt.to_s} week#{(amt > 1 ? 's' : '')} ago"
        when 30..360
          amt = (d / 30).to_i
          "#{amt.to_s} month#{(amt > 1 ? 's' : '')} ago"
        else
          amt = (d / 360).to_i
          "#{amt.to_s} year#{(amt > 1 ? 's' : '')} ago"
      end
    end
  end

  #
  # Add your settings here
  # set [:setting], [value]
  # 
  # set :author,    ENV['USER']                               # blog author
  # set :title,     Dir.pwd.split('/').last                   # site title
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  # set :markdown,  :smart                                    # use markdown + smart-mode
  # set :disqus,    false                                     # disqus id, or false
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  # set :ext,       'txt'                                     # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds

  set :date,    lambda { |now| time_ago(now) }  # ugly?
  set :title,   "blahg"
end

run toto
