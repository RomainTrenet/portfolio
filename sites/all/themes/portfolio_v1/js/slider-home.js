/*Slider*/

/*Réglages*/
var time=5000; //temps en ms entre deux changement
var interval=500; //vitesse du slider en ms

var sliderId = "#slider_home";
var btnSelector = "#slider_home_list .slider-select"; //class of the buttons
var btnActiveClass = "active"; //active class of the buttons
var containerClass = "#slider_home .long-container"; //for responsive reinitialization
var itemsSelector = "#slider_home .item";
var illustrationCtnrSelector = "#slider_home .item .illustration";
var ratio = 350/620;

/*needed variables*/
var donnees = new myobject();
var timer;

jQuery(document).ready(function($) {
	donnees.total = jQuery(itemsSelector).length;
	
	jQuery(btnSelector).click(function(event) {
		event.preventDefault();
		$this = jQuery(this);
		var index = getButtonIndex($this);
		if (index != donnees.current){
		
			if(donnees.timer_is_on == 1){
				//console.log("timer is on, stop the timer");
				stopTimer();
			}
			donnees.next = index;
			
			if (donnees.active == false) {
				donnees.active = true;
				if (index>donnees.current){
					//console.log("to left");
					animate("left");
				}else{
					//console.log("ro right");
					animate("right");
				}
			}
		}
	});
	
	/*Ecoute le redimensionnement de la page, avec un délai*/
	var resizeTimer;
	jQuery(window).resize(function() {
	    clearTimeout(resizeTimer);
	    resizeTimer = setTimeout(initializeItemsAndContainer, 100);
	});

	//déclenchement automatique
	initializeItemsAndContainer();
});
	
/*initialize la taille du conteneur, et la position abs. des items */
function initializeItemsAndContainer(){
	stopTimer();
	donnees.active = false;
	
	registerItemsWidthAndHeight();
	jQuery(itemsSelector).addClass('pabs');
	
	setWidthsAndHeights();
	setItemsPosition();
	setTimer();
}

/*register height & width of the items*/
function registerItemsWidthAndHeight(){
	donnees.containerWidth = jQuery(sliderId).width();
//	if (jQuery('body').hasClass('responsive-layout-mobile')){
		//alert(Math.round(ratio * donnees.containerWidth));
		donnees.containerHeight = Math.round(ratio * donnees.containerWidth);
		//console.log("width :"+donnees.containerWidth);
//	}else{
	//	donnees.containerHeight = jQuery(illustrationCtnrSelector).height();
//	}
}

function setWidthsAndHeights(){
	jQuery(containerClass).width(donnees.containerWidth);
	jQuery(containerClass).height(donnees.containerHeight);
	jQuery(itemsSelector).height(donnees.containerHeight);
	jQuery(itemsSelector).width(donnees.containerWidth);
//	if (jQuery('body').hasClass('responsive-layout-mobile')){
//		jQuery("#slider_home .sub-info .title-date-etat").width(donnees.containerWidth);	
//	}
	jQuery(sliderId).height(donnees.containerHeight+20);
}

/*return height of the items*/
function setItemsPosition(){
	//set items at the right place
	jQuery(itemsSelector).css({
        left: donnees.containerWidth + "px"
    });
	jQuery(itemsSelector).eq(donnees.current).css({
        left: "0px"
    });
    //Set the btn
    manageButtonActiveClass(donnees.current);
}

/*	Fonctions du timer	*/
function setTimer(){
	//console.log("set timer");
	if (donnees.active == false) {
		donnees.timer_is_on = 1;
		donnees.next = donnees.current + 1;
		timer = setTimeout("onEndTimer()", time);
	}
}
function onEndTimer(){
	stopTimer();
	if (donnees.active == false) {
		moveToLeft();
		//console.log("end timer");
	}
}
function stopTimer(){
	clearTimeout(timer);
	donnees.timer_is_on=0;
	//console.log("stop timer");
}

//Fonction qui gère les index et le lancement
function moveToRight(){
	if (donnees.active == false) {
		donnees.active = true;
		if (donnees.current == 0) {
			donnees.next = donnees.total - 1;
		}
		else {
			donnees.next = donnees.current - 1;
		}
		animate("right");
	}
}

function moveToLeft(){
	if (donnees.active == false) {
		donnees.active = true;
		if ((donnees.current + 1) > (donnees.total - 1)) {
			donnees.next = 0;
		}
		else {
			donnees.next = donnees.current + 1;
		}
		animate("left");
	}
}
//Animations
function animate(sens){
	
	manageButtonActiveClass(donnees.next);
	
	var nextInitialLeft = 0;
	var currentTerminalLeft = 0;
	if (sens == "right"){
		nextInitialLeft = "-"+donnees.containerWidth+"px";
		currentTerminalLeft = donnees.containerWidth+"px";
	}else{
		nextInitialLeft = donnees.containerWidth+"px";
		currentTerminalLeft = "-"+donnees.containerWidth+"px";
	}
		
	jQuery(itemsSelector).eq(donnees.next).css({
		left: nextInitialLeft
	});
	
	jQuery(itemsSelector).eq(donnees.current).animate({
		left: currentTerminalLeft
	}, interval, function() {
	});
	
	jQuery(itemsSelector).eq(donnees.next).animate({
		left: '0'
	}, interval, function() {
		donnees.current = donnees.next;
		donnees.active = false;
		setTimer();
	});
}

//gère la classe active du bouton
function manageButtonActiveClass($index){	//console.log("set : "+$index);
    jQuery("."+btnActiveClass).removeClass(btnActiveClass);
    jQuery(btnSelector).eq($index).addClass(btnActiveClass);
}

//function qui récupère l'id du bouton cliqué
function getButtonIndex($elt){
	return jQuery(btnSelector).index($elt);
}

// OBJET DE VARIABLES DE REGLAGE
function myobject() {
	this.active=false;
	this.total=0;
	this.current=0;//current element
	this.next=0;//next element
	this.clicked = 0;
	this.timer_is_on=0;
	this.containerWidth=0;
	this.containerHeight=0;
}