module PostsHelper
	def format_country(cc)
		image_tag "#{root_path}assets/flags/#{cc.downcase}.png", :title => cc, :alt => cc unless cc == "XX"
	end

	def format_os(os)
		os = "OS X" unless !os.include?("OS X")
		image_tag "#{root_path}assets/os/#{os.delete(' ').downcase}.png", :title => os, :alt => os
	end

	def format_browser(b)
		image_tag "#{root_path}assets/browser/#{b.delete(' ').downcase}.png", :title => b, :alt => b
	end

	def format_post_edit(post)
		link_to 'Edit', edit_post_path(post), :class => "brackets" unless !current_user?(post.user)
    end

    def format_post_delete(post)
    	link_to 'Delete', post, method: :delete, data: { confirm: 'Are you sure?' }, :class => "brackets" unless !current_user?(post.user)
    end
end
