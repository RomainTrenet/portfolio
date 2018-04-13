﻿package galerie {	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.*;	import flash.utils.Dictionary;	//Pour le texte :	import flash.text.TextField;	import flash.text.Font;	import flash.text.TextFormat;	import flash.text.TextFieldType;	//Effet de transition	import fl.transitions.Tween;	import fl.transitions.TweenEvent;	import fl.transitions.easing.Regular;	import flash.net.URLRequest;	import flash.net.URLLoader;		import flash.display.Bitmap;	import flash.display.BitmapData;		import flash.display.Loader;	import fl.motion.MatrixTransformer;	import flash.net.URLLoaderDataFormat;		import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	public class GalerieNew extends MovieClip {				///////		Valeurs Réglage		////////		var tailleLargeur:Number=1100;		var tailleHauteur:Number=580;		var contourGrande:Number=12;		var margeBasse:Number=7;				var tailleMiniatureH:Number=50;//à 90, ça merde		//var tailleMiniatureH:Number=85;		var pourcentageContour:Number=0.15;				var dureeScrollMiniatures:Number=1;				///////		Valeurs Calculées	////////				var hautContMini:Number=Math.floor((1+2*pourcentageContour)*tailleMiniatureH);		var posContMiniY:Number=tailleHauteur-hautContMini-margeBasse;		var ecartImage:Number=(Math.floor((1.5*pourcentageContour*tailleMiniatureH)/2)) * 2;// Pour avoir un ecart d'un nb de px pair et un demi écart sans virgule		var tailleImageH:Number=tailleHauteur-hautContMini-2*contourGrande-margeBasse;		var tailleImageV:Number=tailleLargeur-2*contourGrande;				//DECLARATION DE MES CONTENEURS		//Conteneur principal		public var conteneur:Sprite;		public var conteneurContenu:Sprite;		var conteneurMiniatures:Sprite;		var conteneurLiserais:Sprite;		var conteneurLiserais2:Sprite;		var conteneurGrande:Sprite;		var conteneurMiniaturesRectBlanc:Sprite;		var spriteChargeT:Sprite;		var spriteChargeT2:Sprite;				//	Texte		var texteChargement:TextField;		var styleTexteChargement:TextFormat;		var styleTexteBoutonFermer:TextFormat;		///////	Tween	////////		var _tweens:Dictionary=new Dictionary;		var tweenImages:Tween;		var tweenImages2:Tween;		var tweenGrande:Tween;		var tweenMiniature:Tween;		var tweenSpriteChargeT:Tween;		var tweenBtn:Tween;		var _tweenAlpha:Tween;				//Tableaux		public var tabMiniatures:Array;		public static var tabQuellesImages:Array;		public static var tabQuellesImages2:Array;		public static var tabQuellesImagesPos:Array;		public static var tabQuellesImagesLongueur:Array;				var tabAdresseImageGrande:Array;		var tabAdresseImageGrande2:Array;				var tabRectChargT:Array;		var tabRectFond:Array;				/// Boutons		var texteBoutonFermer:TextField;		public var btnFermer=new BoutonFermer;		public var spriteBtnFermer:Sprite;		public var spriteBtnFermer2:Sprite;				public var btng=new BoutonGauche;		public var btnd=new BoutonDroit;				public var btnNavD=new BtnNavD;		public var btnNavG=new BtnNavG;				///Boucle perso affichage XML		public static var k:Number;		public static var exemple:XML;		public static var nbImage:Number=0;		public static var tabLongueurImage:Array;				//Variable pour les calculs		var futurBoutDeLaDerniereImage:Number=new Number;		var duree:Number=new Number;		var futurBoutDeLaPremiereImage:Number=new Number;		var duree2:Number=new Number;				var testPosPremImg:Number=new Number;		var testPosPremImg2:Number=new Number;				var imageAvantBordure:Number=new Number;		var imageApresBordure:Number=new Number;				var posContMin:Number=0;				//Loader		var grandeLoader:Loader;		var chargeur:URLLoader;				public static var indexQuelleImageGrande:Number;				//Barre progression		var objetActuel:Number=new Number;		var chargeT:Number=new Number;		var progression:Number=new Number;		var avanObjet:Number=new Number;		/////////////////////////////PRINCIPALE///////////////////		public function GalerieNew(adresseXml) {			addEventListener(Event.ADDED_TO_STAGE, init);			k=0;			var fichier:String=adresseXml;						conteneur=new Sprite;			conteneur.graphics.beginFill(0x333333,1);			conteneur.graphics.drawRect(0,0,tailleLargeur,tailleHauteur);			conteneur.graphics.endFill();			conteneurContenu=new Sprite;			conteneurMiniatures=new Sprite;						conteneurMiniaturesRectBlanc=new Sprite;			conteneurLiserais=new Sprite;			conteneurLiserais2=new Sprite;			conteneurGrande=new Sprite;						//////////////////////		Chargement XML		//////////////////////////////						chargeur=new URLLoader();			chargeur.dataFormat=URLLoaderDataFormat.TEXT;			chargeur.addEventListener(Event.COMPLETE, texte1Complet);			chargeur.load(new URLRequest(fichier));						//////////////Boutons			btng.x=50;			btng.y=posContMiniY-20-btng.height;			btng["debut"]="yes";			btng.alpha=0.2;			btnd.x=tailleLargeur-50-btnd.width;			btnd.y=btng.y;			btnd.alpha=0.2;			btng["debut"]="yes";						btnNavD.x=tailleLargeur;			btnNavD.y=conteneurLiserais.y+1;			btnNavD["actif"]="no";			btnNavD["name"]="btnNavD";			btnNavG.y=btnNavD.y;			btnNavG.x=-btnNavG.weight;			btnNavG["actif"]="no";			btnNavG["name"]="btnNavG";								/////////////Liserais Bas			conteneurLiserais.y=posContMiniY;			conteneurLiserais.graphics.lineStyle(1,0xffffff,100);			conteneurLiserais.graphics.lineTo(tailleLargeur,0);			conteneurLiserais2.y=tailleHauteur-margeBasse;			conteneurLiserais2.graphics.lineStyle(1,0xffffff,100);			conteneurLiserais2.graphics.lineTo(tailleLargeur,0);									//Fond Gris Conteneur Miniatures			spriteChargeT2=new Sprite;			spriteChargeT2.graphics.clear();			spriteChargeT2.graphics.beginFill(0x868686,1);			spriteChargeT2.graphics.drawRect(0,posContMiniY,tailleLargeur,hautContMini);			spriteChargeT2.graphics.endFill();			spriteChargeT2.alpha=0.70;						conteneurMiniatures.x=0;			conteneurMiniatures.y=posContMiniY+Math.floor(pourcentageContour*tailleMiniatureH);						//Tableaux			tabMiniatures=new Array;			tabLongueurImage=new Array;			tabQuellesImages=new Array;			tabQuellesImages2=new Array;			tabQuellesImagesPos=new Array;			tabQuellesImagesLongueur=new Array;			tabAdresseImageGrande=new Array;			tabAdresseImageGrande2=new Array;						//Nombres			indexQuelleImageGrande=new Number;			///////		Barre chargement		////////			///Chargement			tabRectChargT= new Array();			tabRectFond=new Array();			spriteChargeT=new Sprite();						//Textes			texteChargement=new TextField;			styleTexteChargement=new TextFormat;			styleTexteChargement.font = new arvo().fontName;			styleTexteChargement.size=10;			styleTexteChargement.color="0xFFFFFF";			styleTexteChargement.align="left";						texteChargement.width=240;			texteChargement.selectable=false;			texteChargement.height=40;			texteChargement.wordWrap = true;			texteChargement.embedFonts=true;			texteChargement.x=(tailleLargeur-texteChargement.width)/2+37;			texteChargement.y=conteneurMiniatures.y-35;						for (var h:int=0; h <12; h++) {								var monBitmapData:BitmapData=new Barre(0,0);				var barre:Bitmap=new Bitmap(monBitmapData);								tabRectFond[h]=new Sprite;				tabRectFond[h].alpha=0.3;				tabRectFond[h].addChild(barre);								spriteChargeT.addChild(tabRectFond[h]);				tabRectFond[h].x=tailleLargeur/2+((Math.cos(((Math.PI*2)/12))*100)/10);				tabRectFond[h].y=tailleHauteur-63+((Math.sin(((Math.PI*2)/12))*100/10));				rotationControle((30*h)-(11+120),tabRectFond[h]);				tabRectFond[h].rotation+=40;			}			for (var i:int=0; i <12; i++) {								var monBitmapData2:BitmapData=new Barre(0,0);				var barre2:Bitmap=new Bitmap(monBitmapData2);								tabRectChargT[i]=new Sprite;				tabRectChargT[i].alpha=0;				tabRectChargT[i].addChild(barre2);				spriteChargeT.addChild(tabRectChargT[i]);				tabRectChargT[i].x=tailleLargeur/2+((Math.cos(((Math.PI*2)/12))*100)/10);				tabRectChargT[i].y=tailleHauteur-63+((Math.sin(((Math.PI*2)/12))*100/10));				rotationControle((30*i)-(11+120),tabRectChargT[i]);				tabRectChargT[i].rotation+=40;			}			///////		Bouton Fermer		////////					styleTexteBoutonFermer=new TextFormat;			styleTexteBoutonFermer.font = new arvo().fontName;			styleTexteBoutonFermer.size=16;			styleTexteBoutonFermer.color="0xFFFFFF";			styleTexteBoutonFermer.align="left";					btnFermer.x=tailleLargeur-btnFermer.width-10;			btnFermer.y=25;			spriteBtnFermer=new Sprite;			spriteBtnFermer.graphics.beginFill(0x333333, 1);			spriteBtnFermer.graphics.drawRect(btnFermer.x-70,btnFermer.y-5,90,26);			spriteBtnFermer.graphics.endFill();			spriteBtnFermer.buttonMode=true;						spriteBtnFermer2=new Sprite;			spriteBtnFermer2.graphics.beginFill(0x333333, 1);			spriteBtnFermer2.graphics.drawRect(btnFermer.x-70,btnFermer.y-5,90,26);			spriteBtnFermer2.graphics.endFill();			spriteBtnFermer2.buttonMode=true;			spriteBtnFermer2.alpha=0;			spriteBtnFermer2.addEventListener(MouseEvent.CLICK, fermerGalerie);						texteBoutonFermer=new TextField;			texteBoutonFermer.text="Retour";			texteBoutonFermer.height=40;			texteBoutonFermer.embedFonts=true;			texteBoutonFermer.setTextFormat(styleTexteBoutonFermer);			texteBoutonFermer.y=btnFermer.y-5;			texteBoutonFermer.x=btnFermer.x-100+15+20;			texteBoutonFermer.selectable=false;			///////		ARBORESCENCE des SPRITES		////////			addChild(conteneur);			conteneur.addChild(conteneurContenu);			conteneurContenu.addChild(conteneurMiniatures);			conteneurContenu.addChild(texteChargement);			conteneurMiniatures.addChild(conteneurMiniaturesRectBlanc);			conteneurContenu.addChild(spriteChargeT2);			conteneurContenu.addChild(spriteChargeT);			conteneurContenu.addChild(conteneurLiserais);			conteneurContenu.addChild(conteneurLiserais2);			conteneurContenu.addChild(conteneurGrande);			conteneurContenu.addChild(btng);			conteneurContenu.addChild(btnd);						addChild(spriteBtnFermer);			addChild(btnFermer);			addChild(texteBoutonFermer);			addChild(spriteBtnFermer2);		}		///////		BOUCLE CHARGEMENT		////////				private function texte1Complet(e:Event){			try{				exemple=new XML(e.target.data);				nbImage=exemple.petite.image.length();								for (var m:int=0; m <nbImage; m++) {					tabMiniatures[m]=new Array;					tabMiniatures[m][2]=new Loader;				}				compte();							}catch(e:TypeError){				trace ("XML mal formaté");			}		}				private function compte(){			tabAdresseImageGrande[k]=new String;			tabAdresseImageGrande[k]=exemple.child(0).image[k].child(0).toString();			tabMiniatures[k][2].name=k;			tabMiniatures[k][2].contentLoaderInfo.addEventListener(Event.COMPLETE, lien);			tabMiniatures[k][2].contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressListener);			tabMiniatures[k][2].load(new URLRequest(exemple.child(0).image[k].child(0).toXMLString()));			tabMiniatures[k][2].alpha=0;						tabMiniatures[0][2].x=ecartImage/2;		}				private function lien(e:Event){			tabMiniatures[k][2].height=tailleMiniatureH;			tabMiniatures[k][2].scaleX=tabMiniatures[k][2].scaleY;			tabMiniatures[k][2].width=Math.round(tabMiniatures[k][2].width);						conteneurMiniatures.addChild(tabMiniatures[k][2]);			for (var g:int=0; g <12;g++) {				tabRectChargT[g].alpha=0;			}						tweenMiniature=new Tween(tabMiniatures[k][2], "alpha" , Regular.easeInOut, tabMiniatures[k][2].alpha, 1, 0.3, true);			_tweens[tweenMiniature] = true;			tweenMiniature.addEventListener(TweenEvent.MOTION_FINISH, supTween);						tabMiniatures[k][2].contentLoaderInfo.removeEventListener(Event.COMPLETE, lien);			tabMiniatures[k][2].contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressListener);			tabMiniatures[k][2].addEventListener(MouseEvent.CLICK, appelerGrande);						k+=1;			if (k<nbImage){				var index:int=e.target.loader.contentLoaderInfo.loader.name;				if (k>=1){					tabMiniatures[k][2].x=tabMiniatures[k-1][2].x+tabMiniatures[k-1][2].width+ecartImage;				}				compte();			}			if (k==nbImage-1){				if ((tabMiniatures[nbImage-1][2].x+tabMiniatures[nbImage-1][2].width+conteneurMiniatures.x)>tailleLargeur-ecartImage/2){											btnNavD.x=tailleLargeur;					btnNavD.y=conteneurLiserais.y+1;					btnNavD.buttonMode=true;					btnNavD.addEventListener(MouseEvent.CLICK, gogodroite);					btnNavG.y=btnNavD.y;					btnNavG.x=-btnNavG.width;					btnNavG.buttonMode=true;					btnNavG.addEventListener(MouseEvent.CLICK, gogogauche);									conteneurContenu.addChild(btnNavD);					conteneurContenu.addChild(btnNavG);					tweenBtnNav1(btnNavD,true);					btnNavD["actif"]="yes";				}								conteneurContenu.swapChildren(conteneurMiniatures, spriteChargeT2);				spriteChargeT2.alpha=0.4;				indexQuelleImageGrande=0;				affGrande();			}			if (k==nbImage){				conteneurContenu.removeChild(texteChargement);				spriteChargeT.y=-262;								if (nbImage>1){					btnd.buttonMode=true;					btnd["name"]="btnd";					btnd["actif"]="yes";					btnd.alpha=1;					btnd.addEventListener(MouseEvent.CLICK, affGrandeClic);										btng["name"]="btng";					btng["actif"]="no";					btng.alpha=0.2;					btng.addEventListener(MouseEvent.CLICK, affGrandeClic);				}			}						if (nbImage==1){				conteneurContenu.swapChildren(conteneurMiniatures, spriteChargeT2);				spriteChargeT2.alpha=0.4;									indexQuelleImageGrande=0;				affGrande();			}		}		///////		DEPLACEMENT VERS DROITE		////////				private function gogodroite(e:MouseEvent){			var valeurDeplacement:Number=0;			var ecartImageDerImage:Number;						for (var ll:int=0; ll <nbImage;ll++) {				var _positionAffichage=(tabMiniatures[ll][2].x+conteneurMiniatures.x);				var _boutImage=_positionAffichage+tabMiniatures[ll][2].width;								if (_positionAffichage<tailleLargeur){					imageAvantBordure=ll;				}				if (_boutImage>tailleLargeur){					imageApresBordure=ll;					break;				}			}						//Je calcule l'écart entre l'image sur la bordure et la dernière image			ecartImageDerImage=tabMiniatures[nbImage-1][2].x+tabMiniatures[nbImage-1][2].width-tabMiniatures[imageAvantBordure][2].x;						indexQuelleImageGrande=imageAvantBordure;			affGrande();						if (ecartImageDerImage>(tailleLargeur-ecartImage)){				valeurDeplacement=tabMiniatures[imageAvantBordure][2].x+conteneurMiniatures.x-ecartImage/2;				duree=0.5;			}else{				valeurDeplacement=(tabMiniatures[nbImage-1][2].x+tabMiniatures[nbImage-1][2].width)  -  (tabMiniatures[imageAvantBordure][2].x+tabMiniatures[imageAvantBordure][2].width);				duree=Math.floor((0.5* (valeurDeplacement/ (tailleLargeur-ecartImage) ) *100))/100;			}						posContMin=conteneurMiniatures.x-valeurDeplacement;						testBoutonDroit();			testBoutonGauche();						gogoTween();		}		///////		DEPLACEMENT VERS GAUCHE		////////				private function gogogauche(e:MouseEvent){						var valeurDeplacement:Number=0;			var ecartImageDerImage:Number;			var quelImage:Number;						for (var ll:int=0; ll <nbImage;ll++) {				var _positionAffichage=(tabMiniatures[ll][2].x+conteneurMiniatures.x);				var _boutImage=_positionAffichage+tabMiniatures[ll][2].width;								if (_boutImage>0){					//Si l'image concernée est entièrement visible, on prend celle d'avant. Sinon on la prend.					if ((_positionAffichage-ecartImage/2)>=0){						quelImage=ll-1;					}else{						quelImage=ll;					}					break;				}			}						indexQuelleImageGrande=quelImage;			//affGrande();						/*valeurDeplacement=tailleLargeur-tabMiniatures[quelImage][2].width-ecartImage;			var difference:Number=conteneurMiniatures.x+valeurDeplacement;			duree=0.5;*/						/*if (difference>=0){				var ancienValeurDeplacement:Number=valeurDeplacement;				valeurDeplacement-=difference;				duree=Math.floor((0.5* (valeurDeplacement/ancienValeurDeplacement) *100))/100;			}*/									//1) Je place l'image correctement			affGrande();						//2) je calcule la difference			valeurDeplacement=tailleLargeur-tabMiniatures[quelImage][2].width-ecartImage;			var difference:Number=conteneurMiniatures.x+valeurDeplacement;			duree=0.5;									if (difference>=0){				var ancienValeurDeplacement:Number=valeurDeplacement;				valeurDeplacement-=difference//;+difference2;				duree=Math.floor((0.5* (valeurDeplacement/ancienValeurDeplacement) *100))/100;			}						posContMin=conteneurMiniatures.x+valeurDeplacement;						testBoutonDroit();			testBoutonGauche();						gogoTween();		}		///////		gogotween		////////				private function gogoTween(){			tweenImages=new Tween(conteneurMiniatures, "x" , Regular.easeOut, conteneurMiniatures.x, posContMin, duree, true);			_tweens[tweenImages] = true;			tweenImages.addEventListener(TweenEvent.MOTION_FINISH, supTween);		}		///////		TEST BOUTON DEPLACEMENT		////////		function testBoutonDroit(){			var posDerMinX:Number=tabMiniatures[nbImage-1][2].x;			var largeurDerMin:Number=tabMiniatures[nbImage-1][2].width;			var posAffichage:Number=posDerMinX+largeurDerMin+posContMin;			//Test si le bout de la dernière image dépasse la zone d'affichage : pour savoir si on affiche le bouton gauche			if ( (posAffichage>tailleLargeur)	&&	btnNavD["actif"]=="no"){				//Si le bouton de gauche est inactif, on l'affiche				tweenBtnNav1(btnNavD,true);				btnNavD["actif"]="yes";			}						//Si c'est la dernière image qui est au bout, ou si la dernière image est sélectionnée;			if (	( posAffichage==(tailleLargeur-ecartImage/2)	||	indexQuelleImageGrande==(nbImage-1) )	&&	btnNavD["actif"]=="yes"){				tweenBtnNav1(btnNavD,false);				btnNavD["actif"]="no";			}		}				function testBoutonGauche(){			if (posContMin<0 && btnNavG["actif"]=="no"){				tweenBtnNav1(btnNavG,true);				btnNavG["actif"]="yes";			}			if (posContMin==0 && btnNavG["actif"]=="yes"){				tweenBtnNav1(btnNavG,false);				btnNavG["actif"]="no";			}		}				function tweenBtnNav1(elt:Sprite,apparition:Boolean){			if (elt["name"]=="btnNavD"){				if (apparition==true&&elt["actif"]=="no"){					tweenBtnNav2(elt,-elt.width);				}else if (apparition==false&&elt["actif"]=="yes"){					tweenBtnNav2(elt,+elt.width);				}			}else{				if (apparition==true&&elt["actif"]=="no"){					tweenBtnNav2(elt,+elt.width);				}else{					tweenBtnNav2(elt,-elt.width);				}			}		}		function tweenBtnNav2(elt:Sprite,deplT:Number){			tweenBtn=new Tween(elt, "x" , Regular.easeOut, elt.x, (elt.x+deplT), 0.3, true);			_tweens[tweenBtn] = true;			tweenBtn.addEventListener(TweenEvent.MOTION_FINISH, supTween);		}		///////		APPELER GRANDE		////////				private function appelerGrande(e:MouseEvent){			indexQuelleImageGrande=e.target.name;						affGrande();			posContMin=conteneurMiniatures.x;			testBoutonDroit();			testBoutonGauche();						if (nbImage>1){				if (indexQuelleImageGrande==0){					//image de gauche					if (btng["actif"]=="yes"){						switchActivatedBtn(btng);					}				}				if (indexQuelleImageGrande>0&&indexQuelleImageGrande+1<nbImage){					//image au centre					if (btng["actif"]=="no"){						switchActivatedBtn(btng);					}					if (btnd["actif"]=="no"){						switchActivatedBtn(btnd);					}				}				if (indexQuelleImageGrande+1==nbImage){					//image de droite					if (btnd["actif"]=="yes"){						switchActivatedBtn(btnd);					}					if (btng["actif"]=="no"){						switchActivatedBtn(btng);					}				}			}		}		///////		DEPLACEMENT PAR FLECHE CLAVIER		////////				private function affGrandeFleche(evt:KeyboardEvent):void{			switch(evt.keyCode){				case Keyboard.LEFT:				affGrandeDep("btng");				break;				case Keyboard.RIGHT:				affGrandeDep("btnd");				break;			}		}				private function affGrandeClic(e:MouseEvent){			affGrandeDep(e.target["name"]);		}				private function affGrandeDep(sens:String){			if (sens=="btnd"){				if(indexQuelleImageGrande+2<nbImage){					//on peut a droite					indexQuelleImageGrande+=1;					if (btng["actif"]=="no"){						switchActivatedBtn(btng);					}				}else if(indexQuelleImageGrande+1<nbImage){					//ca sera la derniere a droite					indexQuelleImageGrande+=1;					switchActivatedBtn(btnd);				}else{					return;//pour eviter affGrande(); à la fin				}							}else if(sens=="btng"){				if (indexQuelleImageGrande>1){					//on peut a gauche					indexQuelleImageGrande-=1;					if (btnd["actif"]=="no"){						switchActivatedBtn(btnd);					}				}else if (indexQuelleImageGrande==1){					//ca sera la derniere a gauche					indexQuelleImageGrande-=1;					switchActivatedBtn(btng);				}else{					return;//pour eviter affGrande(); à la fin				}			}			affGrande();			posContMin=conteneurMiniatures.x;						testBoutonDroit();			testBoutonGauche();		}				private function testImageSurlignee(){			//On teste si l'image sélectionnée par clic ou fleche du clavier n'est pas à l'écran			var posImageGauche:Number=tabMiniatures[indexQuelleImageGrande][2].x+conteneurMiniatures.x;			var posImageDroite:Number=tabMiniatures[indexQuelleImageGrande][2].x+conteneurMiniatures.x+tabMiniatures[indexQuelleImageGrande][2].width;			//	Test position image surlignée			if (posImageGauche<ecartImage/2){				conteneurMiniatures.x+=-posImageGauche+ecartImage/2;			}else if (posImageDroite>tailleLargeur){				var result:Number=(tabMiniatures[indexQuelleImageGrande][2].x+tabMiniatures[indexQuelleImageGrande][2].width - (tailleLargeur-conteneurMiniatures.x));				conteneurMiniatures.x-=result+ecartImage/2			}		}		///////		FONCTIONS GERANT LE CLIC SUR LES BOUTONS BLANCS DROIT ET GAUCHE		////////						private function switchActivatedBtn(sprite:Sprite){			if (sprite["actif"]=="yes"){				sprite["actif"]="no";				testActivated(sprite);			}else{				sprite["actif"]="yes";				testActivated(sprite);			}		}		private function testActivated(sprite:Sprite){			if (sprite["actif"]=="yes"){				sprite.alpha=1;				sprite.buttonMode=true;			}			if (sprite["actif"]=="no"){				sprite.alpha=0.2;				sprite.buttonMode=false;			}		}		///////		FONCTION GERANT LE CLIC SUR IMAGE		////////				private function affGrande(){			testImageSurlignee();						spriteChargeT.alpha=1;			conteneurGrande.alpha=0;			tabAdresseImageGrande2=tabAdresseImageGrande[indexQuelleImageGrande].split("mini");			var adresseNouveauFichier:String=tabAdresseImageGrande2[0]+"grande"+tabAdresseImageGrande2[1];			grandeLoader=new Loader;			grandeLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, affGrande2);			grandeLoader.contentLoaderInfo.addEventListener(Event.OPEN, remettreChargeTDefaut);			grandeLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, chargerGrande);			grandeLoader.load(new URLRequest(adresseNouveauFichier));		}		private function affGrande2(e:Event){			spriteChargeT.alpha=0;						for (var w=0; w <objetActuel; w++) {				tabRectChargT[w].alpha=1;			}						ViderConteneur(conteneurGrande);			var ratioGrande:Number=grandeLoader.width/grandeLoader.height;						var largeur:Number=Math.round(tailleImageH*ratioGrande);							if (largeur>tailleImageV){				grandeLoader.width=tailleImageV;				grandeLoader.scaleY=grandeLoader.scaleX;				grandeLoader.height=Math.round(grandeLoader.height);								conteneurGrande.x=contourGrande;				conteneurGrande.y=(tailleImageH-grandeLoader.height)/2+contourGrande;			}else if(grandeLoader.height!=tailleImageH){				grandeLoader.height=tailleImageH;				grandeLoader.scaleX=grandeLoader.scaleY;				grandeLoader.width=Math.round(grandeLoader.width);								conteneurGrande.y=contourGrande;				conteneurGrande.x=(tailleLargeur-grandeLoader.width)/2;			}										//Si la hauteur n'est pas plus grande que tailleImageH);						conteneurGrande.addChild(grandeLoader);						tweenGrande=new Tween(conteneurGrande, "alpha" , Regular.easeInOut, conteneurGrande.alpha, 1, 0.2, true);			_tweens[tweenGrande] = true;			tweenGrande.addEventListener(TweenEvent.MOTION_FINISH, supTween);						var posRectBlancX:Number=tabMiniatures[indexQuelleImageGrande][2].x-3;			var posRectBlancY:Number=tabMiniatures[indexQuelleImageGrande][2].y-3;			var longRectBlanc:Number=tabMiniatures[indexQuelleImageGrande][2].width+6;			var hautRectBlanc:Number=tabMiniatures[indexQuelleImageGrande][2].height+6;						conteneurMiniaturesRectBlanc.graphics.clear();			conteneurMiniaturesRectBlanc.graphics.beginFill(0xffffff,1);			conteneurMiniaturesRectBlanc.graphics.lineStyle(3, 0xffffff);			conteneurMiniaturesRectBlanc.graphics.drawRoundRect(posRectBlancX, posRectBlancY, longRectBlanc, hautRectBlanc, 3);			conteneurMiniaturesRectBlanc.graphics.endFill();		}				private function chargerGrande(e:ProgressEvent){			if (e.bytesLoaded){					chargeT= e.bytesLoaded / e.bytesTotal;										progression=(tabRectChargT.length*chargeT);					objetActuel=(Math.floor(progression));					if (objetActuel<12) {						avanObjet=(progression)-(objetActuel);						tabRectChargT[(objetActuel)].alpha=avanObjet;						for (var v=0; v <objetActuel; v++) {							tabRectChargT[v].alpha=1;						}					}							}		}		///////		ELEMENTS CHARGEMENT		////////						private function remettreChargeTDefaut(e:Event){			for (var t=0; t <objetActuel; t++) {				tabRectChargT[t].alpha=0;			}		}				private function progressListener(e:ProgressEvent) {							if (e.bytesLoaded){				chargeT= e.bytesLoaded / e.bytesTotal;				if (k<nbImage+1){					texteChargement.text=("Chargement de l'image "+(k+1)+" sur "+nbImage);					texteChargement.setTextFormat(styleTexteChargement);				}								progression=(tabRectChargT.length*chargeT);				objetActuel=(Math.floor(progression));				if (objetActuel<12) {					avanObjet=(progression)-(objetActuel);					tabRectChargT[(objetActuel)].alpha=avanObjet;					for (var u=0; u <objetActuel; u++) {						tabRectChargT[u].alpha=1;					}				}			}		}				function rotationControle(degre,objet) {			var matrice = objet.transform.matrix;			MatrixTransformer.rotateAroundExternalPoint(matrice,tailleLargeur/2,tailleHauteur-63,degre);			objet.transform.matrix = matrice;		}		///////		FONCTIONS UTILES		////////				private function supTween(event:TweenEvent) {			var tween:Tween=event.target  as  Tween;			delete _tweens[tween];		}				private function ViderConteneur(nomConteneur:Sprite) {			var nbDelements:int=nomConteneur.numChildren;			for (var i:int=0; i < nbDelements; i++) {				nomConteneur.removeChildAt(0);			}		}				function tweenAlpha(elt:Sprite,valeurOrig:Number,valeurFin:Number){			_tweenAlpha=new Tween(elt, "alpha" , Regular.easeOut, valeurOrig, valeurFin, 2, true);			_tweens[_tweenAlpha] = true;			_tweenAlpha.addEventListener(TweenEvent.MOTION_FINISH, supTween);		}		///////		OUVERTURE FERMETURE		////////				private function fermerGalerie(e:MouseEvent){			ViderConteneur(this);			stage.removeEventListener(KeyboardEvent.KEY_DOWN, affGrandeFleche);		}				private function init(e:Event){			stage.addEventListener(KeyboardEvent.KEY_DOWN, affGrandeFleche);			removeEventListener(Event.ADDED_TO_STAGE, init);		}	}}