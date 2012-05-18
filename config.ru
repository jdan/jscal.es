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
      return 'today'
    else
      case d
        when 1
          return 'yesterday'
        when 2..6
          return d.to_s + ' days ago'
        when 7..28
          amt = (d / 7).to_i
          if amt == 1
            return '1 week ago'
          else
            return amt.to_s + ' weeks ago'
          end
        when 29..365
          amt = (d / 28).to_i
          if amt == 1
            return '1 month ago'
          else
            return amt.to_s + ' months ago'
          end
        else
          amt = (d / 365).to_i
          if amt == 1
            return '1 year ago'
          else
            return amt.to_s + ' years ago'
          end
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

  # set :date,        lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :date,        lambda { |now| time_ago(now) }  # ugly?
  set :title,       "blahg"
end

run toto
