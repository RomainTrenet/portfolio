<?php if (isset($fields['edit_node']->content)): ?>
	<?php print $fields['edit_node']->content; ?>
<?php endif; ?>

<?php if (isset($fields['title']->content)): ?>
	<div class="title">
		<?php print $fields['title']->content; ?>
	</div>
<?php endif; ?>

<div class="project-content prel">
	<div class="illustration">
		<?php if (isset($fields['field_image_large']->content)): ?>
		<div class="image resp-img-father">
			<?php print $fields['field_image_large']->content; ?>
		</div>
		<?php endif; ?>
	</div>
	
	<div class="sub-info grid-3 alpha omega">
		<div class="inner">
			<?php if (isset($fields['field_date_cr_ation']->content) && !empty($fields['field_date_cr_ation']->content)): ?>
				<div class="date">
					<?php print $fields['field_date_cr_ation']->content; ?>
				</div>
			<?php endif; ?>
			
			<?php if (isset($fields['field__tat']->content)): ?>
				<div class="etat">
					<?php print $fields['field__tat']->content; ?>
				</div>
			<?php endif; ?>
			
			<?php if (isset($fields['field_technologies']->content)): ?>
			<div class="technologies blue-plus-ul">
				<?php print $fields['field_technologies']->content; ?>
			</div>
			<?php endif; ?>
			
			<?php
			global $base_path; 
			global $base_root;
			?>
			
			<?php if (isset($fields['path']->content)): ?>
			<div class="white-btn m-b-10">
				<a class="white-btn-inner" href="<?php print $base_root.$fields['path']->content; ?>">Plus d'infos</a>
			</div>
			<?php endif; ?>
					
			<?php if (isset($fields['field_url_projet']->content)): ?>
			<div class="clear"></div>
			<div class="white-btn">
				<a class="white-btn-inner" href="<?php print $fields['field_url_projet']->content; ?>" target="_blank">Voir le site</a>
			</div>
			<?php endif; ?>
		</div>
	</div>
</div>