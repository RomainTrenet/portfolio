<?php
/**
 * @file views-view-fields.tpl.php
 * Default simple view template to all the fields as a row.
 *
 * - $view: The view in use.
 * - $fields: an array of $field objects. Each one contains:
 *   - $field->content: The output of the field.
 *   - $field->raw: The raw data for the field, if it exists. This is NOT output safe.
 *   - $field->class: The safe class id to use.
 *   - $field->handler: The Views field handler object controlling this field. Do not use
 *     var_export to dump this object, as it can't handle the recursion.
 *   - $field->inline: Whether or not the field should be inline.
 *   - $field->inline_html: either div or span based on the above flag.
 *   - $field->wrapper_prefix: A complete wrapper containing the inline_html to use.
 *   - $field->wrapper_suffix: The closing tag for the wrapper.
 *   - $field->separator: an optional separator that may appear before a field.
 *   - $field->label: The wrap label text to use.
 *   - $field->label_html: The full HTML of the label to use including
 *     configured element type.
 * - $row: The raw result object from the query, with all data it fetched.
 *
 * @ingroup views_templates
 */
?>
<div class="small-content grid-8 alpha omega">
	<div class="title-date-etat">
		<?php if (isset($fields['title']->content)): ?>
		<div class="title">
			<?php print $fields['title']->content; ?>
		</div>
		<?php endif; ?>
		
		<?php if (isset($fields['field_date_cr_ation']->content) && !empty($fields['field_date_cr_ation']->content)): ?>
			<div class="date">
				<?php print ("(".$fields['field_date_cr_ation']->content).") "; ?>
			</div>
		<?php endif; ?>
	
		<?php if (isset($fields['field__tat']->content)): ?>
			<div class="etat">
				<?php print ("- ".$fields['field__tat']->content); ?>
			</div>
		<?php endif; ?>
		<div class="clear"></div>
	</div>
</div>

<div class="sub-info grid-3 alpha omega">
	<div class="inner">
		<div class="title-date-etat normal-content">
			<?php if (isset($fields['title']->content)): ?>
			<div class="title">
				<?php print $fields['title']->content; ?>
			</div>
			<?php endif; ?>
			
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
			
			<div class="clear"></div>
		</div>
		
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
		<div class="white-btn">
			<a class="white-btn-inner" href="<?php print $base_root.$fields['path']->content; ?>">Plus d'infos</a>
		</div>
		<?php endif; ?>
				
		<?php if (!empty($fields['field_url_projet']->content)): ?>
		<div class="clear"></div>
		<div class="white-btn">
			<a class="white-btn-inner" href="<?php print $fields['field_url_projet']->content; ?>" target="_blank">Voir le site</a>
		</div>
		<?php endif; ?>
	</div>
</div>

<div class="illustration">
	<?php if (isset($fields['field_apercu']->content)): ?>
	<div class="image resp-img-father">
		<?php print $fields['field_apercu']->content; ?>
	</div>
	<?php endif; ?>
</div>