<div id="slider_home" class="<?php print $classes; ?> grid-8 alpha omega">
	<?php if ($rows): ?>
    <div class="long-container view-content clearfix">
      <?php print $rows; ?>
    </div>
    <?php endif; ?>
</div>

<?php
// $viewname = 'liste_des_projets';
// $display = 'puces';
// print views_embed_view ($viewname, $display);
?>

<div class="black-btn slider-btn-all">
	<a class="black-btn-inner" href="<?php print base_path().drupal_get_path_alias("node/5") ?>" target="_blank">Toutes les réalisations</a>
</div>