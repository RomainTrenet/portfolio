<?php if ($wrapper): ?><div<?php print $attributes; ?>><?php endif; ?>  
  <div<?php print $content_attributes; ?>>    
    <?php if ($breadcrumb): ?>
      <div id="breadcrumb" class="grid-<?php print $columns; ?>"><?php print $breadcrumb; ?></div>
    <?php endif; ?>    
    <?php if ($messages): ?>
      <div id="messages" class="grid-<?php print $columns; ?>"><?php print $messages; ?></div>
    <?php endif; ?>
    	
    	<!-- Titre normalement placé dans region content-->
    	<div class="grid-12">
    		<?php //print render($title_prefix); ?>
			<?php if ($title): ?>
				<?php if (!$is_front): ?>	
					<h1 class="title" id="page-title"><?php print $title; ?></h1>
				<?php endif; ?>
			<?php endif; ?>
			<?php //print render($title_suffix); ?>
		</div>
    
    <?php print $content; ?>
  </div>
<?php if ($wrapper): ?></div><?php endif; ?>