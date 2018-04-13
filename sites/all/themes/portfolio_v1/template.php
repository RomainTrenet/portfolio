<?php

/**
 * @file
 * This file is empty by default because the base theme chain (Alpha & Omega) provides
 * all the basic functionality. However, in case you wish to customize the output that Drupal
 * generates through Alpha & Omega this file is a good place to do so.
 * 
 * Alpha comes with a neat solution for keeping this file as clean as possible while the code
 * for your subtheme grows. Please read the README.txt in the /preprocess and /process subfolders
 * for more information on this topic.
 */
function portfolio_v1_theme(&$existing, $type, $theme, $path) {
   $hooks['user_login_block'] = array(
     'template' => 'templates/user_bar/user-login-block',
     'render element' => 'form',
   );
   return $hooks;
}


function portfolio_v1_preprocess_html(&$vars) {
	 if (drupal_is_front_page()){
	 	$vars['head_title'] = variable_get('site_slogan')." | ".variable_get('site_name');
	 }
}

function portfolio_v1_preprocess_zone(&$vars) {
	if ($vars['zone']=='content'){
		$vars['title']=drupal_get_title();
		return $vars;
	}
}

function portfolio_v1_preprocess_field(&$variables) {
	if ($variables['element']['#title'] == 'Url projet') {
		$renderedlink = '<a href="'.$variables['element']['#items']['0']['value'].'" target="_blank">Voir le site</a>';
		$variables['renderedlink']=$renderedlink;
	}
}

