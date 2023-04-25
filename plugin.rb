# name: Discourse playbase.pro onebox
# about: Adds support for embedding playbase.pro servers within Discourse.
# version: 1.0.4
# authors: riko.dev
# url: https://github.com/rikodev/poszukajse-discourse-onebox

class Onebox::Engine::PoszukajSEOnebox
	include Onebox::Engine
	include Onebox::Engine::StandardEmbed

	REGEX = /^https?:\/\/playbase.pro\/(?:\w+\/?)(\w*.+)\/(\d+)/
	matches_regexp REGEX

	requires_iframe_origins("https://img.playbase.pro")
	always_https

	def id
		@url.scan(REGEX).last[1]
	end
	
	def to_html

		og = get_opengraph

		<<-HTML
			<aside class="onebox allowlistedgeneric" data-onebox-src="#{@url}">
				<header class="source">
					<img src="https://playbase.pro/storage/branding/logo.png" class="site-icon" style="width: auto;height: 18px;">
				</header>
			
				<article class="onebox-body">
					<img src="https://playbase.pro/storage/servers/#{id}.png" class="thumbnail size-resolved onebox-avatar">
					<h3>
						<a href="#{@url}" target="_blank" rel="nofollow ugc noopener" tabindex="-1">#{og.title}</a>
					</h3>
				
					<p>#{og.description}</p>

					<img src="https://img.playbase.pro/banners/server/#{id}/small" style="padding-bottom: 0px;">
				
				</article>
			
				<div style="clear: both"></div>
			
			</aside>
		HTML
	end
end
