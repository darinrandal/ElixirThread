module PostsHelper
	def format_country(cc)
		image_tag "#{root_path}assets/flags/#{cc.downcase}.png", :title => cc, :alt => cc unless cc == "XX"
	end

	def format_os(os)
		os = "OS X" if os.include?("OS X")
		image_tag "#{root_path}assets/os/#{os.delete(' ').downcase}.png", :title => os, :alt => os
	end

	def format_browser(b)
		image_tag "#{root_path}assets/browser/#{b.delete(' ').downcase}.png", :title => b, :alt => b
	end

    def rating_by_name(id)
		ratings = ['', 'Moustache', 'Smarked', 'Agree', 'Disagree', 'Funny', 'Winner', 'Zing', 'Informative', 'Friendly', 'Useful', 'Programming King', 'Optimistic', 'Artistic', 'Late', 'Dumb']
		ratings[id]
	end

	def format_rating(r, small)
		name = rating_by_name(r[0])
		full_name = (small ? '' : "#{name} ")
		image_tag("#{root_path}assets/ratings/#{name.downcase}.png", :title => name) + raw(" #{full_name}x <strong>#{r[1]}</strong>")
	end
end
