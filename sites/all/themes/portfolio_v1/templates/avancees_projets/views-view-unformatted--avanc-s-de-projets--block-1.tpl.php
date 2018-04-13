<?php
$total = count($rows);
$current = 1;
?>

<?php foreach ($rows as $id => $row): ?>
	<div class="item<?php if ($current==$total){print " last";} ?>">
		<?php print $row; ?>
	</div>
  <?php $current++; ?>
<?php endforeach; ?>
