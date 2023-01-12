# name: Discourse poszukaj.se onebox
# about: Adds support for embedding poszukaj.se servers within Discourse.
# version: 1.0.2
# authors: riko.dev
# url: https://github.com/rikodev/poszukajse-discourse-onebox

class Onebox::Engine::PoszukajSEOnebox
	include Onebox::Engine
	include Onebox::Engine::StandardEmbed

	REGEX = /^https?:\/\/poszukaj.se\/(?:\w+\/?)(\w*.+)\/(\d+)/
	matches_regexp REGEX

	requires_iframe_origins("https://img.poszukaj.se")
	always_https

	def id
		@url.scan(REGEX).last[1]
	end
	
	def to_html

		<<-HTML
			<a href='#{@url}' target='_blank' style='display: block'>
				<iframe
					src='https://img.poszukaj.se/banners/server/#{id}/small'
					width='100%'
					height='130'
					frameborder='0'
					scrolling='no'
					style='pointer-events: none'
				></iframe>
			</a>
		HTML
	end
end