function portfolio_v1_preprocess_block(&$variables) {
//	echo "<pre>";
//	print_r($variables['block']->title);
//	echo "</pre>";
	
	$blockTitle=strtolower($variables['block']->title);
	$blockTitle=str_replace(' ','_',$blockTitle);
	$blockTitle = stripAccents($blockTitle);
	
	$variables['theme_hook_suggestions'][] = 'block__' . $blockTitle;
	
	$sitemap = "";
	
	//On récupère la page actuelle, nécéssaire pour le menu
	$currentPage = url($_GET['q']);
	
	switch($blockTitle) {
	
		/* Menu principal */
		
		case 'menu_principal':
			//Je récupère le menu de mon site pour le parcourir et créer un menu perso, je compte le nombre de lien de 1er niveau
			$params = array('max_depth' => 3);
			$menuHeader = menu_build_tree('main-menu', $params);
			$menuLongueur=count($menuHeader);
			//$variables['menu'] = $menu;
			
			//Je commence a écrire le Html	
			$html = '<ul class="first-level">';
			
			//variable pour la boucle de premier niveau
			$countFirstLevel=0;
			
			//variable pour la boucle de second niveau
			$countSecondLevel=0;
			
			foreach($menuHeader as $item_menu) { //for each main element
			
				$countSecondLevel=0;//réinitialise le conteur du second niveau pour chaque élément de 1er niveau
	
				//test s'il y a un second niveau avec des liens
				$isSecondLevel = isset($item_menu['below']) && !empty($item_menu['below']);

				//Traitement du cas du firstchild
				$url="";
				$urlTemp=url($item_menu['link']['link_path']);
				$firstchild="%3Cfirstchild%3E";
				if( (substr_count($urlTemp,$firstchild)) == 1){//Si l'url contient <firstchild>, retirer
					$urlTemp=str_replace ($firstchild, "", $urlTemp);
					
					//récupère l'adresse du firstchild
					foreach ($item_menu['below'] as $value){
						$res=$value;
						break;
					}
					if (isset($res)){
						$child=url($res['link']['link_path']);
					}
					if (isset($child)){
						$urlTemp=$child;
					}
				}//Fin Traitement du cas du firstchild
				$url=$urlTemp;
				
				$classMenuFirstL=' class="arrow';
				$titleFirstL='';
				$idFirstL='';
				
				//Si c'est l'onglet de l'accueil, id spécial, pas de titre. Sinon titre.
				if ($item_menu['link']['link_title']=="Home") {
//$idFirstL=' id="home_picto" ';
					$classMenuFirstL.=' home_picto';
					$titleFirstL="";
				}else{
					$titleFirstL=$item_menu['link']['link_title'];
				}
				//$titleFirstL=$item_menu['link']['link_title'];
				
				//Si l'url de premier niveau est la page courrante
				if ($url==$currentPage) {
					$classMenuFirstL.=' selected';
				}
				//Si l'element est le dernier element de premier niveau
				if (($countFirstLevel+1)==$menuLongueur) {
					$classMenuFirstL.=' last';
				}
				
				//$classMenuFirstL.='"'; on le ferme plus loin
				//$titleFirstL.='"';
				$subMenu="";
				
				if (!$isSecondLevel) {//s'il n'y a pas de sous éléments
					$subMenu='</li>';
				}else{//S'il y a un second niveau

					$countSecondLevel=0;//réinitialise le conteur du second niveau pour chaque élément de 1er niveau
					
					$subMenu.= '<div class="wrapper"><ul>';
					$subMenu.= '<li class="second-menu-top"></li>';	
					
					$longueur=count($item_menu['below']);
					
					//Boucle de création des sous menus avec écriture de la classe.
					foreach($item_menu['below'] as $item_submenu) {// pour chaque sous élément
						/*	Gestion des classes du sous-menu	*/
						
						$class=' class="';
//On n'a pas pas besoin de la classe first et last
						
						//Si c'est le premier élément, et qu'il y en a plus d'un
						if ($countSecondLevel==0 && $longueur>1) {
							$class.='first';
						}
						
						//si c'est le dernier
						if(($countSecondLevel+1)==$longueur && $longueur>1){
							$class.='last';
						}
						//si c'est le premier et le dernier (un seul)
						if(($countSecondLevel+1)==$longueur && $longueur==1){
							$class.='first last';
						}

						//Traitement du cas du firstchild
						$urlSubMenu="";
						$urlSubMenuTemp=url($item_submenu['link']['link_path']);
						$firstchild="%3Cfirstchild%3E";
						if( (substr_count($urlSubMenuTemp,$firstchild)) == 1){//Si l'url contient <firstchild>, retirer
							$urlSubMenuTemp=str_replace ($firstchild, "", $urlSubMenuTemp);
							
							//récupère l'adresse du firstchild
							foreach ($item_submenu['below'] as $value){
								$res=$value;
								break;
							}
							if (isset($res)){
								$child=url($res['link']['link_path']);
							}
							if (isset($child)){
								$urlSubMenuTemp=$child;
							}
						}//Fin Traitement du cas du firstchild
						$urlSubMenu=$urlSubMenuTemp;
											
						//Si c'est la page en cours, ajoute de la classe selected
						//$urlSubMenu=url($item_submenu['link']['link_path']);
						
						if ($urlSubMenu==$currentPage) {
							$class.=' selected';
							$classMenuFirstL.=' hasChildSelected"';
						}
						//Fermeture de $class
						if($class!=' class="'){
							$class.='"';//Si y a quelque chose, je ferme la classe
						}else{
							$class='';//S'il n'y a rien, je vide la classe
						}
						
						/*	Ecriture du sous menu	*/
						$subMenu.= '<li'.$class.'>';
						$subMenu.= '<a href="'.$urlSubMenu.'">';
						$subMenu.= $item_submenu['link']['link_title'];
						$subMenu.= '</a>';
						
						//////////////ICI Si le menu a des sous menu
						
						//test s'il y a un second niveau avec des liens
						$isThirdLevel = isset($item_submenu['below']) && !empty($item_submenu['below']);
						
						//$titleFirstL.='"';
						$ThirdMenu="";
						
						if ($isThirdLevel) {//s'il n'y a pas de sous éléments
							$countThirdLevel=0;//réinitialise le conteur du troisième niveau pour chaque élément de 2 niveau
							
							$ThirdMenu.='<div class="wrapper"><ul>';
					
							$longueurThird=count($item_submenu['below']);
							
							//Boucle de création des sous menus avec écriture de la classe.
							foreach($item_submenu['below'] as $item_thirdmenu) {// pour chaque sous élément
								/*	Gestion des classes du sous-menu	*/
								
								$ThirdClass=' class="';
								
								//Si c'est le premier élément, et qu'il y en a plus d'un
								if ($countThirdLevel==0 && $longueurThird>1) {
									$ThirdClass.='first';
								}
								//si c'est le dernier
								if(($countThirdLevel+1)==$longueurThird && $longueurThird>1){
									$ThirdClass.='last';
								}
								//si c'est le premier et le dernier (un seul)
								if(($countThirdLevel+1)==$longueurThird && $longueurThird==1){
									$ThirdClass.='first last';
								}
													
								//Si c'est la page en cours, ajoute de la classe selected
								$urlThirdMenu=url($item_thirdmenu['link']['link_path']);
								if ($urlThirdMenu==$currentPage) {
									$class.=' selected';
									$ThirdClass.=" selected";
									$classMenuFirstL.=' hasChildSelected"';
								}
								//Fermeture de $ThirdClass
								$ThirdClass.='"';
								
								/*	Ecriture du sous menu	*/
												
								$ThirdMenu.= '<li'.$ThirdClass.'>';
								$ThirdMenu.= '<a href="'.$urlThirdMenu.'">';
								$ThirdMenu.= $item_thirdmenu['link']['link_title'];
								$ThirdMenu.= '</a>';
							}
							
							$ThirdMenu.= '</li></ul></div>';
											
							//J'incrémente le nb d'élément de troisième niveau
							$countThirdLevel++;
						
						}
						$subMenu.=$ThirdMenu;
						
						$subMenu.= '</li>';
						
											
						//J'incrémente le nb d'élément de second niveau
						$countSecondLevel++;
					}
					
					//Fermeture du sous menu
					$subMenu.= '<li class="second-menu-bottom"></li>';
					$subMenu.= '</ul></div></li>';
									
				}//fin else (seconde niveau)
				
				//On ferme
				$classMenuFirstL.='"';
				
				$html.= '<li'.$classMenuFirstL.$idFirstL.'><a href="'.$url.'">';     
				$html .= $titleFirstL;
				$html .= '</a>';
				$html .= $subMenu;
				
				//Si c'est l'onglet accueil, on ajoute un chevron
				//if ($idFirstL==' id="home_picto"'){
				//	$html .='<li id="chevron"></li>';
				//}
				
				//J'incrémente le nombre de lien de premier niveau
				$countFirstLevel++;
				
			}//fin boucle
			
			$html.= '<li class="clear"></li>';
			$html.= '</ul>';
			
			//Je créé donc la variable $main_menu_html qui contient le menu
			$variables['main_menu_html'] = $html;
			global $sitemap;
			$sitemap=$html;
		break;
		
		/* Sitemap */
		
		case 'sitemap':
			global $sitemap;
			$variables['sitemap'] = $sitemap;
		break;
		
		/* Logo slogan */
		
		case 'rien':
			
		break;
		
		/* User Bloc Header */
		
	}
	
}
/*** EO BLOCK ***/


