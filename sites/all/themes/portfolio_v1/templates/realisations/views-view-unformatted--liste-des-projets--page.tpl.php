<?php
$total = count($rows);
$current = 1;
$modulo ;
?>

<?php foreach ($rows as $id => $row): ?>
	<?php
	$class = '';
	if ($current==$total){
		$class .= " last";
	}
	$class = ($current%2)==1 ? " left" : " right";
	
	?>
	<div class="item grid-6 <?php print $class;?>">
		<?php print $row; ?>
	</div>
	
	<?php if(($current%2)==0): ?>
		<div class="clear"></div>
	<?php endif; ?>
	<?php $current++; ?>
<?php endforeach; ?>
