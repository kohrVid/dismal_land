$(window).scroll(function (){
  if ($(window).scrollTop() > 382) {
    $("#nav").css("top", "0").css("position", "fixed");
  } else {
    $("#nav").css("top", "0").css("position", "relative").css("line-height", "2rem");
  }
});
