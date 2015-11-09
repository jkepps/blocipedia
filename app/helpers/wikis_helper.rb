module WikisHelper
	def public_or_private_tag(wiki)
		if wiki.public?
			content_tag :p, "Public", class: 'btn btn-sm btn-primary'
		else
			content_tag :p, "Private", class: 'btn btn-sm btn-warning'
		end
	end
end
