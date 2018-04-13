<?php $tag = $block->subject ? 'section' : 'div'; ?>
<<?php print $tag; ?><?php print $attributes; ?>>
	<div class="block-inner clearfix">
		<div<?php print $content_attributes; ?>>
			<?php print $sitemap; ?>
		</div>
	</div>
</<?php print $tag; ?>>