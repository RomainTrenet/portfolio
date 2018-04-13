<div id="user-login-block-form-fields" class="fright">
	<?php print $name; // Display username field ?>
	<?php print $pass; // Display Password field ?>
	<div class="edit-submit-wrapper"><?php print $submit; // Display submit button ?></div>
	<?php print $rendered; // Display hidden elements (required for successful login) ?>
	<div class="account-links fleft">
		<a href="/user/register">S'inscrire</a>     <a href="/user/password">Mot de passe oublié ?</a>
	</div>
	<div class="clear"></div>
</div>
<div class="clear"></div>