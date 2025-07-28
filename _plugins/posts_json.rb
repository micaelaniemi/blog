module Jekyll
  class PostsJsonGenerator < Generator
    safe true
    priority :low

    def generate(site)
      posts_by_date = {}
      site.posts.docs.each do |post|
        date = post.data['date'].strftime('%Y-%m-%d')
        posts_by_date[date] ||= []
        posts_by_date[date] << {
          'id' => "#{date}-#{post.data['time'].gsub(':', '')}",
          'time' => post.data['time'],
          'title' => post.data['title']
        }
      end

      File.write(File.join(site.dest, 'posts.json'), JSON.pretty_generate(posts_by_date))
    end
  end
end
