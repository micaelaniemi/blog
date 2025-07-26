# blog-main/_plugins/generate_posts_json.rb
Jekyll::Hooks.register :site, :post_write do |site|
  posts_data = {}
  site.posts.docs.each do |post|
    date = post.date.strftime('%Y-%m-%d')
    time = post.date.strftime('%H:%M')
    posts_data[date] ||= []
    posts_data[date] << {
      'id' => post.date.strftime('%Y-%m-%d-%H%M'),
      'time' => time,
      'title' => post.data['title']
    }
  end
  # Write to a temporary location in the Jekyll build output
  File.write(File.join(site.dest, 'posts.json'), JSON.pretty_generate(posts_data))
end
