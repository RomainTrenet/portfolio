<?php //global $base_url; 
global $base_path; 
global $base_root;
$url =  $base_root.$base_path;
?>

<div<?php print $attributes; ?>>
  <div<?php print $content_attributes; ?>>
    <?php if ($linked_logo_img || $site_name || $site_slogan): ?>
    <div class="branding-data">
      <?php if ($linked_logo_img): ?>
      <div class="logo-img">
        <?php print $linked_logo_img; ?>
      </div>
      <?php endif; ?>
      <?php if ($site_name || $site_slogan): ?>
      <?php $class = $site_name_hidden && $site_slogan_hidden ? ' element-invisible' : ''; ?>
      <hgroup class="site-name-slogan<?php print $class; ?>">        
        
        <?php if ($site_name): ?>
        <?php $class = $site_name_hidden ? ' element-invisible' : ''; ?>
        <?php if ($is_front): ?>        
        <h1 class="site-name<?php print $class; ?>"><img src="<?php print $url; ?>sites/default/files/title_header/dev-drupal.png" alt="<?php print $site_name; ?>" title="<?php print $site_name; ?>"></h1>
        <?php else: ?>
        	<?php //print $base_url." path : ".$base_path." root : ".$base_root; ?>
        <h2 class="site-name<?php print $class; ?>"><a href="<?php print $url; ?>"><img src="<?php print $url; ?>sites/default/files/title_header/dev-drupal.png" alt="<?php print $site_name; ?>" title="<?php print $site_name; ?>"></a></h2>
        <?php endif; ?>
        <?php endif; ?>
        
        <?php if ($site_slogan): ?>
        	<?php $class = $site_slogan_hidden ? ' element-invisible' : ''; ?>
        	<?php if ($is_front): ?>
        		<h6 class="site-slogan<?php print $class; ?>"><img src="<?php print $url; ?>sites/default/files/title_header/romain-trenet.png" alt="<?php print $site_slogan; ?>" title="<?php print $site_slogan; ?>"></h6>
        	<?php else: ?>
        		<h6 class="site-slogan<?php print $class; ?>"><a href="<?php print $url; ?>"><img src="<?php print $url; ?>sites/default/files/title_header/romain-trenet.png" alt="<?php print $site_slogan; ?>" title="<?php print $site_slogan; ?>"></a></h6>
        	<?php endif; ?>
        <?php endif; ?>
        
      </hgroup>
      <?php endif; ?>
      <div class="clear"></div>
    </div>
    <?php endif; ?>
    <?php print $content; ?>
  </div>
</div>