function portfolio_v1_menu_tree($variables) {
//	echo "<pre>";
//	print_r($variables);
//	echo "</pre>";
	//print "zeub";
	return '<ul class="menu">' . $variables['tree'] . '<li class="clear"></li></ul>';
}

function portfolio_v1_preprocess_user_login_block(&$vars) {
	$vars['form']['name']['#title'] = t('Nom ou @mail : ');
	$vars['name'] = render($vars['form']['name']);
	$vars['form']['pass']['#title'] = t('Mot de passe : ');
	$vars['pass'] = render($vars['form']['pass']);
	$vars['submit'] = render($vars['form']['actions']['submit']);
	unset($vars['form']['links']);
	$vars['rendered'] = drupal_render_children($vars['form']);
}
/**** UTILS ****/

function stripAccents($string){
	$remplace = array('à'=>'a','á'=>'a','â'=>'a','ã'=>'a','ä'=>'a','å'=>'a','ò'=>'o','ó'=>'o','ô'=>'o','õ'=>'o','ö'=>'o','è'=>'e','é'=>'e','ê'=>'e','ë'=>'e','ì'=>'i','í'=>'i','î'=>'i','ï'=>'i','ù'=>'u','ú'=>'u','û'=>'u','ü'=>'u','ÿ'=>'y','ñ'=>'n','ç'=>'c','ø'=>'0');
    return strtr($string,$remplace);
}
