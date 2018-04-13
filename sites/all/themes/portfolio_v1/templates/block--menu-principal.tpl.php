<?php $tag = $block->subject ? 'section' : 'div'; ?>

<<?php print $tag; ?><?php print $attributes; ?>>
	<div id="header_menu" class="block-inner clearfix">
	
		<?php if(isset($main_menu_html)): ?>
	    	<?php print render($main_menu_html); ?>
	    <?php endif; ?>
    
  </div>
</<?php print $tag; ?>>