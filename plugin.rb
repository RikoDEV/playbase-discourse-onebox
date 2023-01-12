# name: Discourse poszukaj.se onebox
# about: Adds support for embedding poszukaj.se servers within Discourse.
# version: 1.0
# authors: riko.dev
# url: https://github.com/rikodev/poszukajse-discourse-onebox

class Onebox::Engine::PoszukajSEOnebox
	include Onebox::Engine
	include Onebox::Engine::StandardEmbed

	REGEX = /^https?:\/\/poszukaj.se\/(?:\w+\/?)(\w*.+)\/(\d+)/
	matches_regexp REGEX

	requires_iframe_origins("https://img.poszukaj.se", "https://poszukaj.se")
	always_https

	def id
		@url.scan(REGEX).last[1]
	end
	
	def to_html

		<<-HTML
			<a href='#{@url}' target='_blank'>
				<iframe
					src='https://img.poszukaj.se/banners/server/#{id}/small'
					width='650'
					height='130'
					frameborder='0'
					scrolling='no'
				></iframe>
			</a>
		HTML
	end
end
