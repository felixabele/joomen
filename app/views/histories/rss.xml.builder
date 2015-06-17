xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do

   xml.title       "joomen.de - wer bringt was?"
   xml.link        url_for :only_path => false, :controller => 'articles'
   xml.description @event.name

   @histories.each do |hist|
     xml.item do
       xml.title       german_time_format(hist.created_at)
       xml.description hist.action
       xml.link        url_for :only_path => false, :controller => 'events', :action => 'show', :id => @event.key
       xml.guid        url_for :only_path => false, :controller => 'events', :action => 'show', :id => @event.key
     end
   end

 end
end
