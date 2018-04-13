<article<?php //print $attributes; ?>>
    <?php
      // We hide the comments and links now so that we can render them later.
      hide($content['comments']);
      hide($content['links']);
?>
	
	<div class="project-pict grid-6 alpha resp-img-father m-b-20">
		<?php 
		 
		if (isset($content['field_image_large'])){
			print render($content['field_image_large']);
		}elseif (isset($content['field_apercu'])){
			print render($content['field_apercu']);
		}
		?>
	</div>
	
	<div class="project-infos grid-6 omega m-b-20">
	
		<?php
		
		if (isset($content['field_date_cr_ation'])){
			print render($content['field_date_cr_ation']);
		}
		
		if (isset($content['field__tat'])){
			print render($content['field__tat']);
		}
		
		if (isset($content['field_technologies'])){
			print render($content['field_technologies']);
		}
		
		if (isset($content['field_module_s_utilis_s_'])){
			print render($content['field_module_s_utilis_s_']);
		}
		?>
		<?php if (isset($content['field_url_projet'])): ?>
			<div class="link-to-site m-b-20">
				<?php print render($content['field_url_projet']); ?>
			</div>
		<?php endif; ?>
		
		<?php
		if (isset($content['body'])){
			print render($content['body']);
		}
		
		//hide($content['field_r_le_s_']);
		//hide($content['field_miniature']);
		  ?>
		  
		 
	      <?php // print render($content);
	    ?>
	</div>
  
<!--	<div class="project-body grid-8 alpha omega">
		
	</div>
 --> 
	<div class="clearfix">
		<?php if (!empty($content['links'])): ?>
			<nav class="links node-links clearfix"><?php print render($content['links']); ?></nav>
		<?php endif; ?>

		<?php print render($content['comments']); ?>
	</div>
</article>