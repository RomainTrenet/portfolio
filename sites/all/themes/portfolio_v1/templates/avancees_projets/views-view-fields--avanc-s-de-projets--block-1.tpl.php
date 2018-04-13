<div class="sub-info grid-4 alpha omega">
		
	<?php if (isset($fields['field_miniature']->content)): ?>
		<div class="resp-img-father grid-1 alpha fleft">
			<?php print $fields['field_miniature']->content; ?>
		</div>
	<?php endif; ?>
	
	<div class="title grid-3 alpha fleft">
		<?php if (isset($fields['field_projet_li_']->content)): ?>
			<?php print $fields['field_projet_li_']->content; ?>
		<?php endif; ?>
		
		<?php if (isset($fields['created']->content)): ?>
		<div class="date">
			<?php print $fields['created']->content; ?>
		</div>
		<?php endif; ?>
	</div>
	
	<div class="clear"></div>
	
	<?php
	global $base_path; 
	global $base_root;
	?>
		
	<?php if (isset($fields['body']->content)): ?>
	<div class="body">
		<?php print $fields['body']->content; ?>
		<?php if (isset($fields['path']->content)): ?>
			<a href="<?php print ($base_root.$fields['path']->content); ?>">Plus d'infos</a>
		<?php endif; ?>
	</div>
	<?php endif; ?>
	
	<!--< ? php if (isset($fields['path']->content)): ?>
	<div class="black-btn m-b-10">
		<a class="black-btn-inner" href="<?php print ($base_root.$fields['path']->content); ?>">Plus d'infos</a>
	</div>
	<div class="clear"></div>
	< ? php endif; ?>-->
			
	<?php if (isset($fields['field_url_projet']->content)): ?>
	<div class="black-btn">
		<a class="black-btn-inner" href="<?php print $fields['field_url_projet']->content; ?>" target="_blank">Voir le site</a>
	</div>
	<div class="clear"></div>
	<?php endif; ?>
	
</div>
<div class="clear"></div>